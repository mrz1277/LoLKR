//
//  ViewController.m
//  LoLKR
//
//  Created by Jaesung Koo on 3/28/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "ViewController.h"
#import <PromiseKit.h>
#import "ITSwitch.h"

@implementation ViewController {
    
    __weak IBOutlet ITSwitch *itSwitch;
    __weak IBOutlet NSButton *patchAllButton;
    __weak IBOutlet NSProgressIndicator *progress;
    __unsafe_unretained IBOutlet NSTextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [progress stopAnimation:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runAllScripts:) name:@"runAllScript" object:nil];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    // check nginx is on
//    itSwitch.enabled = NO;
}

- (IBAction)switchValueChanged:(id)sender {
    ITSwitch *switchControl = (ITSwitch *)sender;
    if (!switchControl.isOn) {
        NSAlert *alert = [NSAlert new];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert setMessageText:@"주의"];
        [alert setInformativeText:@"자동 업데이트를 허용하면 한국 서버 클라이언트가 업데이트 됩니다. 북미 서버 기준으로 한국 서버와 버전이 다르면 업데이트가 정상적으로 진행됩니다."];
        [alert addButtonWithTitle:@"자동 업데이트 허용"];
        [alert addButtonWithTitle:@"취소"];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertSecondButtonReturn) {
                [switchControl setOn:YES];
            } else {
                [self runScript:@"update" arguments:@[@"on",
                                                      [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                                      [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"],
                                                      [[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"]]];
            }
        }];
    } else {
        [self runScript:@"update" arguments:@[@"off",
                                              [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                              [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"],
                                              [[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"]]];
    }
}

- (void)runAllScripts:(NSNotification *)noti {
    patchAllButton.enabled = NO;
    progress.hidden = NO;
    [progress startAnimation:nil];
    
    dispatch_promise(^{
        if ([[[noti userInfo] objectForKey:@"install_nginx"] boolValue]) {
            return [self runScript:@"1_nginx" arguments:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                                          [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"]]];
        } else {
            return [NSNumber numberWithInt:0];
        }
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            return [self runScript:@"2_download_versions" arguments:nil];
        } else {
            return [NSNumber numberWithInt:-1];
        }
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            NSNumber *status3 = [self runScript:@"3_lol" arguments:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"],
                                                                     [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"]]];
            
            if ([status3 intValue] == 0) {
                textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            }
        }
    }).finally(^{
        [progress stopAnimation:nil];
        patchAllButton.enabled = YES;
    });
}

- (NSNumber *)runScript:(NSString *)scriptName arguments:(NSArray *)arguments {
    textView.string = [textView.string stringByAppendingString:[NSString stringWithFormat:@"%@.sh\n", scriptName]];
    
    NSString *scriptFile = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"sh"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:[NSString stringWithFormat:@"\"%@\"", scriptFile]];
    [task setArguments:arguments];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    [[pipe fileHandleForReading] waitForDataInBackgroundAndNotify];
    [[NSNotificationCenter defaultCenter] addObserverForName:NSFileHandleDataAvailableNotification object:[pipe fileHandleForReading] queue:nil usingBlock:^(NSNotification *notification){
        //
        NSData *output = [[pipe fileHandleForReading] availableData];
        NSString *outStr = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
        //
        if ([outStr length] > 0) {
            textView.string = [textView.string stringByAppendingString:[NSString stringWithFormat:@"\n%@", outStr]];
            [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
        }
        //
        [[pipe fileHandleForReading] waitForDataInBackgroundAndNotify];
    }];
    
    [task launch];
    [task waitUntilExit];
    
    return [NSNumber numberWithInt:[task terminationStatus]];
}

@end

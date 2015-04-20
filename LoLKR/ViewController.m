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
    __weak IBOutlet NSImageView *nginxImageView;
    __weak IBOutlet NSButton *patchAllButton;
    __weak IBOutlet NSProgressIndicator *progress;
    __unsafe_unretained IBOutlet NSTextView *textView;
    __weak IBOutlet NSViewController *configViewController;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [progress stopAnimation:nil];
    
    if ([[self runCommand:@"ps -ef | grep -v grep | grep nginx"] length] > 0) {
        nginxImageView.image = [NSImage imageNamed:NSImageNameStatusAvailable];
        itSwitch.enabled = YES;
    } else {
        nginxImageView.image = [NSImage imageNamed:NSImageNameStatusNone];
        itSwitch.enabled = NO;
    }
    [itSwitch setOn:[[[NSUserDefaults standardUserDefaults] objectForKey:@"block_update"] boolValue]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runAllScripts:) name:@"runAllScript" object:nil];
}

- (IBAction)patchButtonPressed:(id)sender {
    NSWindow *window = [[NSWindow alloc] init];
    [window setContentView:configViewController.view];
    [window setFrame:NSMakeRect(0, 0, 480, 340) display:YES];
    
    [self.view.window beginSheet:window completionHandler:nil];
}

- (IBAction)switchValueChanged:(id)sender {
    ITSwitch *switchControl = (ITSwitch *)sender;
    if (!switchControl.isOn) {
        NSAlert *alert = [NSAlert new];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert setMessageText:@"주의"];
        [alert setInformativeText:@"자동 업데이트를 허용하면 한국 서버 클라이언트가 업데이트 됩니다. 북미 서버 기준으로 한국 서버와 버전이 다르면 업데이트가 진행되어 한국 서버에 접속이 안될 수 있습니다. 한국서버 버전이 미국 서버와 같아지면 업데이트를 진행하세요."];
        [alert addButtonWithTitle:@"자동 업데이트 허용"];
        [alert addButtonWithTitle:@"취소"];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertSecondButtonReturn) {
                [switchControl setOn:YES];
            } else {
                NSString *scriptPath = [[NSBundle mainBundle] pathForResource:@"2_download_versions" ofType:@"sh"];
                scriptPath = [NSString stringWithFormat:@"\"%@\"", scriptPath];
                
                dispatch_queue_t taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
                dispatch_async(taskQueue, ^{
                    progress.hidden = NO;
                    itSwitch.enabled = NO;
                    [progress startAnimation:nil];
                    
                    NSNumber *status = [self runScript:@"update" arguments:@[@"on",
                                                                             [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                                                             [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"],
                                                                             [[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"],
                                                                             scriptPath
                                                                             ]];
                    if ([status intValue] == 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"block_update"];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            textView.string = [textView.string stringByAppendingString:@"\n\n"];
                            [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
                        });
                    }
                    
                    [progress stopAnimation:nil];
                    itSwitch.enabled = YES;
                });
            }
        }];
    } else {
        dispatch_queue_t taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_async(taskQueue, ^{
            progress.hidden = NO;
            itSwitch.enabled = NO;
            [progress startAnimation:nil];
            
            NSNumber *status = [self runScript:@"update" arguments:@[@"off",
                                                                     [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                                                     [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"],
                                                                     [[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"]]];
            if ([status intValue] == 0) {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"block_update"];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    textView.string = [textView.string stringByAppendingString:@"\n\n"];
                    [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
                });
            }
            
            itSwitch.enabled = YES;
            [progress stopAnimation:nil];
        });
    }
}

- (void)runAllScripts:(NSNotification *)noti {
    itSwitch.enabled = NO;
    patchAllButton.enabled = NO;
    progress.hidden = NO;
    [progress startAnimation:nil];
    
    __block BOOL success = YES;
    
    dispatch_promise(^{
        if ([[[noti userInfo] objectForKey:@"install_nginx"] boolValue]) {
            return [self runScript:@"1_nginx" arguments:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"port1"],
                                                          [[NSUserDefaults standardUserDefaults] objectForKey:@"port2"]]];
        } else {
            return [NSNumber numberWithInt:0];
        }
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
                [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
            });
            
            return [self runScript:@"2_download_versions" arguments:@[]];
        } else {
            success = NO;
            return [NSNumber numberWithInt:-1];
        }
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
                [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
            });
            
            NSNumber *status3 = [self runScript:@"3_lol" arguments:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"lol_path"],
                                                                     [[NSUserDefaults standardUserDefaults] objectForKey:@"port1"]]];
            
            if ([status3 intValue] == 0) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
                    [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
                });
            } else {
                success = NO;
            }
        } else {
            success = NO;
        }
    }).finally(^{
        [progress stopAnimation:nil];
        patchAllButton.enabled = YES;
        itSwitch.enabled = YES;
        
        if (success) {
            textView.string = [textView.string stringByAppendingString:@"한글 패치가 모두 완료되었습니다. 롤을 다시 실행해 주세요.\n\n"];
            [textView scrollRangeToVisible:NSMakeRange([textView.string length], 0)];
        }
    });
}

- (NSNumber *)runScript:(NSString *)scriptName arguments:(NSArray *)arguments {
    textView.string = [textView.string stringByAppendingString:[NSString stringWithFormat:@"%@.sh\n", scriptName]];
    
    NSString *scriptFile = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"sh"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:@[@"-c", [NSString stringWithFormat:@"\"%@\" %@", scriptFile, [arguments componentsJoinedByString:@" "]]]];
    
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
        }
        //
        [[pipe fileHandleForReading] waitForDataInBackgroundAndNotify];
    }];
    
    [task launch];
    [task waitUntilExit];
    
    return [NSNumber numberWithInt:[task terminationStatus]];
}

- (NSString *)runCommand:(NSString *)commandToRun
{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *output;
    output = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return output;
}

@end

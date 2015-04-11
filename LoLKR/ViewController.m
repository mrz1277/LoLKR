//
//  ViewController.m
//  LoLKR
//
//  Created by Jaesung Koo on 3/28/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "ViewController.h"
#import <PromiseKit.h>

@implementation ViewController {
    
    __weak IBOutlet NSButton *patchAllButton;
    __weak IBOutlet NSProgressIndicator *progress;
    __unsafe_unretained IBOutlet NSTextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [progress stopAnimation:nil];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)runAllScripts:(id)sender {
    patchAllButton.enabled = NO;
    progress.hidden = NO;
    [progress startAnimation:nil];
    
    dispatch_promise(^{
        return [self runScript:@"1_nginx"];
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            return [self runScript:@"2_download_versions"];
        } else {
            return [NSNumber numberWithInt:-1];
        }
    }).thenInBackground(^(NSNumber *status) {
        if ([status intValue] == 0) {
            textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            if ([[self runScript:@"3_lol"] intValue] == 0) {
                textView.string = [textView.string stringByAppendingString:@"완료\n\n"];
            }
        }
    }).finally(^{
        [progress stopAnimation:nil];
        patchAllButton.enabled = YES;
    });
}

- (NSNumber *)runScript:(NSString *)scriptName {
    textView.string = [textView.string stringByAppendingString:[NSString stringWithFormat:@"%@.sh\n", scriptName]];
    
    NSString *scriptFile = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"sh"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:@[ @"-c", [NSString stringWithFormat:@"\"%@\"", scriptFile] ]];
    
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

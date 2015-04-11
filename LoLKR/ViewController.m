//
//  ViewController.m
//  LoLKR
//
//  Created by Jaesung Koo on 3/28/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    
    __weak IBOutlet NSProgressIndicator *progress;
    __unsafe_unretained IBOutlet NSTextView *textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [progress stopAnimation:nil];
    
//    NSLog(@"\n%@", [self runCommand:@"ps -ef | grep nginx"]);
    
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
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

- (IBAction)runAll:(id)sender {
    [progress startAnimation:nil];
    
    NSString *sh1 = [[NSBundle mainBundle] pathForResource:@"1_nginx" ofType:@"sh"];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:@[ @"-c", [NSString stringWithFormat:@"\"%@\"", sh1] ]];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file = [pipe fileHandleForReading];
    [task launch];
    
    NSData *data = [file readDataToEndOfFile];
    textView.string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    
    [progress stopAnimation:nil];
}

@end

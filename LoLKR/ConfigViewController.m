//
//  ConfigViewController.m
//  LoLKR
//
//  Created by Jaesung Koo on 4/12/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()
@property (weak) IBOutlet NSButtonCell *nginxInstall;
@property (weak) IBOutlet NSPathControl *pathControl;
@property (weak) IBOutlet NSTextField *port1TextField;
@property (weak) IBOutlet NSTextField *port2TextField;

@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)done:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (self.port1TextField.stringValue) {
        [userDefaults setObject:self.port1TextField.stringValue forKey:@"port1"];
    }
    if (self.port2TextField.stringValue) {
        [userDefaults setObject:self.port2TextField.stringValue forKey:@"port2"];
    }
    [userDefaults setObject:[NSString stringWithCString:self.pathControl.URL.fileSystemRepresentation encoding:NSUTF8StringEncoding] forKey:@"lol_path"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"runAllScript" object:nil userInfo:@{@"install_nginx": [NSNumber numberWithBool:(self.nginxInstall.state != 0)]}];
    
    [self dismissController:nil];
}

- (BOOL)validateCheck {
    if ((self.port1TextField.stringValue && [self.port1TextField.stringValue intValue] <= 1024)
        || (self.port2TextField.stringValue && [self.port2TextField.stringValue intValue] <= 1024)) {
        return YES;
    } else {
        return NO;
    }
}

@end

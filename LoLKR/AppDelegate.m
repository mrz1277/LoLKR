//
//  AppDelegate.m
//  LoLKR
//
//  Created by Jaesung Koo on 3/28/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"port1"]) {
        [userDefaults setObject:@"8010" forKey:@"port1"];
    }
    if (![userDefaults objectForKey:@"port2"]) {
        [userDefaults setObject:@"8020" forKey:@"port2"];
    }
    if (![userDefaults objectForKey:@"block_update"]) {
        [userDefaults setObject:@YES forKey:@"block_update"];
    }
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

@end

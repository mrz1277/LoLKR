//
//  AppDelegate.m
//  LoLKR
//
//  Created by Jaesung Koo on 3/28/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "AppDelegate.h"

#import "MASPreferencesWindowController.h"
#import "PreferencePaneGeneral.h"
#import "PreferencePaneNginx.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - 

- (IBAction)openPreferences:(id)sender {
    if (!preferencesWindowController)
    {
        NSViewController *generalViewController = [[PreferencePaneGeneral alloc] init];
        NSViewController *advancedViewController = [[PreferencePaneNginx alloc] init];
        NSArray *controllers = [[NSArray alloc] initWithObjects:generalViewController, advancedViewController, nil];
        
        NSString *title = NSLocalizedString(@"환경설정", @"Common title for Preferences window");
        preferencesWindowController = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:title];
    }
    
    [preferencesWindowController showWindow:nil];
}

@end

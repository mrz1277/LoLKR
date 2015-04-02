//
//  PreferencePaneNginx.m
//  LoLKR
//
//  Created by Jason Koo on 4/3/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "PreferencePaneNginx.h"

@interface PreferencePaneNginx ()

@end

@implementation PreferencePaneNginx

- (id)init {
    return [super initWithNibName:@"PreferencePaneNginx" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"PreferencePaneNginx";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNameAdvanced];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"웹서버", @"Toolbar item name for the General preference pane");
}

@end

//
//  PreferencePaneGeneral.m
//  LoLKR
//
//  Created by Jason Koo on 4/3/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "PreferencePaneGeneral.h"

@interface PreferencePaneGeneral ()

@end

@implementation PreferencePaneGeneral

- (id)init {
    return [super initWithNibName:@"PreferencePaneGeneral" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"PreferencePaneGeneral";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"일반", @"Toolbar item name for the General preference pane");
}

@end

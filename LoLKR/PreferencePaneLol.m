//
//  PreferencePaneLol.m
//  LoLKR
//
//  Created by Jaesung Koo on 4/11/15.
//  Copyright (c) 2015 Jaesung Koo. All rights reserved.
//

#import "PreferencePaneLol.h"

@interface PreferencePaneLol ()

@end

@implementation PreferencePaneLol

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

#pragma mark - MASPreferencesViewController

- (NSString *)identifier
{
    return @"PreferencePaneLol";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:@"lol"];
}

- (NSString *)toolbarItemLabel
{
    return NSLocalizedString(@"롤", @"Toolbar item name for the General preference pane");
}

@end

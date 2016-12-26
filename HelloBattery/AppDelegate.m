//
//  AppDelegate.m
//  HelloBattery
//
//  Created by Anthony Agatiello on 12/25/16.
//  Copyright © 2016 Anthony Agatiello. All rights reserved.
//

#import "AppDelegate.h"
#import <IOKit/ps/IOPowerSources.h>

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self createMenuItems];
}

- (void)createMenuItems {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.highlightMode = YES;
    self.statusItem.image = [NSImage imageNamed:@"battery"];
    
    self.statusMenu = [[NSMenu alloc] init];
    
    NSMenuItem *titleItem = [[NSMenuItem alloc] initWithTitle:@"HelloBattery (Click to Quit)" action:@selector(terminate:) keyEquivalent:@""];
    NSMenuItem *separatorItem = [NSMenuItem separatorItem];
    
    [self.statusMenu addItem:titleItem];
    [self.statusMenu addItem:separatorItem];
    
    [self updateRemainingItem];
    [self.statusMenu addItem:self.remainingItem];

    [self.statusItem setMenu:self.statusMenu];
    [self.statusMenu setDelegate:self];
}

- (void)menuWillOpen:(NSMenu *)menu {
    if (menu) {
        [self.statusMenu removeItem:self.remainingItem];
        [self updateRemainingItem];
        [self.statusMenu addItem:self.remainingItem];
    }
}

- (void)updateRemainingItem {
    self.remainingItem = nil;
    
    CFTimeInterval timeRemaining = IOPSGetTimeRemainingEstimate();
    int minutes = (int)(timeRemaining / 60) % 60;
    int hours = (int)timeRemaining / 3600;
    
    NSString *title = nil;
    if (timeRemaining != kIOPSTimeRemainingUnlimited) {
        if (hours == 1) {
            title = [NSString stringWithFormat:@"Time Remaining: %@ hour, %@ minutes", @(hours), @(minutes)];
        }
        else {
            title = [NSString stringWithFormat:@"Time Remaining: %@ hours, %@ minutes", @(hours), @(minutes)];
        }
    }
    else {
        title = @"Battery is either fully charged or connected to power.";
    }
    
    self.remainingItem = [[NSMenuItem alloc] initWithTitle:title action:nil keyEquivalent:@""];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

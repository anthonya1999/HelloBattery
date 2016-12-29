//
//  AppDelegate.m
//  HelloBattery
//
//  Created by Anthony Agatiello on 12/25/16.
//  Copyright © 2016 Anthony Agatiello. All rights reserved.
//

#import "AppDelegate.h"
#include <dlfcn.h>

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
    
    NSString *appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSMenuItem *versionItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"Version %@", appVersionString] action:nil keyEquivalent:@""];
    
    NSMenuItem *separatorItem = [NSMenuItem separatorItem];
    
    [self.statusMenu addItem:titleItem];
    [self.statusMenu addItem:versionItem];
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
    
    void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/Versions/A/IOKit", RTLD_LAZY);
    NSParameterAssert(IOKit);
    
    CFTimeInterval (*IOPSGetTimeRemainingEstimate)(void) = dlsym(IOKit, "IOPSGetTimeRemainingEstimate");
    NSParameterAssert(IOPSGetTimeRemainingEstimate);
    
    CFTimeInterval timeRemaining = IOPSGetTimeRemainingEstimate();
    
    dlclose(IOKit);
    
    NSString *minutes = [NSString stringWithFormat:@"%d", (int)(timeRemaining / 60) % 60];
    NSString *hours = [NSString stringWithFormat:@"%d", (int)timeRemaining / 3600];
    
    NSString *mutableTitle = nil;
    
    if (timeRemaining == kIOPSTimeRemainingUnknown) {
        mutableTitle = @"Calculating...";
    }
    else if (timeRemaining != kIOPSTimeRemainingUnlimited) {
        if ([minutes intValue] <= 9) {
            minutes = [NSString stringWithFormat:@"0%@", minutes];
        }
        mutableTitle = [NSString stringWithFormat:@"%@:%@", hours, minutes];
    }
    else {
        mutableTitle = @"Unlimited";
    }
    
    NSString *finalTitle = [NSString stringWithFormat:@"Time Remaining: %@", mutableTitle];
    
    self.remainingItem = [[NSMenuItem alloc] initWithTitle:finalTitle action:nil keyEquivalent:@""];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

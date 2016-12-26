//
//  AppDelegate.h
//  HelloBattery
//
//  Created by Anthony Agatiello on 12/25/16.
//  Copyright © 2016 Anthony Agatiello. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kIOPSTimeRemainingUnlimited ((CFTimeInterval)-2.0)
#define kIOPSTimeRemainingUnknown ((CFTimeInterval)-1.0)

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSMenu *statusMenu;
@property (strong, nonatomic) NSMenuItem *remainingItem;

@end

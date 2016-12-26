//
//  AppDelegate.h
//  HelloBattery
//
//  Created by Anthony Agatiello on 12/25/16.
//  Copyright © 2016 Anthony Agatiello. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) NSMenu *statusMenu;
@property (strong, nonatomic) NSMenuItem *remainingItem;

@end

//
//  AppDelegate.h
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"
#import "debug_msg.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
                                      

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) dataViewController *mainViewController;


@end


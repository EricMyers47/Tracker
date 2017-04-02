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

@class myViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
                                      

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) dataViewController *mainViewController;
//@property (strong, nonatomic) UINavigationController *navController;

@end


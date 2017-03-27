//
//  AppDelegate.h
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "debug_msg.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,
                                      CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) myViewController *navViewController;
@property (strong, nonatomic) CLLocationManager *locationManager;


-(void)locationInit;

@end


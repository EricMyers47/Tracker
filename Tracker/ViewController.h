//
//  ViewController.h
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "debug_msg.h"


@interface dataViewController : UIViewController <CLLocationManagerDelegate>


@property (strong,nonatomic) id<UIApplicationDelegate> dg;
@property (strong, nonatomic)  CLLocationManager *locationManager;

@property (strong,nonatomic)    IBOutlet UILabel *LonValue;
@property (strong,nonatomic)    IBOutlet UILabel *LatValue;
@property (strong,nonatomic)    IBOutlet UILabel *AltmValue;
@property (strong,nonatomic)    IBOutlet UILabel *AltftValue;
@property (strong,nonatomic)    IBOutlet UILabel *SpeedValue;
@property (strong,nonatomic)    IBOutlet UILabel *CourseValue;
@property (strong,nonatomic)    IBOutlet UILabel *TimeDisplay;

- (void) updateView;
- (void)locationInit;
@end


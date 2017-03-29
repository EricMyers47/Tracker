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
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic)    IBOutlet UILabel *LonLabel;
@property (strong,nonatomic)    IBOutlet UILabel *LatLabel;
@property (strong,nonatomic)    IBOutlet UILabel *AltmLabel;
@property (strong,nonatomic)    IBOutlet UILabel *AltftLabel;
@property (strong,nonatomic)    IBOutlet UILabel *SpeedLabel;
@property (strong,nonatomic)    IBOutlet UILabel *CourseLabel;
@property (strong,nonatomic)    IBOutlet UILabel *TimeLabel;

- (void) updateView;

@end


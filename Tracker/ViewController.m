//
//  ViewController.m
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import "ViewController.h"

@interface dataViewController (){
    id<UIApplicationDelegate> dg;
    CLLocationManager  *locationManager;
    IBOutlet UILabel *LonLabel;
    IBOutlet UILabel *LatLabel;
    IBOutlet UILabel *AltmLabel;
    IBOutlet UILabel *AltftLabel;
    IBOutlet UILabel *SpeedLabel;
    IBOutlet UILabel *CourseLabel;
    IBOutlet UILabel *TimeLabel;
}
@end

@implementation dataViewController

@synthesize dg;
@synthesize LonLabel;
@synthesize LatLabel;
@synthesize AltmLabel;
@synthesize AltftLabel;
@synthesize SpeedLabel;
@synthesize CourseLabel;
@synthesize TimeLabel;

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dg = [[UIApplication sharedApplication] delegate];
    
    LonLabel.text = @"-??.?????";
    LatLabel.text = @"+??.?????";
    SpeedLabel.text = @"0.00 m/s";
    CourseLabel.text = @"000.1";
    AltmLabel.text = @"47 m";
    AltftLabel.text = @"???.? ft";
    [self locationInit];
    debug_msg(5,@"viewDidLoad");
}


- (void) updateView {
    // triggered by AppDelegate, this should get latest data and display it
    debug_msg(2,@"ViewController: updateView");
}

#pragma mark -
#pragma mark Location Service

-(void) locationInit {
    if( [CLLocationManager locationServicesEnabled] != YES ){
        _locationManager = NULL;
        debug_msg(0,@"! LOCATION SERVICE NOT AVAILABLE!");
        UIAlertView* warningPopUp = [[UIAlertView alloc]
                                     initWithTitle:@"No Location Services!"
                                     message:@"Location services are not enabled/available. "
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        [warningPopUp show];
        return;
    }
    
    if (nil == locationManager){
        debug_msg(1,@"Initial locationManager was nil");
        _locationManager = [[CLLocationManager alloc] init];
    }
    // set/reset:
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    // locationManager.distanceFilter = 1; // meters
    
    // iOS 8 and beyond require that you request authorization
    if( [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        debug_msg(1,@"Requesting authorization for Location services....");
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    debug_msg(2,@"Location service started updating.");
}





- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    debug_msg(1,@"locationManager didUpdateLocations");
    
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f \n",
              location.coordinate.latitude,
              location.coordinate.longitude,
              location.altitude);
        
        self.TimeLabel.text = [NSDateFormatter localizedStringFromDate:location.timestamp
                                                             dateStyle:NSDateFormatterLongStyle
                                                             timeStyle:NSDateFormatterLongStyle];
        self.LonLabel.text = [NSString stringWithFormat:@"%+9.5f",
                              location.coordinate.longitude];
        self.LatLabel.text = [NSString stringWithFormat:@"%+8.5f",
                             location.coordinate.latitude];
        self.AltmLabel.text = [NSString stringWithFormat:@"%8.1f",
                              location.altitude];
        self.AltftLabel.text = [NSString stringWithFormat:@"%8.1f",
                               location.altitude/0.3048];
        self.SpeedLabel.text = [NSString stringWithFormat:@"%5.1f",
                               location.speed];
        self.CourseLabel.text = [NSString stringWithFormat:@"%3.0f",
                               location.course];
        
        
        if( location.horizontalAccuracy < 0 ) {
            self.LatLabel.textColor = [UIColor redColor];
            self.LonLabel.textColor = [UIColor redColor];
        }
        else {
            self.LatLabel.textColor = [UIColor whiteColor];
            self.LonLabel.textColor = [UIColor whiteColor];
        }
        
        if( location.verticalAccuracy < 0 ) {
            self.AltmLabel.textColor = [UIColor redColor];
            self.AltftLabel.textColor = [UIColor redColor];
        }
        else {
            self.AltmLabel.textColor = [UIColor whiteColor];
            self.AltftLabel.textColor = [UIColor whiteColor];
        }

        
        if( location.course < 0 ) {
            self.CourseLabel.textColor = [UIColor redColor];
            self.CourseLabel.text = @"?";
        }
        else{
            self.CourseLabel.textColor = [UIColor whiteColor];
        }
        
        if( location.speed < 0 )
            self.SpeedLabel.textColor = [UIColor redColor];
        else
            self.SpeedLabel.textColor = [UIColor whiteColor];
        
        //TODO: save data here, once per second
    }
    
    debug_msg(6,@"dataViewControlloer wants to updateView...");
    [self updateView];
}



- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    debug_msg(0,@"!locationManager didFailWithError!! %s ", error.localizedDescription);
    
    
}



#pragma mark -
#pragma mark Memory


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

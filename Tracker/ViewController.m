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
    NSDateFormatter    *dateFormatter;
    IBOutlet UILabel *LonValue;
    IBOutlet UILabel *LatValue;
    IBOutlet UILabel *AltmValue;
    IBOutlet UILabel *AltftValue;
    IBOutlet UILabel *SpeedValue;
    IBOutlet UILabel *CourseValue;
    IBOutlet UILabel *TimeDisplay;
}
@end

@implementation dataViewController

@synthesize locationManager = _locationManager;
@synthesize dg;

@synthesize LonValue;
@synthesize LatValue;
@synthesize AltmValue;
@synthesize AltftValue;
@synthesize SpeedValue;
@synthesize CourseValue;
@synthesize TimeDisplay;

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Get app delegate
    dg = [[UIApplication sharedApplication] delegate];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy MMM dd   HH:mm:ss"];
    
    LonValue.text = @"-??.?????";
    LatValue.text = @"+??.?????";
    SpeedValue.text = @"0.00 m/s";
    CourseValue.text = @"000.1";
    AltmValue.text = @"47 m";
    AltftValue.text = @"???.? ft";
    
    [self locationInit];
    
    debug_msg(5,@"viewDidLoad");
}


- (void) updateView {
    // triggered by AppDelegate, this should get latest data and display it
    debug_msg(4,@"ViewController: updateView");
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
    debug_msg(4,@"locationManager didUpdateLocations");
    
    return;
    
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    
        self.TimeDisplay.text = [dateFormatter stringFromDate:location.timestamp ];
        self.TimeDisplay.textColor = [UIColor whiteColor];
        
        self.LonValue.text = [NSString stringWithFormat:@"%+9.5f",
                              location.coordinate.longitude];
        self.LatValue.text = [NSString stringWithFormat:@"%+8.5f",
                             location.coordinate.latitude];
        self.AltmValue.text = [NSString stringWithFormat:@"%8.1f",
                              location.altitude];
        self.AltftValue.text = [NSString stringWithFormat:@"%8.1f",
                               location.altitude/0.3048];
        self.SpeedValue.text = [NSString stringWithFormat:@"%5.1f",
                               location.speed];
        self.CourseValue.text = [NSString stringWithFormat:@"%3.0f",
                               location.course];
        
        
        if( location.horizontalAccuracy < 0 ) {
            self.LatValue.textColor = [UIColor redColor];
            self.LonValue.textColor = [UIColor redColor];
        }
        else {
            self.LatValue.textColor = [UIColor whiteColor];
            self.LonValue.textColor = [UIColor whiteColor];
        }
        
        if( location.verticalAccuracy < 0 ) {
            self.AltmValue.textColor = [UIColor redColor];
            self.AltftValue.textColor = [UIColor redColor];
        }
        else {
            self.AltmValue.textColor = [UIColor whiteColor];
            self.AltftValue.textColor = [UIColor whiteColor];
        }

        
        if( location.course < 0 ) {
            self.CourseValue.textColor = [UIColor redColor];
            self.CourseValue.text = @"?";
        }
        else{
            self.CourseValue.textColor = [UIColor whiteColor];
        }
        
        if( location.speed < 0 )
            self.SpeedValue.textColor = [UIColor redColor];
        else
            self.SpeedValue.textColor = [UIColor whiteColor];
        
    
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f \n",
              location.coordinate.latitude,
              location.coordinate.longitude,
              location.altitude);
        //TODO: save data here to a file, once per second
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

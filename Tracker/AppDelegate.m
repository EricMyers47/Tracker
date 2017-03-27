//
//  AppDelegate.m
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import "AppDelegate.h"



@interface AppDelegate (){
    myViewController  *navViewController;
    CLLocationManager *locationManager;
}


@end


@implementation AppDelegate

//@synthesize navViewController;
//@synthesize locationManager;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    set_debug_level(5);
    debug_msg(1,@"application didFinishLaunchingWithOptions:");
    
    self.navViewController = [self.window rootViewController];
    
    [self locationInit];
    
    return YES;
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
            //TODO: save data here
    }

    debug_msg(1,@"AppDelegate wants to updateView...");
    [self.navViewController updateView];
}






- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    debug_msg(0,@"!locationManager didFailWithError!! ");
    
}


#pragma mark -



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

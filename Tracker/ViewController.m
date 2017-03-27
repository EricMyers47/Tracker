//
//  ViewController.m
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import "ViewController.h"

@interface myViewController (){
    id<UIApplicationDelegate> dg;
    
    IBOutlet UILabel *LonLabel;
    IBOutlet UILabel *LatLabel;
    IBOutlet UILabel *AltmLabel;
    IBOutlet UILabel *AltftLabel;
    IBOutlet UILabel *SpeedLabel;
    IBOutlet UILabel *BearingLabel;
}
@end

@implementation myViewController

@synthesize dg;
@synthesize LonLabel;
@synthesize LatLabel;
@synthesize AltmLabel;
@synthesize AltftLabel;
@synthesize SpeedLabel;
@synthesize BearingLabel;

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dg = [[UIApplication sharedApplication] delegate];
    
    LonLabel.text = @"-??.?????";
    LatLabel.text = @"+??.?????";
    SpeedLabel.text = @"0.00 m/s";
    BearingLabel.text = @"000.1";
    AltmLabel.text = @"47 m";
    AltftLabel.text = @"???.? ft";
    
    debug_msg(5,@"viewDidLoad");
}


- (void) updateView {
    // triggered by AppDelegate, this should get latest data and display it
    debug_msg(2,@"ViewController: updateView");
}



#pragma mark -
#pragma mark Memory


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

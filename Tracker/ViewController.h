//
//  ViewController.h
//  Tracker
//
//  Created by Eric Myers on 3/26/17.
//  Copyright © 2017 EricMyers.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "debug_msg.h"


@interface myViewController : UIViewController


@property (strong,nonatomic) id<UIApplicationDelegate> dg;
@property (strong,nonatomic)    IBOutlet UILabel *LonLabel;
@property (strong,nonatomic)    IBOutlet UILabel *LatLabel;
@property (strong,nonatomic)    IBOutlet UILabel *AltmLabel;
@property (strong,nonatomic)    IBOutlet UILabel *AltftLabel;
@property (strong,nonatomic)    IBOutlet UILabel *SpeedLabel;
@property (strong,nonatomic)    IBOutlet UILabel *BearingLabel;


- (void) updateView;

@end


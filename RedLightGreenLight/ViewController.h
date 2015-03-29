//
//  ViewController.h
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 11/24/14.
//  Copyright (c) 2014 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface ViewController : UIViewController <ADBannerViewDelegate,UIGestureRecognizerDelegate>

@property float viewHeight;
@property float viewWidth;
@property float personSize;
@property float rand;
@property float randWait;
@property float intervalRand;
@property int intervalTracker;
@property BOOL freeze;
@property int stepsTaken;
@property int counts;
@property NSUserDefaults *defaults;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *personHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *personWidth;

@property (strong, nonatomic) IBOutlet UILabel *oneLabel;
@property (strong, nonatomic) IBOutlet UILabel *twoLabel;
@property (strong, nonatomic) IBOutlet UIView *person;
@property (strong, nonatomic) IBOutlet UILabel *stepsTakenLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeTakenLabel;
@property (strong, nonatomic) IBOutlet UILabel *stepHigh;
@property (strong, nonatomic) IBOutlet UILabel *timeHigh;
@property (strong, nonatomic) IBOutlet UIView *frontPop;
@property (strong, nonatomic) IBOutlet UIView *backPop;

- (IBAction)personAction:(id)sender;
- (IBAction)stepGesture:(id)sender;
- (IBAction)doubleTouchStep:(id)sender;
- (IBAction)tripleTouchStep:(id)sender;
- (IBAction)doubleTapStep:(id)sender;
- (IBAction)doubleTapDoubleTouchStep:(id)sender;
- (IBAction)closeLose:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *loseView;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIButton *close;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *oneTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *twoTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *threeTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fourTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fiveTouch;

@end


//
//  ViewController.h
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 11/24/14.
//  Copyright (c) 2014 Andrew Boryk. All rights reserved.
//  On Github

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <GameKit/GameKit.h>
#import "HomeViewController.h"

@interface ViewController : UIViewController <ADBannerViewDelegate,UIGestureRecognizerDelegate>

@property float viewHeight;
@property float viewWidth;
@property float personSize;
@property float rand;
@property float randWait;
@property float intervalRand;
@property int intervalTracker;
@property BOOL freeze;
@property BOOL gameCenterEnabled;
@property int stepsTaken;
@property int counts;
@property NSUserDefaults *defaults;
@property NSString *leaderboardIdentifier;

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
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)personAction:(id)sender;
- (IBAction)stepGesture:(id)sender;
- (IBAction)doubleTouchStep:(id)sender;
- (IBAction)tripleTouchStep:(id)sender;
- (IBAction)doubleTapStep:(id)sender;
- (IBAction)doubleTapDoubleTouchStep:(id)sender;
- (IBAction)closeLose:(id)sender;
- (IBAction)shareAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *loseView;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UIButton *close;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *oneTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *twoTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *threeTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fourTouch;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *fiveTouch;

//HowToView
@property (strong, nonatomic) IBOutlet UIView *howToView;
- (IBAction)startActionNow:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *startNowButton;

@end


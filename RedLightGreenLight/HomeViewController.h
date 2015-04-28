//
//  HomeViewController.h
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 4/19/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "GameKitHelper.h"
@interface HomeViewController : UIViewController <GKGameCenterControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *pulsePlay;
- (IBAction)leaderboardShow:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *leadButton;
@property NSString *leaderboardIdentifier;
@property BOOL gameCenterEnabled;
@property NSUserDefaults *defaults;
//@property (strong, nonatomic) UIActionSheet *customActionSheet;

@end

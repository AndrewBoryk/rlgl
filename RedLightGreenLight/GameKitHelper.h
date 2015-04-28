//
//  GameKitHelper.h
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 4/20/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;

@interface GameKitHelper : NSObject
@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedGameKitHelper;

extern NSString *const PresentAuthenticationViewController;
extern NSString *const leaderboardId;
- (void)authenticateLocalPlayer;

@end

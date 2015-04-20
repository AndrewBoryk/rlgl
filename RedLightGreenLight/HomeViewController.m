//
//  HomeViewController.m
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 4/19/15.
//  Copyright (c) 2015 Andrew Boryk. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50,100, 200, 200)];
    view.center = CGPointMake(self.view.center.x, self.view.center.y);
    view.backgroundColor = [UIColor colorWithRed:46.0f/255.0f green:204.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    view.layer.cornerRadius = 100;
    
    [self.view addSubview:view];
    [view addSubview:self.pulsePlay];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 1.0;
    scaleAnimation.repeatCount = HUGE_VAL;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.2];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.5];
    
    [view.layer addAnimation:scaleAnimation forKey:@"scale"];
}


@end

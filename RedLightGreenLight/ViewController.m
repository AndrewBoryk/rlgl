//
//  ViewController.m
//  RedLightGreenLight
//
//  Created by Andrew Boryk on 11/24/14.
//  Copyright (c) 2014 Andrew Boryk. All rights reserved.
//

#import "ViewController.h" 

@interface ViewController ()

@end

NSTimer *timer;
NSTimer *waiter;
NSTimer *counter;
NSTimer *enTimer;
float fontSize;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.bannerView.adUnitID = @"ca-app-pub-6233938597693711/6195839982";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    // Enable test ads on simulators.
    [self.bannerView loadRequest:request];
    self.defaults = [NSUserDefaults standardUserDefaults];
    if (![self.defaults integerForKey:@"stepScore"]) {
        [self.defaults setInteger:0 forKey:@"stepScore"];
        [self.defaults setInteger:0 forKey:@"timeScore"];
        [self.defaults synchronize];
        self.stepHigh.text = [NSString stringWithFormat:@"%i", 0];
        self.timeHigh.text = [NSString stringWithFormat:@"%i", 0];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.counts = 0;
    self.loseView.alpha = 0;
    self.bannerView.hidden = YES;
    self.viewHeight = self.view.bounds.size.height;
    NSLog(@"View Height: %f", self.viewHeight);
    self.viewWidth = self.view.bounds.size.width;
    NSLog(@"View Width: %f", self.viewWidth);
    self.personSize = self.viewWidth/100.0f+30.0f;
    NSLog(@"Person Size: %f", self.personSize);
    self.personHeight.constant = self.personSize;
    self.personWidth.constant = self.personSize;
    
    //Frames
    self.person.layer.borderWidth = 0.25f;
    self.person.layer.borderColor = [UIColor blackColor].CGColor;
    self.person.layer.cornerRadius = self.personSize/2.0f;
    self.loseView.layer.cornerRadius = 10.0f;
    self.loseView.clipsToBounds = YES;
    self.timeTakenLabel.layer.borderWidth = 0.25f;
    self.timeTakenLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.stepsTakenLabel.layer.borderWidth = 0.25f;
    self.stepsTakenLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.stepHigh.layer.borderWidth = 0.25f;
    self.stepHigh.layer.borderColor = [UIColor blackColor].CGColor;
    self.timeHigh.layer.borderWidth = 0.25f;
    self.timeHigh.layer.borderColor = [UIColor blackColor].CGColor;
    self.close.layer.borderWidth = 0.25f;
    self.close.layer.borderColor = [UIColor blackColor].CGColor;
    self.oneLabel.text = [NSString stringWithFormat:@"0"];
    self.twoLabel.text = [NSString stringWithFormat:@"0"];
    fontSize = self.personSize - 25.0f;
    [self.twoLabel setFont:[UIFont fontWithName:self.twoLabel.font.fontName size:fontSize]];
    [UIView animateWithDuration:.25f animations:^{
        self.oneLabel.alpha = 0;
        self.twoLabel.alpha = 0;
    }];
    
    self.oneTouch.enabled = YES;
    self.twoTouch.enabled = YES;
    self.threeTouch.enabled = YES;
    self.fourTouch.enabled = YES;
    self.fiveTouch.enabled = YES;
    
    self.freeze = false;
    self.intervalTracker = 0.0f;
    self.stepsTaken = 0;
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.counts = 0;
    [self start];
    [self count];
}
-(void)makeRandom
{
    self.rand = 1.0f + arc4random() % 3;
    //NSLog(@"Rand: %i", self.rand);
    if (self.rand == 0) {
        self.rand = 1;
        self.intervalRand = 0.2f;
    }
    else
    {
        self.intervalRand = ((float)self.rand) / 5.0f;
    }
}

-(void)randomWait
{
    self.randWait = 1.0f + arc4random() % 3;
    //NSLog(@"Rand: %i", self.rand);
    if (self.randWait == 0.0f) {
        self.randWait = 1.0f;
    }
}

-(void)start
{
    
    timer=[NSTimer scheduledTimerWithTimeInterval:self.intervalRand target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}
-(void)timerFired
{
    //NSLog(@"Tracker: %i", self.intervalTracker);
    if(self.intervalTracker >= 6)
    {
        self.freeze = true;
//        [self.person.imageView setImage:[UIImage imageNamed:@"open"]];
//        self.person.imageView.image = [self.person.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.person setTintColor:[UIColor whiteColor]];
        self.intervalTracker = 0;
        [timer invalidate];
        [self wait];
    }
    else
    {
        self.oneLabel.alpha = 1;
        self.twoLabel.alpha = 1;
        self.intervalTracker++;
    }
}

-(void)wait
{
    //NSLog(@"Fired Wait");
    [self randomWait];
    self.person.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:36.0f/255.0f blue:89.0f/255.0f alpha:1.0f];
    waiter =[NSTimer scheduledTimerWithTimeInterval:self.randWait target:self selector:@selector(waiterDone) userInfo:nil repeats:NO];
    
}
-(void)waiterDone
{
    self.freeze = false;
    [self makeRandom];
    self.person.backgroundColor = [UIColor colorWithRed:27.0f/255.0f green:188.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    [waiter invalidate];
//    [self.person.imageView setImage:[UIImage imageNamed:@"closed"]];
//    self.person.imageView.image = [self.person.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.person setTintColor:[UIColor whiteColor]];
    [self start];
}

-(void)count
{
    //NSLog(@"Count Fired");
    counter =[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countAdd) userInfo:nil repeats:YES];

}
-(void)countAdd
{
    if ((self.counts - self.stepsTaken) >= 10) {
        [counter invalidate];
        if (self.stepsTaken > [self.defaults integerForKey:@"stepScore"] || (self.stepsTaken == [self.defaults integerForKey:@"stepScore"] && self.counts < [self.defaults integerForKey:@"timeScore"]))
        {
            [self.defaults setInteger:self.stepsTaken forKey:@"stepScore"];
            [self.defaults setInteger:self.counts forKey:@"timeScore"];
            [self.defaults synchronize];
//            self.stepHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
//            self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"timeScore"]];
        }
        else {
//            self.stepHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
//            self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"timeScore"]];
        }
        self.bannerView.hidden = NO;
        self.personSize = self.viewWidth/100.0f+30.0f;
        [UIView animateWithDuration:0.05 animations:^{
            self.personHeight.constant = self.personSize;
            self.personWidth.constant = self.personSize;
            [self.view layoutIfNeeded];
        }];
        self.person.layer.cornerRadius = self.personSize/2.0f;
        self.person.hidden = YES;
        self.oneTouch.enabled = NO;
        self.twoTouch.enabled = NO;
        self.threeTouch.enabled = NO;
        self.fourTouch.enabled = NO;
        self.fiveTouch.enabled = NO;
        self.stepHigh.text = [NSString stringWithFormat:@"%i", self.stepsTaken];
        self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
//        self.stepsTakenLabel.text = [NSString stringWithFormat:@"Steps: %i", self.stepsTaken];
//        self.timeTakenLabel.text = [NSString stringWithFormat:@"Time: %i", self.counts];
        [UIView animateWithDuration:.05f animations:^{
            self.oneLabel.alpha = 0;
            self.twoLabel.alpha = 0;
            self.frontPop.alpha = 0;
        }completion:^(BOOL finished) {
            self.oneLabel.text = [NSString stringWithFormat:@"Too Slow!"];
            [UIView animateWithDuration:.1 animations:^{
                self.oneLabel.alpha = 1.0f;
            }];
        }];
        self.freeze = false;
        [self makeRandom];
        self.person.backgroundColor = [UIColor colorWithRed:27.0f/255.0f green:188.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
        [timer invalidate];
        [waiter invalidate];
        self.close.enabled = NO;
        enTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(enableWait) userInfo:nil repeats:NO];
        [UIView animateWithDuration:1.0f animations:^{
            [self.loseView setAlpha:1.0f];
        }];
    }
    else
    {
        self.counts++;
        self.oneLabel.text = [NSString stringWithFormat:@"%i", self.counts];
    }
    //NSLog(@"Counts: %i", self.counts);
}

-(void)step{
    if (self.freeze == true) {
        [counter invalidate];
        NSLog(@"Frozen");
        if (self.stepsTaken > [self.defaults integerForKey:@"stepScore"] || (self.stepsTaken == [self.defaults integerForKey:@"stepScore"] && self.counts < [self.defaults integerForKey:@"timeScore"]))
        {
            [self.defaults setInteger:self.stepsTaken forKey:@"stepScore"];
            [self.defaults setInteger:self.counts forKey:@"timeScore"];
            [self.defaults synchronize];
//            self.stepHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
//            self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"timeScore"]];
        }
        else {
//            self.stepHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
//            self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"timeScore"]];
        }
        self.bannerView.hidden = NO;
        [self.loseView setAlpha:0];
        self.personSize = self.viewWidth/100.0f+30.0f;
        [UIView animateWithDuration:0.05 animations:^{
            self.personHeight.constant = self.personSize;
            self.personWidth.constant = self.personSize;
            [self.view layoutIfNeeded];
        }];
        fontSize = self.personSize - 25.0f;
        [self.twoLabel setFont:[UIFont fontWithName:self.twoLabel.font.fontName size:fontSize]];
        self.person.layer.cornerRadius = self.personSize/2.0f;
        self.person.hidden = YES;
        self.oneTouch.enabled = NO;
        self.twoTouch.enabled = NO;
        self.threeTouch.enabled = NO;
        self.fourTouch.enabled = NO;
        self.fiveTouch.enabled = NO;
        
        self.stepHigh.text = [NSString stringWithFormat:@"%i", self.stepsTaken];
        self.timeHigh.text = [NSString stringWithFormat:@"%i", (int)[self.defaults integerForKey:@"stepScore"]];
        
//        self.stepsTakenLabel.text = [NSString stringWithFormat:@"Steps: %i", self.stepsTaken];
//        self.timeTakenLabel.text = [NSString stringWithFormat:@"Time: %i", self.counts];
        [UIView animateWithDuration:0.66f animations:^{
            [self.loseView setAlpha:1.0f];
        }];
        [UIView animateWithDuration:.05f animations:^{
            self.oneLabel.alpha = 0;
            self.twoLabel.alpha = 0;
            self.frontPop.alpha = 0;
        }
         completion:^(BOOL finished) {
             self.oneLabel.text = [NSString stringWithFormat:@"You've been caught!"];
             [UIView animateWithDuration:.1 animations:^{
                 self.oneLabel.alpha = 1.0f;
             }];
         }];
        self.freeze = false;
        [self makeRandom];
        self.person.backgroundColor = [UIColor colorWithRed:27.0f/255.0f green:188.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
        [waiter invalidate];
        [timer invalidate];
        self.close.enabled = NO;
        enTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(enableWait) userInfo:nil repeats:NO];
        [UIView animateWithDuration:0.66f animations:^{
            [self.loseView setAlpha:1.0f];
        }];
    }
    else{
        self.stepsTaken++;
        self.twoLabel.text = [NSString stringWithFormat:@"%i", self.stepsTaken];
        fontSize += (self.viewWidth-30.0f)/300.0f;
        [self.twoLabel setFont:[UIFont fontWithName:self.twoLabel.font.fontName size:fontSize]];
        if (self.personSize >= self.viewWidth) {
            self.personSize = self.viewWidth/100.0f+30.0f;
            self.personHeight.constant = self.personSize;
            self.personWidth.constant = self.personSize;
            fontSize = self.personSize - 25.0f;
            [self.twoLabel setFont:[UIFont fontWithName:self.twoLabel.font.fontName size:fontSize]];
            [UIView animateWithDuration:0.25f animations:^{
                self.personHeight.constant = self.personSize;
                self.personWidth.constant = self.personSize;
                [self.view layoutIfNeeded];
                self.person.layer.cornerRadius = self.personSize/2.0f;
            } completion:^(BOOL finished) {
                [self makeRandom];
            }];
        }
        else{
            self.personSize += (self.viewWidth-30.0f)/100.0f;
            //NSLog(@"Person Size: %f", self.personSize);
            [UIView animateWithDuration:0.05 animations:^{
                self.personHeight.constant = self.personSize;
                self.personWidth.constant = self.personSize;
                [self.view layoutIfNeeded];
            }];
//            [self.person.imageView setImage:[UIImage imageNamed:@"closed"]];
//            self.person.imageView.image = [self.person.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.person setTintColor:[UIColor whiteColor]];
            self.person.layer.cornerRadius = self.personSize/2.0f;
//            if (self.personSize >= self.viewHeight) {
//                [self.person setTitle:@"Tag!" forState:UIControlStateNormal];
//            }
        }
    }
}

- (IBAction)personAction:(id)sender {
    [self step];
}
- (IBAction)stepGesture:(id)sender {
    [self step];
}
- (IBAction)doubleTouchStep:(id)sender {
    [self step];
}
- (IBAction)tripleTouchStep:(id)sender {
    [self step];
}
- (IBAction)doubleTapStep:(id)sender {
    [self step];
}
- (IBAction)doubleTapDoubleTouchStep:(id)sender {
    [self step];
}

- (IBAction)closeLose:(id)sender {
    self.person.hidden = NO;
    //[self.person.imageView setImage:[UIImage imageNamed:@"closed"]];
    //self.person.imageView.image = [self.person.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.person setTintColor:[UIColor whiteColor]];
    self.stepsTaken = 0;
    self.counts = 0;
    
    [UIView animateWithDuration:.1 animations:^{
        self.oneLabel.alpha = 0;
        self.frontPop.alpha = 1.0f;
    }
     completion:^(BOOL finished) {
         self.oneLabel.text = [NSString stringWithFormat:@"0"];
         self.twoLabel.text = [NSString stringWithFormat:@"0"];
         [UIView animateWithDuration:.15f animations:^{
             self.oneLabel.alpha = 1.0f;
             self.twoLabel.alpha = 1.0f;
         }];
     }];
    [self start];
    self.oneTouch.enabled = YES;
    self.twoTouch.enabled = YES;
    self.threeTouch.enabled = YES;
    self.fourTouch.enabled = YES;
    self.fiveTouch.enabled = YES;
    [UIView animateWithDuration:0.33f animations:^{
        [self.loseView setAlpha:0];
    }];
    self.bannerView.hidden = YES;
    [self count];
    self.personSize = self.viewWidth/100.0f+30.0f;
    fontSize = self.personSize - 25.0f;
    [self.twoLabel setFont:[UIFont fontWithName:self.twoLabel.font.fontName size:fontSize]];
    [UIView animateWithDuration:.5f animations:^{
        self.personHeight.constant = self.personSize;
        self.personWidth.constant = self.personSize;
        [self.view layoutIfNeeded];
    }];
    self.person.layer.cornerRadius = self.personSize/2.0f;
}

-(void)enableWait{
    self.close.enabled = YES;
}

@end

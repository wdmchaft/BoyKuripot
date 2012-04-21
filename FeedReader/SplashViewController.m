//
//  SplashViewController.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"

@implementation SplashViewController

@synthesize loading;

-(void)viewDidLoad{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

-(void)viewDidAppear:(BOOL)animated{
    [loading startAnimating];
    FeedService *feedService = [[FeedService alloc] init];
    [feedService retrieveFeeds:kFeedUrl];
    [self next];
}

-(void)next{
    [self performSegueWithIdentifier:@"SplashSegue" sender:self];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self performSegueWithIdentifier:@"SplashSegue" sender:self];
}

@end

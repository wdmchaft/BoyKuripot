//
//  AboutViewController.m
//  Boy Kuripot
//
//  Created by Ana Katrina  Chong on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize aboutView;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];

    [self.aboutView.layer setCornerRadius:10];
    [self.aboutView.layer setMasksToBounds:YES];

}

-(IBAction)close:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

@end

//
//  UIViewController+Extends.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyViewController.h"

@implementation UIViewController (MyViewController)

-(UIDeviceOrientation)interfaceOrientation
{
    
    return [[UIDevice currentDevice] orientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        return YES;
    else
        return NO;
}

@end

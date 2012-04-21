//
//  SplashViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedService.h"
#import "Constants.h"
#import "WebContentService.h"
#import "ViewService.h"
#import "QuartzCore/QuartzCore.h"

@interface SplashViewController : UIViewController{
    UIActivityIndicatorView *loading;
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;

-(void)next;

@end

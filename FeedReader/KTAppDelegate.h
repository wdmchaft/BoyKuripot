//
//  KTAppDelegate.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashViewController.h"


@interface KTAppDelegate : UIResponder <UIApplicationDelegate>{

    SplashViewController *splashViewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet SplashViewController *splashViewController;


@end

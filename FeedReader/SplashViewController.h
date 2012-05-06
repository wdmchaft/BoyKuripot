//
//  SplashViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "FeedService.h"
#import "Constants.h"
#import "WebContentService.h"
#import "ViewService.h"
#import "QuartzCore/QuartzCore.h"
#import "/usr/include/sqlite3.h"

#define kFilename @"data.sqlite3"

@interface SplashViewController : UIViewController{

    sqlite3 *database;
    UIActivityIndicatorView *loading;
    
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;
@property (nonatomic, retain) IBOutlet IBOutlet UINavigationController *navigationController;

-(void)next;

-(NSString *)dataFilePath;
-(void)initDatabase;

@end

//
//  KTAppDelegate.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"

#define kFilename @"data.sqlite3"

@interface KTAppDelegate : UIResponder <UIApplicationDelegate>{
    sqlite3 *database;

}

@property (strong, nonatomic) UIWindow *window;

-(NSString *)dataFilePath;
-(void)initDatabase;

@end

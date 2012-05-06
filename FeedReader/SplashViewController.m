//
//  SplashViewController.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashViewController.h"
#import "Reachability.h"

@implementation SplashViewController

@synthesize loading;
@synthesize navigationController = _navigationController;

-(void)viewDidLoad{
    [self initDatabase];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

-(void)viewDidAppear:(BOOL)animated{
    // check if a pathway to the host exists
    Reachability *hostReachable = [Reachability reachabilityWithHostname:
                      @"www.boy-kuripot.com"];
    NetworkStatus status = [hostReachable currentReachabilityStatus];
    if(status != NotReachable)
    {
        [self performSelector:@selector(next) withObject:nil afterDelay:3];

    };
    
    if(status == NotReachable)
    {
        [self next];
    };
    
}

-(void)next{
    [_navigationController.view setFrame: [self.view bounds]];
    [self presentModalViewController:_navigationController animated:YES];
}

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(void)initDatabase{
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database.");
    }
    
    char *errorMsg;
    NSString *createFeedsSql = @"CREATE TABLE IF NOT EXISTS FEEDS(ID INTEGER PRIMARY KEY, BLOG_ENTRY_ID INTEGER, TITLE TEXT, CONTENT TEXT, URL TEXT, DATE_PUBLISHED DOUBLE, DATE_UPDATED DOUBLE);";
    if(sqlite3_exec(database, [createFeedsSql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *createImagesSql = @"CREATE TABLE IF NOT EXISTS IMAGES(ID INTEGER PRIMARY KEY, ENTRY_ID INTEGER, FILENAME TEXT, MAIN INTEGER, URL TEXT);";
    if(sqlite3_exec(database, [createImagesSql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }
    sqlite3_close(database);
    
}


@end

//
//  KTAppDelegate.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KTAppDelegate.h"

@implementation KTAppDelegate

@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
    }
    [self initDatabase];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
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
    NSString *createFeedsSql = @"CREATE TABLE IF NOT EXISTS FEEDS(ID INTEGER PRIMARY KEY, BLOG_ENTRY_ID INTEGER, TITLE TEXT, CONTENT TEXT, URL TEXT, DATE_PUBLISHED DATETIME, DATE_UPDATED DATETIME);";
    if(sqlite3_exec(database, [createFeedsSql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *createImagesSql = @"CREATE TABLE IF NOT EXISTS IMAGES(ID INTEGER PRIMARY KEY, ENTRY_ID INTEGER, IMAGE BLOB, MAIN INTEGER, URL TEXT);";
    if(sqlite3_exec(database, [createImagesSql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }
    sqlite3_close(database);
    
}


@end

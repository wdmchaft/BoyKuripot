//
//  KTMasterViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"
#import "FeedEntry.h"
#import "FeedEntryView.h"
#import "FeedService.h"
#import "ViewService.h"



@class KTDetailViewController;

@interface KTMasterViewController : UIViewController <FeedEntryViewDelegate, UIScrollViewDelegate>{
    UIScrollView *scrollView;
    
    sqlite3 *database;
    
    FeedService *feedService;
    
    FeedEntry *selectedRecord;
    
}

@property (strong, nonatomic) KTDetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) FeedService *feedService;

@property (nonatomic, retain) FeedEntry *selectedRecord;

-(NSString *)dataFilePath;

-(void)loadEntries;
-(void)retrieveEntries;

-(IBAction)addEntry:(id) sender count:(int) count;

- (void)showDetail:(FeedEntry *)entry;

@end

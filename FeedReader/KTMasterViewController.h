//
//  KTMasterViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "/usr/include/sqlite3.h"
#import "FeedEntry.h"
#import "FeedEntryView.h"
#import "FeedService.h"
#import "ViewService.h"
#import "GADBannerView.h"
#import "QuartzCore/QuartzCore.h"
#import "AboutViewController.h"
#import "Reachability.h"
#import "AdsService.h"

@class KTDetailViewController;

@interface KTMasterViewController : UIViewController <FeedEntryViewDelegate, UIScrollViewDelegate, FeedServiceDelegate>{

    UIScrollView *scrollView;
    sqlite3 *database;
    FeedService *feedService;
    FeedEntry *selectedRecord;
    UIActivityIndicatorView *loading;
    UILabel *loadingLabel;
    UILabel *messageLabel;
    UILabel *titleLabel;
    UIButton *refreshButton;
    UIButton *helpButton;
    NSMutableArray *entries;
    
}

@property (strong, nonatomic) IBOutlet KTDetailViewController *detailViewController;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loading;
@property (nonatomic, retain) IBOutlet UILabel *loadingLabel;
@property (nonatomic, retain) IBOutlet UILabel *messageLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIButton *refreshButton;
@property (nonatomic, retain) IBOutlet UIButton *helpButton;
@property (nonatomic, retain) FeedService *feedService;
@property (nonatomic, retain) FeedEntry *selectedRecord;
@property (nonatomic, retain) NSMutableArray *entries;

-(NSString *)dataFilePath;
-(IBAction)refreshFromServer;
-(void)retrieveFeedsFromServer;
-(void)retrieveEntries;
-(void)downloadingNewContent;
-(void)addNewEntries:newEntries;
-(IBAction)addEntry:(id) sender count:(int) count;
-(void)showDetail:(FeedEntry *)entry;
-(IBAction)about:(id) sender;
-(void)showMessage:(NSString *)message;
-(void)dismissMessage;

@end

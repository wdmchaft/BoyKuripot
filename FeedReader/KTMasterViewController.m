//
//
//  KTMasterViewController.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KTMasterViewController.h"
#import "KTDetailViewController.h"
#import "FeedEntryView.h"
#import "FeedEntry.h"
#import "Constants.h"

@implementation KTMasterViewController

@synthesize scrollView;
@synthesize detailViewController = _detailViewController;
@synthesize loading;
@synthesize loadingLabel;
@synthesize messageLabel;
@synthesize titleLabel;
@synthesize refreshButton;
@synthesize helpButton;

@synthesize feedService;

@synthesize selectedRecord;

@synthesize entries;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    entries = [[NSMutableArray alloc] init];
    [self retrieveEntries];

    [self refreshFromServer];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];

    // Initialize ads 
    GADBannerView *bannerView = [AdsService getAdsBanner];
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];

    [refreshButton.layer setCornerRadius:5];
    [refreshButton setClipsToBounds:YES];

    
}

-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kDataFile];
}

-(IBAction)refreshFromServer{
    // check if a pathway to the host exists
    Reachability *hostReachable = [Reachability reachabilityWithHostname:
                                   @"www.boy-kuripot.com"];
    NetworkStatus status = [hostReachable currentReachabilityStatus];
    if(status != NotReachable)
    {
        [loading startAnimating];
        [messageLabel setHidden:TRUE];
        [titleLabel setHidden:TRUE];
        [loading setHidden:FALSE];
        [loadingLabel setText:@"Checking for updates..."];
        [loadingLabel setHidden:FALSE];
        [refreshButton setEnabled:FALSE];
        [self performSelectorInBackground:@selector(retrieveFeedsFromServer) withObject:nil];
    }else{
        [self performSelectorOnMainThread:@selector(showMessage:) withObject:@"Can't connect to server." waitUntilDone:NO];    
    }
}

-(void)retrieveFeedsFromServer{
    self.feedService = [[FeedService alloc] init];
    [self.feedService setDelegate:self];
    [self.feedService retrieveFeeds:kFeedUrl];
}

-(void)retrieveEntries{
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK){
        // error handling
    }
    FeedEntry *entry = [[FeedEntry alloc] init];
    entry.database = database;
    NSMutableArray *retrievedEntries = [entry retrieveAll];
    int count = 0;
    for(FeedEntry *record in retrievedEntries){
        record.database = database;
        [self addEntry:record count:count];

        count++;
    }
    sqlite3_close(database);
}

-(void)addEntry:(FeedEntry *) record count:(int) count{
    FeedEntryView *entryView = [[FeedEntryView alloc] initWithEntry:record];
    [entryView setUserInteractionEnabled:TRUE];
    [entryView setDelegate:self];
    float y = 80.0f + (160.0f * count);
    [entryView setCenter:CGPointMake(160.0f, y)];
    [self.scrollView addSubview:entryView]; 
    [self.scrollView setContentSize:CGSizeMake(280.0f, y + 200.0f)];
    [entries addObject:entryView];
}

- (void)showDetail:(FeedEntry *)entry{
    self.selectedRecord = entry;
    _detailViewController.detailItem = entry;
    [self.navigationController pushViewController:_detailViewController animated:YES];
}

-(void)didStartDownloadingNewContent{
    NSLog(@"Downloading New Content");
    [self performSelectorOnMainThread:@selector(downloadingNewContent) withObject:nil waitUntilDone:NO];
}

-(void)downloadingNewContent{
    [loadingLabel setText:@"Downloading new content..."];
}

-(void)didFinishDownloading:newEntries{
    NSLog(@"Finished Downloading");
    [self performSelectorOnMainThread:@selector(addNewEntries:) withObject:newEntries waitUntilDone:NO];
}

-(void)addNewEntries:newEntries{
    int size = [newEntries count];
    for(FeedEntryView *entry in entries){
        CGPoint entryCenter = entry.center;
        CGPoint newCenter = CGPointMake(entryCenter.x, entryCenter.y + (160 * size));
        [entry setCenter:newCenter];
    }
    int count = 0;
    for(FeedEntry *record in newEntries){
        record.database = database;
        [self addEntry:record count:count];
        
        count++;
    }
    NSInteger entryCount = [newEntries count];
    if(entryCount == 0){
        [self showMessage:[NSString stringWithFormat: @"No new entries found.", entryCount]];
    }else{
        [self showMessage:[NSString stringWithFormat: @"Retrieved %d new entries.", entryCount]];
    }
}

-(IBAction)about:(id)sender{
    AboutViewController *about = [[AboutViewController alloc]init];
    
    [self presentModalViewController:about animated:YES];
}

-(void)showMessage:(NSString *)message{
    messageLabel.text = message;
    [loading setHidden:TRUE];
    [loadingLabel setHidden:TRUE];
    [titleLabel setHidden:TRUE];
    [messageLabel setHidden:FALSE];
    [refreshButton setEnabled:TRUE];
    [self performSelector:@selector(dismissMessage) withObject:nil afterDelay:3];
}

-(void)dismissMessage{
    [messageLabel setHidden:TRUE];
    [titleLabel setHidden:FALSE];
}

@end

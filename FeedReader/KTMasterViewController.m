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

@synthesize feedService;

@synthesize selectedRecord;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (KTDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.feedService = [[FeedService alloc] init];
    [self retrieveEntries];

    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kDataFile];
}

-(void)loadEntries{
    [self.feedService retrieveFeeds:kFeedUrl];
}

-(void)retrieveEntries{
    if(sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK){
        // error handling
    }
    FeedEntry *entry = [[FeedEntry alloc] init];
    entry.database = database;
    NSMutableArray *entries = [entry retrieveAll];
    int count = 0;
    for(FeedEntry *record in entries){
        [self addEntry:record count:count];
        /*NSMutableArray *images = [WebContentService getImages:record.content];
        int main = 1;
        for(NSString *imageSource in images){
            FeedEntryImage *image = [[FeedEntryImage alloc] init];
            image.database = database;
            image.feedEntry = record;
            NSURL *imageUrl = [NSURL URLWithString:imageSource];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
            image.image = [[UIImage alloc] initWithData:imageData];
            image.main = main;
            image.url = imageSource;
            [image save];
            if(main==1) main = 0;
        }*/

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
}

- (void)showDetail:(FeedEntry *)entry{
    self.selectedRecord = entry;
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetailSegue"]) {
        NSLog(@"Got segue request...");
        
        KTDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.detailItem = self.selectedRecord;
    }
}

@end

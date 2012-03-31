//
//  KTMasterViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KTDetailViewController;

@interface KTMasterViewController : UITableViewController

@property (strong, nonatomic) KTDetailViewController *detailViewController;

@end

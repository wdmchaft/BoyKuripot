//
//  KTDetailViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntryLabel.h"
#import "FeedEntry.h"
#import "WebContentService.h"
#import "ViewService.h"
#import "QuartzCore/QuartzCore.h"

@interface KTDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>{
    
    FeedEntryLabel *label;
    UIImageView *imageView;
    UIWebView *contentView;
    
    
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet FeedEntryLabel *label;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIWebView *contentView;

@end

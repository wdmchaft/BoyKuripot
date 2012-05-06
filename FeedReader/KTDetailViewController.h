//
//  KTDetailViewController.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "FeedEntryLabel.h"
#import "FeedEntry.h"
#import "FeedEntryImage.h"
#import "WebContentService.h"
#import "ViewService.h"
#import "QuartzCore/QuartzCore.h"
#import "GADBannerView.h"
#import <MessageUI/MessageUI.h>
#import "AdsService.h"

@interface KTDetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>{
    
    FeedEntryLabel *label;
    FeedEntryLabel *dateLabel;
    UIWebView *contentView;
    
}

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet FeedEntryLabel *label;
@property (strong, nonatomic) IBOutlet FeedEntryLabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIWebView *contentView;

-(void)share;
-(void)shareEmail;

@end

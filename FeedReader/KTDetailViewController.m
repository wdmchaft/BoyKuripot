//
//  KTDetailViewController.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KTDetailViewController.h"


@interface KTDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation KTDetailViewController

@synthesize detailItem = _detailItem;
@synthesize label;
@synthesize dateLabel;
@synthesize contentView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    if (self.detailItem) {
        FeedEntry *entry = self.detailItem;
        self.label.text = [self.detailItem title];
        [contentView loadHTMLString:[WebContentService formatFeedEntryContent:entry] baseURL:nil];
        [contentView setDelegate:self];
        
    }
}


// disable links
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		return NO;	
	}
	return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureView];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [ViewService getBackgroundGradientColors];
    [self.view.layer insertSublayer:gradient atIndex:0];

    // Initialize ads 
    GADBannerView *bannerView = [AdsService getAdsBanner];
    bannerView.rootViewController = self;
    [self.view addSubview:bannerView];
    [bannerView loadRequest:[GADRequest request]];
    
    dateLabel.text = [@"Posted on: " stringByAppendingString:[self.detailItem getDateUpdatedString]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // initialize share button
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithImage: [UIImage imageNamed:@"share.png"]
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(share)];
    
    self.navigationItem.rightBarButtonItem = shareButton;
}

-(void)share{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Options"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Open in Safari", @"Share via Email", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){ //open in Safari
        FeedEntry *item = self.detailItem;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.url]];
    }
    if(buttonIndex == 1){ //share via email
        [self shareEmail];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void)shareEmail{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:NSLocalizedString(@"ShareEmailSubject", @"")];
        
        FeedEntry *item = self.detailItem;
        
        NSString *emailBody = [[(NSString *)NSLocalizedString(@"ShareEmailMessage",@"") stringByReplacingOccurrencesOfString:@"{LINK}" withString:item.url] stringByReplacingOccurrencesOfString:@"{TITLE}" withString:item.title];
        [mailer setMessageBody:emailBody isHTML:YES];
        
        [self presentModalViewController:mailer animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}


@end

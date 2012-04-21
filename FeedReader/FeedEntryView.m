//
//  FeedEntryView.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntryView.h"
#import "FeedEntryLabel.h"

@implementation FeedEntryView

@synthesize image;
@synthesize entry;

@synthesize delegate;

-(id)initWithEntry:(FeedEntry *) anEntry{
    id result = [super initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 150.0f)];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:10];
    [self.layer setMasksToBounds:YES];
    self.entry = anEntry;

    FeedEntryLabel *titleLabel = [[FeedEntryLabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 260.0f, 30.0f)];
    titleLabel.text = self.entry.title;
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    [titleLabel setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:titleLabel];
    
    UIWebView *contentView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0f, 45.0f, 170.0f, 90.0f)];
    NSString *content = [WebContentService formatFeedEntryContent:self.entry.content];
    [contentView loadHTMLString:content baseURL:nil];
    [contentView setDelegate:self];
    [contentView.scrollView setScrollEnabled:FALSE];
    [contentView setDataDetectorTypes:UIDataDetectorTypeNone];
    [self addSubview:contentView];
    return result;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(-15, 20), 5);
    [super drawRect: rect];
    CGContextRestoreGState(currentContext);    
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		return NO;	
	}
	return YES;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.delegate showDetail:self.entry];
}

@end

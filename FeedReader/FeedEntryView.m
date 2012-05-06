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
    [self setDelegate:self];
    
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
    
    FeedEntryLabel *dateLabel = [[FeedEntryLabel alloc] initWithFrame:CGRectMake(10.0f, 35.0f, 260.0f, 20.0f)];
    [dateLabel setFont:[UIFont fontWithName:@"Arial" size:10.0]];
    dateLabel.text = [@"Posted on: " stringByAppendingString:[self.entry getDateUpdatedString]];
    [dateLabel setTextAlignment:UITextAlignmentCenter];
    [dateLabel setAdjustsFontSizeToFitWidth:TRUE];
    [self addSubview:dateLabel];
    
    UIWebView *contentView = [[UIWebView alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 170.0f, 85.0f)];
    NSString *content = [WebContentService formatFeedEntryContent:self.entry];
    [contentView loadHTMLString:content baseURL:nil];
    [contentView setDelegate:self];
    [contentView setDataDetectorTypes:UIDataDetectorTypeNone];
    [self addSubview:contentView];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 50.0f, 170.0f, 85.0f)];
    [self addSubview:coverView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(180.0f, 50.0f, 90.0f, 90.0f)];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    if([self.entry hasImages]){
        FeedEntryImage *feedEntryImage = [self.entry.images objectAtIndex:0];
        [imageView setImage:[UIImage imageWithContentsOfFile:feedEntryImage.filename]];
    }else{
        NSMutableArray *webImages = [WebContentService getImages:self.entry.content];
        if([webImages count] > 0){
            NSURL *imageUrl = [NSURL URLWithString:[webImages objectAtIndex:0]];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
            [imageView setImage:[UIImage imageWithData:imageData]];
        }
    }
    [self addSubview:imageView];
    
    FeedEntryLabel *ellipsisLabel = [[FeedEntryLabel alloc] initWithFrame:CGRectMake(158.0f, 122.0f, 12.0f, 17.0f)];
    [ellipsisLabel setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    ellipsisLabel.text = @"...";
    [ellipsisLabel setTextAlignment:UITextAlignmentCenter];
    [self addSubview:ellipsisLabel];

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

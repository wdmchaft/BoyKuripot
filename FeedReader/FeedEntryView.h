//
//  FeedEntryView.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedEntry.h"
#import "WebContentService.h"
#import "QuartzCore/QuartzCore.h"

@protocol FeedEntryViewDelegate
- (void)showDetail:(FeedEntry *)entry;
@end

@interface FeedEntryView : UIScrollView <UIWebViewDelegate>{
    
    UIImageView *image;
    
    FeedEntry *entry;
}

@property (nonatomic, retain) UIImageView *image;
@property (nonatomic, retain) FeedEntry *entry;
@property (nonatomic, assign) id <FeedEntryViewDelegate> delegate;


-(id)initWithEntry:(FeedEntry *) anEntry;

@end

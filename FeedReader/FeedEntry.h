//
//  FeedEntry.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbRecord.h"

#define kTableName @"FEEDS"
#define kFields @"TITLE, CONTENT"

@interface FeedEntry : DbRecord{
    
    NSString *title;
    NSString *content;
    NSDate *datePublished;
    NSDate *dateUpdated;
    
}    


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSDate *datePublished;
@property (nonatomic, retain) NSDate *dateUpdated;
    
@end

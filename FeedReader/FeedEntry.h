//
//  FeedEntry.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbRecord.h"
#import "WebContentService.h"

#define kTableName @"FEEDS"
#define kFields @"ENTRY_ID, TITLE, CONTENT"

@interface FeedEntry : DbRecord{
    
    NSString *entryId;
    NSString *title;
    NSString *content;
    NSString *url;
    NSDate *datePublished;
    NSDate *dateUpdated;
    
    Boolean isNew;
    
    NSMutableArray *images;
    
}    


@property (nonatomic, retain) NSString *entryId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSDate *datePublished;
@property (nonatomic, retain) NSDate *dateUpdated;

@property (nonatomic, retain) NSMutableArray *images;

@property (nonatomic) Boolean isNew;

-(void)retrieveByEntryId;

-(void)retrieveImagesFromServer;
-(void)retrieveImages;
-(BOOL)hasImages;

-(NSString *)getDateUpdatedString;
    
@end

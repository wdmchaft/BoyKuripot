//
//  FeedEntryImage.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DbRecord.h"
#import "FeedEntry.h"

#define kTableName @"IMAGES"
#define kFields @"ENTRY_ID, FILENAME, MAIN, URL"

@interface FeedEntryImage : DbRecord{
    
    FeedEntry *feedEntry;
    NSString *filename;
    int main;
    NSString *url;

}    


@property (nonatomic, retain) FeedEntry *feedEntry;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic) int main;
@property (nonatomic, retain) NSString *url;

-(NSMutableArray *)retrieveAllByEntryId;

@end

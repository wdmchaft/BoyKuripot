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
#define kFields @"ENTRY_ID, IMAGE, MAIN, URL"

@interface FeedEntryImage : DbRecord{
    
    FeedEntry *feedEntry;
    UIImage *image;
    int main;
    NSString *url;

}    


@property (nonatomic, retain) FeedEntry *feedEntry;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) int main;
@property (nonatomic, retain) NSString *url;

@end

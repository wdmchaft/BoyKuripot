//
//  FeedService.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedEntryXmlParser.h"
#import "/usr/include/sqlite3.h"
#import "DatabaseService.h"
#import "WebContentService.h"
#import "FeedEntry.h"
#import "FeedEntryImage.h"

@interface FeedService : NSObject{
    
    FeedEntryXmlParser *parser;
    sqlite3 *database;
    
}

@property (nonatomic, retain) FeedEntryXmlParser *parser;

-(void)retrieveFeeds:(NSString *) url;


@end

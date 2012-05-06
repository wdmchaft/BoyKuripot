//
//  FeedService.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedService.h"

@implementation FeedService

@synthesize parser;
@synthesize delegate;

-(id)init{
    id result = [super init];
    self.parser = [[FeedEntryXmlParser alloc] init];
    return result;
}

-(void)retrieveFeeds:(NSString *) url{
    [self.parser parseXmlFileAtUrl:url];
    if(sqlite3_open([[DatabaseService dataFilePath] UTF8String], &database) != SQLITE_OK){
        // error handling
    }
    NSMutableArray *newEntries  = [[NSMutableArray alloc] init];
    for(FeedEntry *record in self.parser.entries){
        record.database = database;
        [record save];
        if(record.isNew){
            [delegate didStartDownloadingNewContent];
            [record retrieveImagesFromServer];
            [newEntries addObject:record];
        }
    }
    sqlite3_close(database);
    [delegate didFinishDownloading:newEntries];
}


@end

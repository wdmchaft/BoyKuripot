//
//  FeedEntry.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntry.h"
#import "FeedEntryImage.h"

@implementation FeedEntry

@synthesize entryId;
@synthesize title;
@synthesize content;
@synthesize url;
@synthesize datePublished;
@synthesize dateUpdated;
@synthesize images;

@synthesize isNew;

// Override
-(id)init{
    self.tableName = @"FEEDS";
    self.fields = @"ID, BLOG_ENTRY_ID, TITLE, CONTENT, URL, DATE_PUBLISHED, DATE_UPDATED";
    isNew = false;
    return [super init];
}

-(void)build:(sqlite3_stmt *)statement{
    self.recordId = [self getInt:statement column:0];
    self.entryId = [self getText:statement column:1];
    self.title = [self getText:statement column:2];
    self.content = [self getText:statement column:3];
    self.url = [self getText:statement column:4];
    self.datePublished = [self getDate:statement column:5];
    self.dateUpdated = [self getDate:statement column:6];
}

-(void)clear{
    self.recordId = nil;
    self.entryId = nil;
    self.title = nil;
    self.content = nil;
    self.url = nil;
    self.datePublished = nil;
    self.dateUpdated = nil;
}


-(void)save{
    if(![self exists]){
        NSString *query = [[[NSString alloc] initWithString:@"insert into TABLE_NAME (BLOG_ENTRY_ID, TITLE, CONTENT, URL, DATE_PUBLISHED, DATE_UPDATED) values (?, ?, ?, ?, ?, ?)"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName];
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
            sqlite3_bind_text(statement, 1, [self.entryId UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [self.title UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [self.content UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [self.url UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_double(statement, 5, [self.datePublished timeIntervalSince1970]);
            sqlite3_bind_double(statement, 6, [self.dateUpdated timeIntervalSince1970]);
        }else{
            NSAssert1(0, @"Error: %s", sqlite3_errmsg(database));
        }
        if(sqlite3_step(statement) != SQLITE_DONE){
            NSAssert(0,@"Error on Insert.", sqlite3_errmsg(database));   
        }
        self.recordId = sqlite3_last_insert_rowid(database);
        self.isNew = true;
    }
}

-(NSMutableArray *)retrieveAll{
    NSMutableArray *result = [[NSMutableArray alloc] init]; 
    
    NSString *query = [[[[NSString alloc] initWithString:@"select * from TABLE_NAME order by DATE_PUBLISHED desc"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:self.fields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        while(sqlite3_step(statement) == SQLITE_ROW){
            DbRecord *dbRecord = [[[self class] alloc] init];
            [dbRecord build:statement];
            [result addObject:dbRecord];
        }
    }
    return result;
}

-(void)retrieveByEntryId{
    NSString *query = [[[[NSString alloc] initWithString:@"select * from TABLE_NAME where BLOG_ENTRY_ID=?"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:fields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_text(statement, 1, [self.entryId UTF8String], -1, SQLITE_TRANSIENT);
    }
    while(sqlite3_step(statement) == SQLITE_ROW){
        [self build:statement];
    }
}

-(BOOL)hasImages{
    [self retrieveImages];
    return (self.images.count >0);
}



-(BOOL)exists{
    [self retrieveByEntryId];
    return (self.recordId != nil);
}

-(void)retrieveImages{
    FeedEntryImage *feedEntryImage = [[FeedEntryImage alloc] init];
    feedEntryImage.database = database;
    feedEntryImage.feedEntry = self;
    self.images = [feedEntryImage retrieveAllByEntryId];
}

-(void)retrieveImagesFromServer{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableArray *webImages = [WebContentService getImages:self.content];
    int main = 1;
    int count = 1;
    for(NSString *imageSource in webImages){
        NSURL *imageUrl = [NSURL URLWithString:imageSource];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
        NSString *filename = [NSString stringWithFormat:@"images_%d_%d.jpg", self.recordId, count];
        NSString *localFilePath = [documentsDirectory stringByAppendingPathComponent:filename];
        [imageData writeToFile:localFilePath atomically:YES];
        FeedEntryImage *image = [[FeedEntryImage alloc] init];
        image.database = database;
        image.feedEntry = self;
        image.filename=localFilePath;
        image.main = main;
        image.url = imageSource;
        [image save];
        if(main==1) main = 0;
        count++;
    }
}

-(NSString *)getDateUpdatedString{
    return [self getDateString:self.dateUpdated];
}

@end

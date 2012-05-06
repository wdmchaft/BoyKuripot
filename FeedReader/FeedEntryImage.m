//
//  FeedEntryImage.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntryImage.h"

@implementation FeedEntryImage

@synthesize feedEntry;
@synthesize filename;
@synthesize main;
@synthesize url;

// Override
-(id)init{
    self.tableName = kTableName;
    self.fields = @"ENTRY_ID, FILENAME, MAIN, URL";
    return [super init];
}

-(void)build:(sqlite3_stmt *)statement{
    self.feedEntry = [[FeedEntry alloc]init];
    self.feedEntry.recordId = [self getInt:statement column:0];
    self.filename = [self getText:statement column:1];
    self.main = [self getInt:statement column:2];
    self.url = [self getText:statement column:3];
}

-(void)clear{
    self.feedEntry = nil;
    self.filename = nil;
    self.main = nil;
    self.url = nil;
}


-(void)save{
    NSString *query = [[[[NSString alloc] initWithString:@"insert into TABLE_NAME (*) values (?, ?, ?, ?)"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:kFields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_int(statement, 1, self.feedEntry.recordId);
        sqlite3_bind_text(statement, 2, [self.filename UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 3, self.main);
        sqlite3_bind_text(statement, 4, [self.url UTF8String], -1, SQLITE_TRANSIENT);
    }else{
        NSAssert1(0, @"Error: %s", sqlite3_errmsg(database));
    }
    if(sqlite3_step(statement) != SQLITE_DONE){
        NSAssert(0,@"Error on Insert.", sqlite3_errmsg(database));   
    }
    self.recordId = sqlite3_last_insert_rowid(database);
}


-(NSMutableArray *)retrieveAllByEntryId{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0]; 
    
    NSString *query = [[[NSString alloc] initWithString:@"select b.ENTRY_ID, b.FILENAME, b.MAIN, b.URL from FEEDS a, IMAGES b where a.BLOG_ENTRY_ID=? and a.ID = b.ENTRY_ID"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_text(statement, 1, [self.feedEntry.entryId UTF8String], -1, SQLITE_TRANSIENT);
        while(sqlite3_step(statement) == SQLITE_ROW){
            FeedEntryImage *feedEntryImage = [[FeedEntryImage alloc] init];
            [feedEntryImage build:statement];
            [result addObject:feedEntryImage];
        }
    }
    return result;
}

@end

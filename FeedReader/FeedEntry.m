//
//  FeedEntry.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntry.h"

@implementation FeedEntry

@synthesize title;
@synthesize content;
@synthesize datePublished;
@synthesize dateUpdated;

// Override
-(id)init{
    self.tableName = kTableName;
    self.fields = kFields;
    return [super init];
}

-(void)build:(sqlite3_stmt *)statement{
    //self.image = sqlite3_column_blob(statement,0);
    self.title = [self getText:statement column:0];
    self.content = [self getText:statement column:1];
    //self.datePublished = [self getDate:statement column:2];
    //self.dateUpdated = [self getDate:statement column:3];
}

-(void)clear{
    self.title = nil;
    self.content = nil;
}


-(void)save{
    NSString *query = [[[[NSString alloc] initWithString:@"insert into TABLE_NAME (*) values (?, ?)"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:kFields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_text(statement, 1, [self.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [self.content UTF8String], -1, SQLITE_TRANSIENT);
    }else{
        NSAssert1(0, @"Error: %s", sqlite3_errmsg(database));
    }
    if(sqlite3_step(statement) != SQLITE_DONE){
        NSAssert(0,@"Error on Insert.", sqlite3_errmsg(database));   
    }
    self.id = sqlite3_last_insert_rowid(database);
}

@end

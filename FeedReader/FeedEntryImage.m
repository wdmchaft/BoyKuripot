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
@synthesize image;
@synthesize main;
@synthesize url;

// Override
-(id)init{
    self.tableName = kTableName;
    self.fields = kFields;
    return [super init];
}

-(void)build:(sqlite3_stmt *)statement{
}

-(void)clear{
    self.feedEntry = nil;
    self.image = nil;
    self.main = nil;
    self.url = nil;
}


-(void)save{
    NSString *query = [[[[NSString alloc] initWithString:@"insert into TABLE_NAME (*) values (?, ?, ?, ?)"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:kFields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_int(statement, 1, self.feedEntry.id);
        NSData *imgData = UIImagePNGRepresentation(self.image);
        
        if(self.image != nil)
            sqlite3_bind_blob(statement, 2, [imgData bytes], [imgData length], NULL);
        else
            sqlite3_bind_blob(statement, 2, nil, -1, NULL);
        sqlite3_bind_int(statement, 3, self.main);
        sqlite3_bind_text(statement, 4, [self.url UTF8String], -1, SQLITE_TRANSIENT);
    }else{
        NSAssert1(0, @"Error: %s", sqlite3_errmsg(database));
    }
    if(sqlite3_step(statement) != SQLITE_DONE){
        NSAssert(0,@"Error on Insert.", sqlite3_errmsg(database));   
    }
    self.id = sqlite3_last_insert_rowid(database);
}

@end

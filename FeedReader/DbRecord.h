//
//  DbRecord.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"

#define kFields @"*"

@interface DbRecord : NSObject{

    sqlite3 *database;
    NSString *tableName;
    
    int recordId;
    NSString *fields;
}

@property (nonatomic) sqlite3 *database;
@property (nonatomic, retain) NSString *tableName;

@property (nonatomic) int recordId;
@property (nonatomic, retain) NSString *fields;

-(int)getInt:(sqlite3_stmt *) statement  column:(int) column;
-(NSString *)getText:(sqlite3_stmt *) statement  column:(int) column;
-(NSDate *)getDate:(sqlite3_stmt *) statement  column:(int) column;

-(NSString *)getDateString:(NSDate *)date;

-(NSMutableArray *)retrieveAll;
-(void)retrieve;
-(void)save;
-(void)delete;
-(void)deleteAll;

-(BOOL)exists;

-(void)build:(sqlite3_stmt *) statement;

-(void)clear;



@end

//
//  DbRecord.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DbRecord.h"

@implementation DbRecord

@synthesize database;
@synthesize tableName;

@synthesize recordId;
@synthesize fields;

-(int)getInt:(sqlite3_stmt *) statement  column:(int) column{
    return sqlite3_column_int(statement,column);
}

-(NSString *)getText:(sqlite3_stmt *) statement  column:(int) column{
    char *text = (char *)sqlite3_column_text(statement,column);
    if(text==nil){
        return @"";
    }else{
        return [[NSString alloc] initWithUTF8String:text];
    }
}

-(NSDate *)getDate:(sqlite3_stmt *) statement  column:(int) column{ 
    return [NSDate dateWithTimeIntervalSince1970:sqlite3_column_double(statement, column)];    
}

-(NSString *)getDateString:(NSDate *)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMMM dd, yyyy hh:mm a"];
    return [dateFormat stringFromDate:date];  
}

-(NSMutableArray *)retrieveAll{
    NSMutableArray *result = [[NSMutableArray alloc] init]; 

    NSString *query = [[[[NSString alloc] initWithString:@"select * from TABLE_NAME"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:self.fields];
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

-(void)retrieve{
    NSString *query = [[[[NSString alloc] initWithString:@"select * from TABLE_NAME where ID=?"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName] stringByReplacingOccurrencesOfString:@"*" withString:fields];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK){
        sqlite3_bind_int(statement, 1, recordId);
    }
    while(sqlite3_step(statement) == SQLITE_ROW){
        [self build:statement];
    }
}

-(void)deleteAll{
    NSString *query = [[[NSString alloc] initWithString:@"delete from TABLE_NAME"] stringByReplacingOccurrencesOfString:@"TABLE_NAME" withString:tableName];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) != SQLITE_OK){
        NSAssert1(0, @"Error: %s", sqlite3_errmsg(database));
    }
    if(sqlite3_step(statement) != SQLITE_DONE){
        NSAssert(0,@"Error on Insert.", sqlite3_errmsg(database));   
    }
}

-(BOOL)exists{
    [self retrieve];
    return (self.recordId != nil);
}

@end

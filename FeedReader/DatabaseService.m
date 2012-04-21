//
//  DatabaseService.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatabaseService.h"

@implementation DatabaseService

+(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kDataFile];
}

@end

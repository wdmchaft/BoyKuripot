//
//  WebContentService.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebContentService : NSObject

+(NSMutableArray *)getImages:(NSString *)content;
+(NSString *)findNextString:(NSString *)substring fromString:(NSString *)fromString;
+(NSString *)findNextQuotedString:(NSString *)fromString;
+(NSString *)formatFeedEntryContent:(NSString *)content;

@end

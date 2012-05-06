//
//  WebContentService.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedEntry;

@interface WebContentService : NSObject

+(NSMutableArray *)getImages:(NSString *)content;
+(NSUInteger)findNextStringIndex:(NSString *)substring fromString:(NSString *)fromString;
+(NSString *)findNextString:(NSString *)substring fromString:(NSString *)fromString;
+(NSString *)findNextQuotedString:(NSString *)fromString;
+(NSString *)extractNextImageTag:(NSString *)fromString;
+(NSString *)setTagAttribute:(NSString *)tagString attributeName:(NSString *)attributeName value:(NSString *)value;

+(NSString *)formatFeedEntryContent:(FeedEntry *)content;

@end

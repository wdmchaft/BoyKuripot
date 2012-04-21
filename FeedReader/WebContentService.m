//
//  WebContentService.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebContentService.h"

@implementation WebContentService

+(NSMutableArray *)getImages:(NSString *)content{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSString *substring = [self findNextString:@"<img" fromString:content];
    while([substring compare:@""] != NSOrderedSame){
        NSString *srcString = [self findNextString:@"src" fromString:substring];
        NSString *equalsString = [self findNextString:@"=" fromString:srcString];
        NSString *imageSource = [self findNextQuotedString:[equalsString substringFromIndex:1]];
        [images addObject:imageSource];
        substring = [self findNextString:@"&lt;img" fromString:equalsString];
    }
    return images;
}

+(NSString *)findNextString:(NSString *)substring fromString:(NSString *)fromString{
    NSScanner *scanner = [NSScanner scannerWithString:fromString];
    [scanner scanUpToString:substring intoString:nil];
    NSInteger left = [scanner scanLocation];
    return [fromString substringFromIndex:left];
}

// Find the next quoted string
+(NSString *)findNextQuotedString:(NSString *)fromString{
    NSString *trimmedString = [fromString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *quotesChar = [trimmedString substringToIndex:1];    
    NSString *quotedString = [trimmedString substringFromIndex:1];
    NSScanner *scanner = [NSScanner scannerWithString:quotedString];
    [scanner scanUpToString:quotesChar intoString:nil];
    NSInteger left = [scanner scanLocation];
    return [quotedString substringToIndex:left];
}

+(NSString *)formatFeedEntryContent:(NSString *)content{
    NSError *error = nil;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"homeEntry" ofType:@"css"];
    NSString *css = [NSString stringWithContentsOfFile:fullPath encoding: NSUTF8StringEncoding error: &error];
    return [css stringByAppendingString:content];
}           

+(NSString *)removeLinks:(NSString *)content{
    
}
                    


@end

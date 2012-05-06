//
//  WebContentService.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebContentService.h"
#import "FeedEntry.h"

@implementation WebContentService

+(NSMutableArray *)getImages:(NSString *)content{
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSString *substring = [self findNextString:@"<img" fromString:content];
    while([substring compare:@""] != NSOrderedSame){
        NSString *srcString = [self findNextString:@"src" fromString:substring];
        NSString *equalsString = [self findNextString:@"=" fromString:srcString];
        NSString *imageSource = [self findNextQuotedString:[equalsString substringFromIndex:1]];
        [images addObject:imageSource];
        substring = [self findNextString:@"<img" fromString:equalsString];
    }
    return images;
}

+(NSUInteger)findNextStringIndex:(NSString *)substring fromString:(NSString *)fromString{
    NSScanner *scanner = [NSScanner scannerWithString:fromString];
    [scanner scanUpToString:substring intoString:nil];
    return [scanner scanLocation];
}

+(NSString *)findNextString:(NSString *)substring fromString:(NSString *)fromString{
    NSUInteger left = [self findNextStringIndex:substring fromString:fromString];
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

// Find the next quoted string
+(NSString *)replaceQuotedString:(NSString *)fromString withString:(NSString *) withString{
    NSString *trimmedString = [fromString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *quotesChar = [trimmedString substringToIndex:1];    
    NSString *quotedString = [trimmedString substringFromIndex:1];
    NSScanner *scanner = [NSScanner scannerWithString:quotedString];
    [scanner scanUpToString:quotesChar intoString:nil];
    NSInteger left = [scanner scanLocation];
    return [[[quotesChar stringByAppendingString:withString] stringByAppendingString:quotesChar] stringByAppendingString:[quotedString substringFromIndex:left]];
}

+(NSString *)extractNextImageTag:(NSString *)fromString{
    NSScanner *scanner = [NSScanner scannerWithString:fromString];
    [scanner scanUpToString:@"<img" intoString:nil];
    NSInteger left = [scanner scanLocation];
    NSString *rightSubstring = [fromString substringFromIndex:left];
    scanner = [NSScanner scannerWithString:rightSubstring];
    [scanner scanUpToString:@">" intoString:nil];
    NSInteger right = [scanner scanLocation];
    return [rightSubstring substringToIndex:right];
}

+(NSString *)setTagAttribute:(NSString *)tagString attributeName:(NSString *)attributeName value:(NSString *)value{
    NSScanner *scanner = [NSScanner scannerWithString:tagString];
    [scanner scanUpToString:attributeName intoString:nil];
    [scanner scanUpToString:@"=" intoString:nil];
    NSInteger equalsIndex = [scanner scanLocation];
    if(equalsIndex >= [tagString length]){
        NSString *attrString = [[[attributeName stringByAppendingString:@"='"] stringByAppendingString:value] stringByAppendingString:@"'"];
        NSString *trimmedTagString = [tagString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return [[[trimmedTagString substringToIndex:[trimmedTagString length]-1] stringByAppendingString:attrString] stringByAppendingString:@">"];
    }else{
        NSString *equalsString = [tagString substringFromIndex:equalsIndex+1];
        NSString *newString = [self replaceQuotedString:equalsString withString:value];
        return [[tagString substringToIndex:equalsIndex+1] stringByAppendingString:newString];
    }
}


+(NSString *)formatFeedEntryContent:(FeedEntry *)entry{
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"homeEntry" ofType:@"css"];
    NSString *css = [NSString stringWithContentsOfFile:fullPath encoding: NSUTF8StringEncoding error: &error];
    //content = [content stringByReplacingOccurrencesOfString:@"<img" withString:@"<dummyimg"];    
    NSString *content = entry.content;
    NSString *imageTag = [self extractNextImageTag:content];
    int count = 1;
    while([imageTag compare:@""] != NSOrderedSame){
        NSUInteger index = [self findNextStringIndex:imageTag fromString:content];
        NSString *leftString = [content substringToIndex:index];
        NSInteger rightIndex = index  + [imageTag length] + 1;
        NSString *rightString = [content substringFromIndex:rightIndex];
        imageTag = [self setTagAttribute:imageTag attributeName:@"src" value:[@"file://"    stringByAppendingString:[[documentsDirectory stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByAppendingString:[NSString stringWithFormat: @"/images_%d_%d.jpg", entry.recordId, count]]]];
        imageTag = [self setTagAttribute:imageTag attributeName:@"style" value:@"width:280px;"];
        content = [[leftString stringByAppendingString:imageTag] stringByAppendingString:rightString];  
        imageTag = [self extractNextImageTag:rightString];
        count++;
    }
    return [css stringByAppendingString:content];
}           
        


@end

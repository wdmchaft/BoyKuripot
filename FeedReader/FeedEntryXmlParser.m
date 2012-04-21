//
//  FeedEntryXmlParser.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntryXmlParser.h"

@implementation FeedEntryXmlParser

@synthesize currentEntry;

-(void)parser: (NSXMLParser *) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    currentElement = [elementName copy];
    if([elementName isEqualToString:@"entry"]){
        currentEntry = [[FeedEntry alloc] init];
    }
}

-(void)parser: (NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"entry"]){
        [entries addObject:currentEntry];
    }
}

-(void)parser: (NSXMLParser *) parser foundCharacters:(NSString *)string{
    if([currentElement isEqualToString:@"title"]){
        currentEntry.title = string;
    }
    if([currentElement isEqualToString:@"content"]){
        if(currentEntry.content == nil){
            currentEntry.content = string;
        }else{
            currentEntry.content = [currentEntry.content stringByAppendingString:string];
        }
    }
}

@end

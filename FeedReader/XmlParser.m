//
//  XmlParser.m
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XmlParser.h"

@implementation XmlParser

@synthesize currentElement;
@synthesize entries;


-(void)parseXmlFileAtUrl:(NSString *)url {
    NSURL *xmlUrl = [NSURL URLWithString:url];
//    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:@"/Users/anakatrinachong/Documents/FeedTest.xml"];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
    //[[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
    [rssParser setDelegate:self];
    [rssParser parse];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    entries = [[NSMutableArray alloc] init];
}

-(void)parser: (NSXMLParser *) parser parseErrorOccurred:(NSError *)parseError{
    NSString *errorString = [NSString stringWithFormat:@"Error code %i",  [parseError code]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error Loading Content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



@end

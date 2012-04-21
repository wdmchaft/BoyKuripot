//
//  FeedEntryXmlParser.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlParser.h"
#import "FeedEntry.h"


@interface FeedEntryXmlParser : XmlParser{
    FeedEntry *currentEntry;
}


@property (nonatomic, retain) FeedEntry *currentEntry;

@end

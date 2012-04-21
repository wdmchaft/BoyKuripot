//
//  XmlParser.h
//  FeedReader
//
//  Created by Ana Katrina  Chong on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlParser : NSObject <NSXMLParserDelegate>{
    
    NSString *currentElement;
    
    NSMutableArray *entries;

}

@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableArray *entries;

-(void)parseXmlFileAtUrl:(NSString *)url;

@end

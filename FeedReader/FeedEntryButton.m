//
//  FeedEntryButton.m
//  Boy Kuripot
//
//  Created by Ana Katrina  Chong on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedEntryButton.h"

@implementation FeedEntryButton

-(id)init{
    id result = [super init];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setCornerRadius:10];
    [self setClipsToBounds:YES];
    return result;
}

@end

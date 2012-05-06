//
//  AdsService.h
//  Boy Kuripot
//
//  Created by Ana Katrina  Chong on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"

#define kAdmobId @"a14f96469195bce"

@interface AdsService : NSObject

+(GADBannerView *) getAdsBanner;

@end

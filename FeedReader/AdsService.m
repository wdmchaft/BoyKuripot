//
//  AdsService.m
//  Boy Kuripot
//
//  Created by Ana Katrina  Chong on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdsService.h"

@implementation AdsService

+(GADBannerView *)getAdsBanner{
    GADRequest *request = [GADRequest request];
    
    request.testing = YES;
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView.adUnitID = kAdmobId;
    [bannerView setCenter:CGPointMake(160, 394)];
    return bannerView;
}

@end

//
//  AboutViewController.h
//  Boy Kuripot
//
//  Created by Ana Katrina  Chong on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "ViewService.h"

@interface AboutViewController : UIViewController {
    UIView *aboutView;
}

@property (nonatomic, retain) IBOutlet UIView *aboutView;

-(IBAction)close:(id) sender;

@end

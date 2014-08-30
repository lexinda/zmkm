//
//  IntroductionTwoViewController.h
//  zmkm
//
//  Created by lele126 on 14-8-11.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

#import <CoreLocation/CoreLocation.h>

#import "MainViewController.h"

#import "LeadScroll.h"

@interface IntroductionTwoViewController : UIViewController<MBProgressHUDDelegate,CLLocationManagerDelegate,InputViewDelegate>

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)UIScrollView *mainScrollView;

@property(strong,nonatomic)LeadScroll *_leadView;

@end

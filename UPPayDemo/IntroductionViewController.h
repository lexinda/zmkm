//
//  IntroductionViewController.h
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MYIntroductionView.h"

#import "MainViewController.h"

#import "CoreAnimationEffect.h"

#import "UIDevice+Resolutions.h"

#import "MBProgressHUD.h"

#import "LeadScroll.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "User.h"

#import <CoreLocation/CoreLocation.h>

@interface IntroductionViewController : UIViewController<MYIntroductionDelegate,MBProgressHUDDelegate,CLLocationManagerDelegate,UIScrollViewDelegate,InputViewDelegate>

@property(strong,nonatomic)MainViewController *_mainViewController;

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)UIImageView *_introLeftView;

@property(strong,nonatomic)UIImageView *_introRightView;

@property(strong,nonatomic)UIImageView *_introBottomLeftView;

@property(strong,nonatomic)UIImageView *_introBottomRightView;

@property(strong,nonatomic)UIView *_introductionView;

@property(strong,nonatomic)UILabel *_topLabel;

@property(strong,nonatomic)UILabel *_centerLabel;

@property(strong,nonatomic)CLLocationManager *_cllocationManager;

@property(strong,nonatomic)UIScrollView *mainScrollView;

@property(strong,nonatomic)LeadScroll *_leadView;

@property(strong,nonatomic)NSMutableArray *_awardList;

@property(strong,nonatomic)NSMutableArray *_superAwardList;

@end

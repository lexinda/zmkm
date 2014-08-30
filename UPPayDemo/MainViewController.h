//
//  MainViewController.h
//  zmkm
//
//  Created by zhumengle on 14-4-28.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AwardView.h"

#import "QBluePageControl.h"

#import "NewAwardViewController.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "MBProgressHUD.h"

#import "Award.h"

#import "testview.h"

#import "UIDevice+Resolutions.h"

#import "reloadView.h"

#import "AwardContentViewController.h"

#import "IntroductionTwoViewController.h"

#import "NewSelfInfoViewController.h"

#import "User.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,reloadView,UIAlertViewDelegate>

@property(strong,nonatomic)UIScrollView *_mainScrollView;

@property(strong,nonatomic)QBluePageControl *_pageControl;

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)NSMutableArray *_awardList;

@property(strong,nonatomic)UIButton *_motionButton;

@property(strong,nonatomic)NSMutableArray *_superAwardList;

@property(strong,nonatomic)testview *testView;

@property(strong,nonatomic)testview *testView1;

@end

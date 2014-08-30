//
//  NewAwardViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-1.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AboutViewController.h"

#import "LoginViewController.h"

#import "MotionViewController.h"

#import "ASIHTTPRequest.h"

#import "MBProgressHUD.h"

#import "AwardViewController.h"

#import "SelfTableViewController.h"

@interface NewAwardViewController : UIViewController<ASIHTTPRequestDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)AboutViewController *_aboutController;

@property(strong,nonatomic)UIButton *_motionButton;

@property(strong,nonatomic)MBProgressHUD *_HUD;

@end

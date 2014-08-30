//
//  UPAppDelegate.h
//  UPPayDemo
//
//  Created by liwang on 12-11-16.
//  Copyright (c) 2012年 liwang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IntroductionViewController.h"

#import "MBProgressHUD.h"

#import "Reachability.h"

@class Reachability;

@interface UPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)IntroductionViewController *_introductionViewController;

@property(strong,nonatomic)UINavigationController *navigation;

@property(strong,nonatomic)Reachability *hostReach;

@end

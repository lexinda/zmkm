//
//  MotionViewController.h
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AwardViewController.h"

#import "MainViewController.h"

@interface MotionViewController : UIViewController<UIAlertViewDelegate>

@property(strong,nonatomic)UIImageView *_motionImageView;

@property(strong,nonatomic)NSString *type;

@end

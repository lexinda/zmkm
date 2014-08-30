//
//  ModifyUserInfoViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-19.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModifyUserInfoView.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "User.h"

#import "InputViewDelegate.h"

#import "SelfTableViewController.h"

@interface ModifyUserInfoViewController : UIViewController<InputViewDelegate>

@property(nonatomic)float _prewMoveY;

@property(nonatomic)int _preTag;

@property(strong,nonatomic)NSNumber *_userId;

@property(strong,nonatomic)ModifyUserInfoView *_modifyUserInfoView;

@property(strong,nonatomic)NSString *_userName;

@property(strong,nonatomic)NSString *_userGender;

@property(strong,nonatomic)NSString *_userPhone;

@property(strong,nonatomic)NSString *_userEmail;

@end

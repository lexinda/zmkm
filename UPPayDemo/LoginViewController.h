//
//  LoginViewController.h
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputView.h"

#import "InputViewDelegate.h"

#import "RegisterViewController.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "NewSelfInfoViewController.h"

#import "MotionViewController.h"

#import "User.h"

#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController : UIViewController<InputViewDelegate>

@property(nonatomic)float _prewMoveY;

@property(nonatomic)int _preTag;

@property(strong,nonatomic)InputView *_inputView;

@property(strong,nonatomic)NSString *_redirectView;

@end

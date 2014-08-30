//
//  RegisterViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RegisterView.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "NewSelfInfoViewController.h"

#import "MotionViewController.h"

#import <CommonCrypto/CommonDigest.h>

@interface RegisterViewController : UIViewController<InputViewDelegate>

@property(nonatomic)float _prewMoveY;

@property(nonatomic)int _preTag;

@property(strong,nonatomic)RegisterView *_registerView;

@property(strong,nonatomic)NSString *_redirectView;

@end

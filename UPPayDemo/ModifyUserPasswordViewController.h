//
//  ModifyUserPasswordViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-20.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PeoplePasswordCell.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import <CommonCrypto/CommonDigest.h>

@interface ModifyUserPasswordViewController : UIViewController<InputViewDelegate>

@property(strong,nonatomic)PeoplePasswordCell *_peoplePasswordCell;

@property(nonatomic)float _prewMoveY;

@property(nonatomic)int _preTag;

@property(strong,nonatomic)NSString *_userPassword;

@property(strong,nonatomic)NSString *_userPasswords;

@end

//
//  PeoplePasswordCell.h
//  zmkm
//
//  Created by zhumengle on 14-5-5.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputViewDelegate.h"

@interface PeoplePasswordCell : UIView<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *_oldPwdField;

@property(strong,nonatomic)UITextField *_oldPwdField1;

@property(strong,nonatomic)UITextField *_oldPwdField2;

@property(strong,nonatomic)id<InputViewDelegate> _inputViewDelegate;

@end

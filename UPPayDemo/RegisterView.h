//
//  RegisterView.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputViewDelegate.h"

@interface RegisterView : UIView<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong,nonatomic)UITextField *_userAccountFiled;

@property(strong,nonatomic)UITextField *_passwordFiled;

@property(strong,nonatomic)UITextField *_passwordAgainFiled;

@property(strong,nonatomic)UITextField *_userNameFiled;

@property(strong,nonatomic)UITextField *_saxFiled;

@property(strong,nonatomic)UITextField *_phoneFiled;

@property(strong,nonatomic)UITextField *_emailFiled;

@property(strong,nonatomic)id<InputViewDelegate> _inputViewDelegate;

@end

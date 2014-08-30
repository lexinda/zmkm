//
//  InputView.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputViewDelegate.h"

@interface InputView : UIView<UITextFieldDelegate>

@property(strong,nonatomic)UITextField *_userName;

@property(strong,nonatomic)UITextField *_password;

@property(strong,nonatomic)id<InputViewDelegate> _inputViewDelegate;
@end

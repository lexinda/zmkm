//
//  PeoplePasswordCell.m
//  zmkm
//
//  Created by zhumengle on 14-5-5.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "PeoplePasswordCell.h"

@implementation PeoplePasswordCell

@synthesize _oldPwdField;

@synthesize _oldPwdField1;

@synthesize _oldPwdField2;

@synthesize _inputViewDelegate;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
        // Initialization code
        
        UILabel *oldPwd = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 20.0, 100.0, 20.0)];
        
        [oldPwd setText:@"旧密码:"];
        
        _oldPwdField = [[UITextField alloc] initWithFrame:CGRectMake(105.0, oldPwd.frame.origin.y, 184, 22) ];
        
        [_oldPwdField setBorderStyle:UITextBorderStyleLine];
        
        _oldPwdField.placeholder = @"";
        
        _oldPwdField.secureTextEntry = YES;
        
        [_oldPwdField setTag:205];
        
        _oldPwdField.delegate = self;
        
        [_oldPwdField setBackground:[UIImage imageNamed:@"inputContent"]];
        
        _oldPwdField.returnKeyType = UIReturnKeyDone;
        
        [self addSubview:oldPwd];
        
        [self addSubview:_oldPwdField];
        
        UILabel *oldPwd1 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, oldPwd.frame.origin.y + oldPwd.frame.size.height+20, 100.0, 20.0)];
        
        [oldPwd1 setText:@"新密码:"];
        
        _oldPwdField1 = [[UITextField alloc] initWithFrame:CGRectMake(105.0, oldPwd1.frame.origin.y, 184, 22) ];
        
        [_oldPwdField1 setBorderStyle:UITextBorderStyleLine];
        
        _oldPwdField1.placeholder = @"";
        
        _oldPwdField1.secureTextEntry = YES;
        
        [_oldPwdField1 setTag:206];
        
        _oldPwdField1.delegate = self;
        
        [_oldPwdField1 setBackground:[UIImage imageNamed:@"inputContent"]];
        
        _oldPwdField1.returnKeyType = UIReturnKeyDone;
        
        [self addSubview:oldPwd1];
        
        [self addSubview:_oldPwdField1];
        
        UILabel *oldPwd2 = [[UILabel alloc] initWithFrame:CGRectMake(10.0, oldPwd1.frame.size.height+oldPwd1.frame.origin.y+20, 100.0, 20.0)];
        
        [oldPwd2 setText:@"重复密码:"];
        
        _oldPwdField2 = [[UITextField alloc] initWithFrame:CGRectMake(105.0, oldPwd2.frame.origin.y, 184, 22) ];
        
        [_oldPwdField2 setBorderStyle:UITextBorderStyleLine];
        
        _oldPwdField2.placeholder = @"";
        
        _oldPwdField2.secureTextEntry = YES;
        
        [_oldPwdField2 setTag:207];
        
        _oldPwdField2.delegate = self;
        
        [_oldPwdField2 setBackground:[UIImage imageNamed:@"inputContent"]];
        
        _oldPwdField2.returnKeyType = UIReturnKeyDone;
        
        [self addSubview:oldPwd2];
        
        [self addSubview:_oldPwdField2];
        
        UIButton *modifySubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [modifySubmit setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        
        [modifySubmit setFrame:CGRectMake((self.frame.size.width-115)/2, _oldPwdField2.frame.origin.y+_oldPwdField2.frame.size.height+20, 115.0, 33)];
        
        [modifySubmit addTarget:self action:@selector(modifySubmit) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:modifySubmit];
        
   
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [_inputViewDelegate upInputView:textField];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_inputViewDelegate downInputView:textField];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)modifySubmit{
    NSLog(@"modify");
    
    BOOL value = [self checkTel:_oldPwdField.text newPassword:_oldPwdField1.text newPasswordAgain:_oldPwdField2.text];
    
    if(value){
        
        [_inputViewDelegate userPasswordModify:_oldPwdField.text newUserPassword:_oldPwdField1.text];
        
    }
    
}

- (BOOL)checkTel:(NSString *)userPassword
          newPassword:(NSString *)newUserPassword
           newPasswordAgain:(NSString *)newUserPasswordAgain


{
    if ([userPassword length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"姓名不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    if ([newUserPassword length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"密码不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    if ([newUserPasswordAgain length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"确认密码不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }else{
        
        if([newUserPassword isEqualToString:newUserPasswordAgain]){
        }else{
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"确认密码和密码不一致", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
            return NO;
            
        }
        
    }
    
    return YES;
    
}

@end

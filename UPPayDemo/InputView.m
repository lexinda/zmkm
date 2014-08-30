//
//  InputView.m
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "InputView.h"

@implementation InputView

@synthesize _userName;

@synthesize _password;

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
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    _userName = [[UITextField alloc] initWithFrame:CGRectMake((self.frame.size.width-286)/2, 5.0, 286.0, 40.0)];
    
    [_userName setBorderStyle:UITextBorderStyleLine];
    
    _userName.placeholder = @"您的账户名";
    
    _userName.secureTextEntry = NO;
    
    [_userName setTag:200];
    
    _userName.delegate = self;
    
    [_userName setBackground:[UIImage imageNamed:@"input_bg"]];
    
    _userName.returnKeyType = UIReturnKeyDone;
    
    UIImage *people = [UIImage imageNamed:@"people2"];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 42.0, 30.0)];
    
    [view setImage:people];
    
    _userName.leftView = view;
    
    _userName.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:_userName];
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake((self.frame.size.width-286)/2, _userName.frame.origin.y+_userName.frame.size.height+5.0, 286.0, 40.0)];
    
    [_password setBorderStyle:UITextBorderStyleLine];
    
    _password.placeholder = @"密码";
    
    _password.secureTextEntry = YES;
    
    [_password setTag:201];
    
    _password.delegate = self;
    
    [_password setBackground:[UIImage imageNamed:@"input_bg"]];
    
    _password.returnKeyType = UIReturnKeyDone;
    
    UIImage *mima = [UIImage imageNamed:@"mima2"];
    
    UIImageView *mimaView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 42.0, 30.0)];
    
    [mimaView setImage:mima];
    
    _password.leftView = mimaView;
    
    _password.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:_password];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *key = [NSString stringWithFormat:@"is_remember"];
    
    NSString *value = [setting objectForKey:key];
    
    UIButton *remember = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [remember setFrame:CGRectMake(_password.frame.origin.x+2.0, _password.frame.size.height+_password.frame.origin.y+10.0, 82.0, 20.0)];
    
    if ([value isEqualToString:@"true"]) {
        [remember setBackgroundImage:[UIImage imageNamed:@"unremand1"] forState:UIControlStateNormal];
    }else{
        [remember setBackgroundImage:[UIImage imageNamed:@"remand1"] forState:UIControlStateNormal];
    }
    
    [remember setBackgroundImage:[UIImage imageNamed:@"remand1"] forState:UIControlStateHighlighted];
    
    [remember addTarget:self action:@selector(remember:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:remember];
    
    UILabel *reset = [[UILabel alloc] initWithFrame:CGRectMake(remember.frame.origin.x+remember.frame.size.width+20, remember.frame.origin.y, 86.0, 20.0)];
//    
//    [reset setFrame:CGRectMake(remember.frame.origin.x+remember.frame.size.width+20, remember.frame.origin.y, 76.0, 20.0)];
//    
//    [reset setBackgroundImage:[UIImage imageNamed:@"reset"] forState:UIControlStateNormal];
//    
//    [reset addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    
    [reset setText:@"还没有账号？"];
    
    [reset setTextAlignment:NSTextAlignmentRight];
    
    [reset setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    [self addSubview:reset];
    
    UIButton *reg = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [reg setFrame:CGRectMake(reset.frame.origin.x+reset.frame.size.width+5, remember.frame.origin.y, 76.0, 20.0)];
    
    [reg setTitle:@"免费注册>" forState:UIControlStateNormal];
    
    [reg setTitleColor:[UIColor colorWithRed:64.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [reg addTarget:self action:@selector(regView) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:reg];
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [submit setFrame:CGRectMake((self.frame.size.width-286.0)/2, remember.frame.origin.y+remember.frame.size.height+10.0, 286.0, 45.0)];
    
    [submit setBackgroundImage:[UIImage imageNamed:@"lg_bg1"] forState:UIControlStateNormal];
    
    [submit setTitleColor:[UIColor colorWithRed:64.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:submit];
    
    
}

-(void)regView{
    
    [_inputViewDelegate redirectRegView];
    
}

-(void)remember:(id)sender{
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *key = [NSString stringWithFormat:@"is_remember"];
    
    NSString *value = [setting objectForKey:key];
    
    UIButton *rememberButton = (UIButton *)sender;
    
    if ([value isEqualToString:@"true"]) {
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"remand1"] forState:UIControlStateNormal];
        
        [setting setObject:[NSString stringWithFormat:@"false"] forKey:key];
        
        [setting synchronize];
        
    }else{
        [rememberButton setBackgroundImage:[UIImage imageNamed:@"unremand1"] forState:UIControlStateNormal];
        
        [setting setObject:[NSString stringWithFormat:@"true"] forKey:key];
        
        [setting synchronize];
        
    }
    
    
    
}

-(void)reset{
    _userName.text = @"";
    _password.text = @"";
}

-(void)submit{
    
    NSLog(@"submit");
    
    NSString *userName = _userName.text;
    
    NSString *userPassword = _password.text;
    
    if (userName.length == 0) {
        
        UIAlertView* nameAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"用户名不能为空！", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [nameAlert show];
    }else if (userPassword.length==0){
        UIAlertView* nameAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"密码不能为空！", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [nameAlert show];
    }else{
        [_inputViewDelegate userLogin:userName userPassword:userPassword];
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{

    [_userName setBackground:[UIImage imageNamed:@"input_bg"]];
    
    [_password setBackground:[UIImage imageNamed:@"input_bg"]];
    
    if (textField.tag == 200) {
        [_userName setBackground:[UIImage imageNamed:@"input_bg"]];
    }else if(textField.tag == 201){
        [_password setBackground:[UIImage imageNamed:@"input_bg"]];
    }
    
    [_inputViewDelegate upInputView:textField];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [_userName setBackground:[UIImage imageNamed:@"input_bg"]];
    
    [_password setBackground:[UIImage imageNamed:@"input_bg"]];
    
    [_inputViewDelegate downInputView:textField];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end

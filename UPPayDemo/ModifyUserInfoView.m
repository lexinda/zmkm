//
//  ModifyUserInfoView.m
//  zmkm
//
//  Created by zhumengle on 14-5-19.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "ModifyUserInfoView.h"

@implementation ModifyUserInfoView

@synthesize _userNameFiled;

@synthesize _saxFiled;

@synthesize _phoneFiled;

@synthesize _emailFiled;

@synthesize _inputViewDelegate;

@synthesize _userId;

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
    
    UIImage *userName = [UIImage imageNamed:@"userName"];
    
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 49.0, 19.0)];
    
    [userNameLabel setBackgroundColor:[UIColor colorWithPatternImage:userName]];
    
    [self addSubview:userNameLabel];
    
    _userNameFiled = [[UITextField alloc] initWithFrame:CGRectMake(77.0, userNameLabel.frame.origin.y-2, 184, 22) ];
    
    [_userNameFiled setBorderStyle:UITextBorderStyleLine];
    
    _userNameFiled.placeholder = @"";
    
    _userNameFiled.secureTextEntry = NO;
    
    [_userNameFiled setTag:203];
    
    _userNameFiled.delegate = self;
    
    [_userNameFiled setBackground:[UIImage imageNamed:@"inputContent"]];
    
    _userNameFiled.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:_userNameFiled];
    
    UIImage *sax = [UIImage imageNamed:@"sax"];
    
    UILabel *saxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _userNameFiled.frame.size.height+_userNameFiled.frame.origin.y+5+2, 49.0, 18.0)];
    
    [saxLabel setBackgroundColor:[UIColor colorWithPatternImage:sax]];
    
    [self addSubview:saxLabel];
    
    _saxFiled = [[UITextField alloc] initWithFrame:CGRectMake(77.0, saxLabel.frame.origin.y-2, 184, 22) ];
    
    [_saxFiled setBorderStyle:UITextBorderStyleLine];
    
    _saxFiled.placeholder = @"";
    
    _saxFiled.secureTextEntry = NO;
    
    [_saxFiled setTag:204];
    
    _saxFiled.delegate = self;
    
    [_saxFiled setBackground:[UIImage imageNamed:@"inputContent"]];
    
    _saxFiled.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:_saxFiled];
    
    UIImage *phone = [UIImage imageNamed:@"phone"];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _saxFiled.frame.size.height+_saxFiled.frame.origin.y+5, 46.0, 22.0)];
    
    [phoneLabel setBackgroundColor:[UIColor colorWithPatternImage:phone]];
    
    [self addSubview:phoneLabel];
    
    _phoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(77.0, phoneLabel.frame.origin.y, 184, 22) ];
    
    [_phoneFiled setBorderStyle:UITextBorderStyleLine];
    
    _phoneFiled.placeholder = @"";
    
    _phoneFiled.secureTextEntry = NO;
    
    [_phoneFiled setTag:205];
    
    _phoneFiled.delegate = self;
    
    [_phoneFiled setBackground:[UIImage imageNamed:@"inputContent"]];
    
    _phoneFiled.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:_phoneFiled];
    
    UIImage *email = [UIImage imageNamed:@"email"];
    
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _phoneFiled.frame.size.height+_phoneFiled.frame.origin.y+5, 46.0, 22.0)];
    
    [emailLabel setBackgroundColor:[UIColor colorWithPatternImage:email]];
    
    [self addSubview:emailLabel];
    
    _emailFiled = [[UITextField alloc] initWithFrame:CGRectMake(77.0, emailLabel.frame.origin.y, 184, 22) ];
    
    [_emailFiled setBorderStyle:UITextBorderStyleLine];
    
    _emailFiled.placeholder = @"";
    
    _emailFiled.secureTextEntry = NO;
    
    [_emailFiled setTag:206];
    
    _emailFiled.delegate = self;
    
    [_emailFiled setBackground:[UIImage imageNamed:@"inputContent"]];
    
    _emailFiled.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:_emailFiled];
    
    UIButton *registerSubmit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [registerSubmit setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
    
    [registerSubmit setFrame:CGRectMake((self.frame.size.width-115)/2, _emailFiled.frame.origin.y+_emailFiled.frame.size.height+10, 115.0, 33)];
    
    [registerSubmit addTarget:self action:@selector(registerSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:registerSubmit];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 204) {
        UIPickerView *_pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 216.0)];
        
        
        _pickerView.delegate = self;
        
        _pickerView.dataSource = self;
        
        _pickerView.showsSelectionIndicator = YES;
        
        textField.inputView = _pickerView;
        
        UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
        
        keyboardDoneButtonView.barStyle = UIBarStyleDefault;
        
        keyboardDoneButtonView.translucent = YES;
        
        keyboardDoneButtonView.tintColor = nil;
        
        [keyboardDoneButtonView sizeToFit];
        
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                       
                                                                       style:UIBarButtonItemStyleBordered target:self
                                       
                                                                      action:@selector(pickerDoneClicked:)];
        
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        
        textField.inputAccessoryView = keyboardDoneButtonView;
        
    }else{
        
        
    }
    
    
    
    return YES;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 3;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(row == 0){
        return @"请选择";
    }else if (row == 1) {
        return @"男";
    }else if(row == 2){
        return @"女";
    }
    return NULL;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    for (UIView *view in self.subviews) {
        NSLog(@"view.tag %d",view.tag);
        
        if(view.tag == 204){
            
            UITextField *textField = (UITextField *)view;
            
            if (row == 0) {
                textField.text = @"";
            }else if (row == 1) {
                textField.text = @"男";
            }else if (row == 2){
                textField.text = @"女";
            }
            
            
        }
    }
    
}

-(void)pickerDoneClicked:(id)sender{
    
    for (UIView *view in self.subviews) {
        NSLog(@"view.tag %d",view.tag);
        
        if(view.tag == 204){
            
            UITextField *textField = (UITextField *)view;
            
            [self textFieldShouldReturn:textField];
            
        }
    }
    
    NSLog(@"ok");
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for (UIView *view in self.subviews) {
        NSLog(@"view.tag %d",view.tag);
        
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField *)view resignFirstResponder];
        }
    }
    
    
    
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

-(void)registerSubmit{
    NSLog(@"submit");
    
    BOOL value = [self checkTel:_userNameFiled.text gender:_saxFiled.text phone:_phoneFiled.text email:_emailFiled.text];
    
    if(value){
        
        [_inputViewDelegate userModify:_userId userName:_userNameFiled.text gender:_saxFiled.text phone:_phoneFiled.text email:_emailFiled.text];
        
    }
    
}

- (BOOL)checkTel:(NSString *)userName
          gender:(NSString *)gender
           phone:(NSString *)userPhone
           email:(NSString *)email


{
    if ([userName length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"姓名不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    if ([gender length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"性别不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }
    
    if ([userPhone length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"手机号码不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }else{
        
        //1[0-9]{10}
        
        //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
        
        //    NSString *regex = @"[0-9]{11}";
        
        NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        //    NSLog(@"phoneTest is %@",phoneTest);
        BOOL isMatch = [phoneTest evaluateWithObject:userPhone];
        
        if (!isMatch) {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
            return NO;
            
        }
        
    }
    
    if ([email length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"邮箱不能为空", nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
        return NO;
        
    }else{
        
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        
        BOOL isMatch = [emailTest evaluateWithObject:email];
        
        if (!isMatch) {
            
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的邮箱" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            
            return NO;
            
        }
        
        
    }
    
    return YES;
    
}


@end

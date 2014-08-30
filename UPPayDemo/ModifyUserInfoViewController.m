//
//  ModifyUserInfoViewController.m
//  zmkm
//
//  Created by zhumengle on 14-5-19.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "ModifyUserInfoViewController.h"

@interface ModifyUserInfoViewController ()

@end

@implementation ModifyUserInfoViewController

@synthesize _modifyUserInfoView;

@synthesize _preTag;

@synthesize _prewMoveY;

@synthesize _userName;

@synthesize _userGender;

@synthesize _userEmail;

@synthesize _userPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title=@"修改个人资料";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 34.0)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
    return self;
}

-(void)loadView{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *mainView = [[UIView alloc] initWithFrame:rect];
    
    [mainView setBackgroundColor:[UIColor whiteColor]];
    
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _modifyUserInfoView = [[ModifyUserInfoView alloc] initWithFrame:CGRectMake(20.0, 20.0, self.view.frame.size.width-20.0, self.view.frame.size.height)];
    
    _modifyUserInfoView._inputViewDelegate = self;
    
    [_modifyUserInfoView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:_modifyUserInfoView];
    
    // Do any additional setup after loading the view.
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)upInputView:(UITextField *)textField{
    NSLog(@"shangyi-------------");
    
    CGRect textFrame = textField.frame;
    
    float textY = textFrame.origin.y+textFrame.size.height+_modifyUserInfoView.frame.origin.y;
    
    float bottomY = self.view.frame.size.height-textY;
    
    if (bottomY >= 216) {
        _preTag = -1;
        
        return;
    }
    
    _preTag = textField.tag;
    
    float moveY = 216 - bottomY;
    
    _prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.30f;
    
    CGRect frame = self.view.frame;
    
    frame.origin.y -= moveY;
    
    frame.size.height += moveY;
    
    self.view.frame = frame;
    
    [UIView beginAnimations:@"resizeView" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
}

-(void)downInputView:(UITextField *)textField{
    NSLog(@"huanyuan-------------");
    
    
    
    if(_preTag == -1) //当编辑的View不是需要移动的View
    {
        return;
    }
    float moveY ;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(_preTag == textField.tag) //当结束编辑的View的TAG是上次的就移动
    {   //还原界面
        moveY =  _prewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    //self.view移回原位置
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
}

-(void)userModify:(NSNumber *)userId userName:(NSString *)userName gender:(NSString *)gender phone:(NSString *)userPhone email:(NSString *)email{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    int genderValue = 0;
    
    if([gender isEqualToString:@"男"]){
        genderValue=0;
    }else if([gender isEqualToString:@"女"]){
        genderValue=1;
    }
    
    _userName = userName;
    
    _userGender = gender;
    
    _userPhone = userPhone;
    
    _userEmail = email;
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userKey = [NSString stringWithFormat:@"id"];
    
    NSNumber *id = [setting objectForKey:userKey];
    
    NSString *registerUrl = [NSString stringWithFormat:@"%@user/userModify?userId=%d&userName=%@&userGender=%d&userPhone=%@&userEmail=%@",domainName,[id intValue],userName,genderValue,userPhone,email];
    
    NSLog(@"%@",registerUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:registerUrl]];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if([codeData intValue] == 0){
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *userName = [NSString stringWithFormat:@"userName"];
        
        [setting setObject:_userName forKey:userName];
        
        NSString *userGender = [NSString stringWithFormat:@"userGender"];
        
        [setting setObject:_userGender forKey:userGender];
        
        NSString *userPhone = [NSString stringWithFormat:@"userPhone"];
        
        [setting setObject:_userPhone forKey:userPhone];
        
        NSString *userEmail = [NSString stringWithFormat:@"userEmail"];
        
        [setting setObject:_userEmail forKey:userEmail];
        
        [setting synchronize];        
        
        [self goBack];
        
    }else{
        
        UIAlertView *errorAlert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败，请检查网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        
        [errorAlert show];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

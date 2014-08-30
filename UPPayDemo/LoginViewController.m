//
//  LoginViewController.m
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize _prewMoveY;

@synthesize _inputView;

@synthesize _preTag;

@synthesize _redirectView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title=@"登陆";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
        
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
    
    [mainView setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:230.0/255.0 blue:224.0/255.0 alpha:1.0]];
    
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *topBg = [UIImage imageNamed:@"loginTop"];
    
    UIImageView *topBgView = [[UIImageView alloc] init];
    
    [topBgView setFrame:CGRectMake(0.0, 0.0, 320, 170)];
    
    [topBgView setImage:topBg];
    
    [self.view addSubview:topBgView];
    
    UIImage *topBg1 = [UIImage imageNamed:@"topBg1"];
    
    UIImageView *topBgView1 = [[UIImageView alloc] init];
    
    [topBgView1 setFrame:CGRectMake(10.0, 50.0, 186, 66)];
    
    [topBgView1 setImage:topBg1];
    
    //[topBgView addSubview:topBgView1];
    
    UIImage *topBg2 = [UIImage imageNamed:@"topBg2"];
    
    UIImageView *topBgView2 = [[UIImageView alloc] init];
    
    [topBgView2 setFrame:CGRectMake(10.0, topBgView1.frame.size.height+topBgView1.frame.origin.y, 186, 31)];
    
    [topBgView2 setImage:topBg2];
    
    //[topBgView addSubview:topBgView2];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, topBgView.frame.size.height+5.0, 288, 35)];
    
    [loginLabel setText:@"账号登录"];
    
    [loginLabel setFont:[UIFont fontWithName:@"Helvetica" size:20.0]];
    
    [loginLabel setTextColor:[UIColor colorWithRed:64.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0]];
    
    [self.view addSubview:loginLabel];
    
    _inputView = [[InputView alloc] initWithFrame:CGRectMake(0.0, loginLabel.frame.origin.y+loginLabel.frame.size.height+2.0, self.view.frame.size.width, 138+45)];
    
    _inputView._inputViewDelegate = self;
    
    [_inputView setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:_inputView];
    
//    UIImage *registerImage = [UIImage imageNamed:@"register"];
//    
//    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [registerButton setFrame:CGRectMake((self.view.frame.size.width-288)/2,_inputView.frame.origin.y+_inputView.frame.size.height, 288.0, 45)];
//    
//    [registerButton setBackgroundImage:registerImage forState:UIControlStateNormal];
//    
//    [registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.view addSubview:registerButton];
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)redirectRegView{
    
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    
    [registerViewController set_redirectView:_redirectView];
    
    [self.navigationController pushViewController:registerViewController animated:YES];
    
}

-(void)upInputView:(UITextField *)textField{
    NSLog(@"shangyi-------------");
    
    CGRect textFrame = textField.frame;
    
    float textY = textFrame.origin.y+textFrame.size.height+_inputView.frame.origin.y+25;
    
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

-(void)userLogin:(NSString *)userName userPassword:(NSString *)userPassword{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *md5Password = [self getMd5_32Bit_String:userPassword];
    
    NSString *userNameValue = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    
    NSString *userNameNew = [userNameValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"userNameValue%@",userNameValue);
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@user/login?userAccount=%@&userPassword=%@",domainName,userNameNew,md5Password];
    
    NSLog(@"%@",loginUrl);
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userAccountkey = [NSString stringWithFormat:@"userAccount"];
    
    [setting setObject:[NSString stringWithFormat:@"%@",userNameNew] forKey:userAccountkey];
    
    NSString *userPasswordkey = [NSString stringWithFormat:@"userPassword"];
    
    [setting setObject:[NSString stringWithFormat:@"%@",md5Password] forKey:userPasswordkey];
    
    [setting synchronize];
    
//    UIAlertView *loginInfo = [[UIAlertView alloc] initWithTitle:NSLocalizedString(userName, nil) message:NSLocalizedString(userPassword, nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    
//    [loginInfo show];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:loginUrl]];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

-(void)requestFinished:(ASIHTTPRequest *)request{

    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if ([codeData intValue] == 0) {
        
        NSDictionary *bodyDatas = [datas objectForKey:@"body"];
        
        NSDictionary *userInfo = [bodyDatas objectForKey:@"userInfo"];
        
        User *user = [[User alloc] init];
        
        [user setId:[userInfo objectForKey:@"id"]];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *userIdKey = [NSString stringWithFormat:@"userId"];
        
        [setting setObject:[userInfo objectForKey:@"id"] forKey:userIdKey];
        
        [user setUserAccount:[userInfo objectForKey:@"userAccount"]];
        
        NSString *userAccountKey = [NSString stringWithFormat:@"userAccount"];
        
        [setting setObject:[userInfo objectForKey:@"userAccount"] forKey:userAccountKey];
        
        [user setUserPassword:[userInfo objectForKey:@"userPassword"]];
        
        NSString *userPasswordKey = [NSString stringWithFormat:@"userPassword"];
        
        NSString *md5Password = [userInfo objectForKey:@"userPassword"];
        
        [setting setObject: md5Password forKey:userPasswordKey];
        
        NSString *userAmount = [userInfo objectForKey:@"userAmount"];
        
        NSString *userAmountKey = [NSString stringWithFormat:@"userAmount"];
        
        [setting setObject: userAmount forKey:userAmountKey];
        
        [setting synchronize];
        
        [user setUserName:[userInfo objectForKey:@"userName"]];
        
        [user setUserGender:[userInfo objectForKey:@"userGender"]];
        
        [user setUserPhone:[userInfo objectForKey:@"userPhone"]];
        
        [user setUserEmail:[userInfo objectForKey:@"userEmail"]];
        
        [user setCreateTime:[userInfo objectForKey:@"createTime"]];
        
        [user setUpdateTime:[userInfo objectForKey:@"updateTime"]];
        
        /*查看用户账户金额，
         */

        if ([_redirectView isEqualToString:@"self"]) {
//            SelfTableViewController *selfTableViewController = [[SelfTableViewController alloc] initWithStyle:UITableViewStylePlain];
            
            NewSelfInfoViewController *selfTableViewController = [[NewSelfInfoViewController alloc] init];
            
            [self.navigationController pushViewController:selfTableViewController animated:YES];

        }else if([_redirectView isEqualToString:@"motion"]){
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MotionViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
            
        }        
         
    }else if([codeData intValue]== -1){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [errorAlertView show];
    }
    
    NSLog(@"responseString:%@",responseString);

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

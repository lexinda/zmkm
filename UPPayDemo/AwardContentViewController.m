//
//  AwardContentViewController.m
//  zmkm
//
//  Created by zhumengle on 14-6-14.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "AwardContentViewController.h"

@interface AwardContentViewController ()

@end

@implementation AwardContentViewController

@synthesize _awardList;

@synthesize _HUD;

@synthesize award;

@synthesize _motionButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"产品介绍";
        
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
    
    [mainView setBackgroundColor:[UIColor whiteColor]];
    
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    
//    [self.view addSubview:_HUD];
//    
//    //如果设置此属性则当前的view置于后台
//    _HUD.dimBackground = YES;
//    
//    //设置对话框文字
//    _HUD.labelText = @"加载中...";
//    
//    //显示对话框
//    [_HUD showAnimated:YES whileExecutingBlock:^{
//        //对话框显示时需要执行的操作
//        sleep(1);
//    } completionBlock:^{
//        //操作执行完后取消对话框
//        [_HUD removeFromSuperview];
//        _HUD = nil;
//    }];
    
    UIImageView *awardImageView = [[UIImageView alloc] init];
    
    CGRect imageRect;
    
    if ([UIDevice isRunningOniPhone5]) {
        imageRect =CGRectMake(0.0, 0.0, self.view.frame.size.width, 260);
    }else{
        
        imageRect =CGRectMake(0.0, 0.0, self.view.frame.size.width, 160);
    }
    
    [awardImageView setFrame:imageRect];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *awardImageUrl = [NSString stringWithFormat:@"%@%@",domainName,[self.award awardImage]];
    
    [awardImageView setImageWithURL:[NSURL URLWithString:awardImageUrl]
                   placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"awardImage.png"]]];
    
    [self.view addSubview:awardImageView];
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, awardImageView.frame.size.height+20, self.view.frame.size.width-20, 20)];
    
    NSString *oneStr = [NSString stringWithFormat:@"奖品名称:%@",[self.award awardName]];
    
    //[oneLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:196.0/255.0 blue:6.0/255.0 alpha:1.0]];
    
    [oneLabel setText:oneStr];
    
    [self.view addSubview:oneLabel];
    
    UILabel *twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, oneLabel.frame.origin.y+oneLabel.frame.size.height, self.view.frame.size.width-20, 30)];
    
    [twoLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    
    NSString *twostr = [NSString stringWithFormat:@"提供方:%@",[self.award awardProvide]];
    
    [twoLabel setNumberOfLines:0];
    
    twoLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    [twoLabel setText:twostr];
    
    [self.view addSubview:twoLabel];
    
    myUILabel *threeLabel = [[myUILabel alloc] initWithFrame:CGRectMake(10.0, twoLabel.frame.size.height+twoLabel.frame.origin.y, self.view.frame.size.width-20, 50)];
    
    NSString *threestr = [NSString stringWithFormat:@"奖品简介:%@",[self.award awardContent]];
    
    [threeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    
    [threeLabel setNumberOfLines:0];
    
    [threeLabel setTextAlignment:NSTextAlignmentLeft];
    
    threeLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    [threeLabel setVerticalAlignment:VerticalAlignmentTop];
    
    [threeLabel setText:threestr];
    
    [self.view addSubview:threeLabel];
    
    // Do any additional setup after loading the view.
    
//    UIButton *changeView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    
//    [changeView setFrame:CGRectMake((self.view.frame.size.width-176)/2, self.view.frame.size.height-64-35-25, 176, 18)];
//    
//    [changeView setBackgroundImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
//    
//    [changeView setBackgroundImage:[UIImage imageNamed:@"change_1"] forState:UIControlStateSelected];
//    
//    [changeView addTarget:self action:@selector(loginOrRegister) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:changeView];
    
    UIButton *shareView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [shareView setFrame:CGRectMake(10.0, self.view.frame.size.height-54-54-74-5, self.view.frame.size.width-20.0, 54)];
    
    [shareView setBackgroundImage:[UIImage imageNamed:@"awardShared"] forState:UIControlStateNormal];
    
    
    [shareView addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareView];
    
    _motionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    CGRect motionRect = CGRectMake(10.0, self.view.frame.size.height-54-74, self.view.frame.size.width-20.0, 54);
    
    _motionButton.frame=motionRect;
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"awardNew1"] forState:UIControlStateNormal];
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"motionCheck"] forState:UIControlStateSelected];
    
    [_motionButton addTarget:self action:@selector(pushMotionView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_motionButton];
    
    // Do any additional setup after loading the view.
}

-(void)pushMotionView{
    
    MotionViewController *motionViewControl = [[MotionViewController alloc] init];
    
    [motionViewControl setType:@"home"];
    
    [self.navigationController pushViewController:motionViewControl animated:YES];
    
    //    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    //
    //    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    //
    //    NSString *domainName=[data objectForKey:@"domainName"];
    //
    //    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    //
    //    NSString *userKey = [NSString stringWithFormat:@"id"];
    //
    //    NSNumber *id = [setting objectForKey:userKey];
    //
    //    NSString *registerUrl = [NSString stringWithFormat:@"%@award/getMotionAward?userId=%d",domainName,[id intValue]];
    //
    //    NSLog(@"%@",registerUrl);
    //
    //    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:registerUrl]];
    //
    //    [request setDelegate:self];
    //
    //    request.tag = 100;
    //    
    //    [request startSynchronous];
    
}


-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
    
    NSLog(@"responseString:%@",error);
    
	_HUD.labelText = @"网络连接失败！";
    
    [_HUD show:YES];
    
    
}

-(void)loginOrRegister{
    
    _HUD.labelText = @"加载中...！";
    
    [_HUD show:YES];
    
    NSLog(@"loginOrRegister");
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userAccountKey = [NSString stringWithFormat:@"userAccount"];
    
    NSString *userAccountvalue = [setting objectForKey:userAccountKey];
    
    NSString *userPasswordKey = [NSString stringWithFormat:@"userPassword"];
    
    NSString *userPasswordvalue = [setting objectForKey:userPasswordKey];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@user/login?userAccount=%@&userPassword=%@",domainName,userAccountvalue,userPasswordvalue];
    
    //    UIAlertView *loginInfo = [[UIAlertView alloc] initWithTitle:NSLocalizedString(userName, nil) message:NSLocalizedString(userPassword, nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //
    //    [loginInfo show];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:loginUrl]];
    
    [request setDelegate:self];
    
    request.tag = 200;
    
    [request startSynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if(request.tag == 2000){
        
        if ([codeData intValue] == 0) {
            
            //        NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            //
            //        NSDictionary *userInfo = [bodyDatas objectForKey:@"userInfo"];
            //
            //        User *user = [[User alloc] init];
            //
            //        [user setId:[userInfo objectForKey:@"id"]];
            //
            //        [user setUserAccount:[userInfo objectForKey:@"userAccount"]];
            //
            //        [user setUserPassword:[userInfo objectForKey:@"userPassword"]];
            //
            //        [user setUserName:[userInfo objectForKey:@"userName"]];
            //
            //        [user setUserGender:[userInfo objectForKey:@"userGender"]];
            //
            //        [user setUserPhone:[userInfo objectForKey:@"userPhone"]];
            //
            //        [user setUserEmail:[userInfo objectForKey:@"userEmail"]];
            //
            //        [user setCreateTime:[userInfo objectForKey:@"createTime"]];
            //
            //        [user setUpdateTime:[userInfo objectForKey:@"updateTime"]];
            //
            //        [self goBack];
            
            NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            
            NSString *userInfo = [bodyDatas objectForKey:@"resultAmount"];
            
            if([userInfo floatValue]/0.2 >0){
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[MotionViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                
            }else{
                
                UPViewController *upViewController = [[UPViewController alloc] init];
                
                [self.navigationController pushViewController:upViewController animated:YES];
                
            }
        }else{
            
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            
            [loginViewController set_redirectView:@"motion"];
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            
        }
        
        
    }else if(request.tag == 2200){
        
        
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyData = [datas objectForKey:@"body"];
            
            NSString *appAddress = [bodyData objectForKey:@"appAddress"];
            
            self.appAddress=appAddress;
        }
        
    }else{
        
        if ([codeData intValue] == 0) {
            
            //        NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            //
            //        NSDictionary *userInfo = [bodyDatas objectForKey:@"userInfo"];
            //
            //        User *user = [[User alloc] init];
            //
            //        [user setId:[userInfo objectForKey:@"id"]];
            //
            //        [user setUserAccount:[userInfo objectForKey:@"userAccount"]];
            //
            //        [user setUserPassword:[userInfo objectForKey:@"userPassword"]];
            //
            //        [user setUserName:[userInfo objectForKey:@"userName"]];
            //
            //        [user setUserGender:[userInfo objectForKey:@"userGender"]];
            //
            //        [user setUserPhone:[userInfo objectForKey:@"userPhone"]];
            //
            //        [user setUserEmail:[userInfo objectForKey:@"userEmail"]];
            //
            //        [user setCreateTime:[userInfo objectForKey:@"createTime"]];
            //
            //        [user setUpdateTime:[userInfo objectForKey:@"updateTime"]];
            //
            //        [self goBack];
            
            NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            
            NSDictionary *userInfo = [bodyDatas objectForKey:@"userInfo"];
            
            User *user = [[User alloc] init];
            
            [user setId:[userInfo objectForKey:@"id"]];
            
            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            
            NSString *userIdKey = [NSString stringWithFormat:@"userId"];
            
            [setting setObject:[userInfo objectForKey:@"id"] forKey:userIdKey];
            
            NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
            
            NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
            
            NSString *domainName=[data objectForKey:@"domainName"];
            
            NSString *amountUrl = [NSString stringWithFormat:@"%@user/getUserAmount?userId=%d",domainName,[user.id intValue]];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:amountUrl]];
            
            request.tag=2000;
            
            [request setDelegate:self];
            
            [request startSynchronous];
            
        }else{
            
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            
            [loginViewController set_redirectView:@"motion"];
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            
        }
        
        
    }
    
}


-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)share{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *queryAppAddressById = [NSString stringWithFormat:@"%@award/queryAppAddressById",domainName];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:queryAppAddressById]];
    
    request.tag=2200;
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
//    NSString *phone = @"1001011";
    
    //[ZCAddressBook sendMessage:phone];
//    [[ZCAddressBook alloc]initWithTarget:self MessageNameArray:@[@"18627089237"] Message:@"发送消息的内容" Block:^(int type) {
//        NSLog(@"发送短信后的状态");
//    }];
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init]; //autorelease];
//        controller.recipients = [NSArray arrayWithObject:phone];
        controller.body = self.appAddress;
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:^(void) {
            NSLog(@"进入发短信界面");
        }];
        //        [[[[controller viewControllers] lastObject] navigationItem] setTitle:@"SomethingElse"];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:NO];//关键的一句   不能为YES
    switch ( result ) {
        case MessageComposeResultCancelled:
        {
            //click cancel button
        }
            break;
        case MessageComposeResultFailed:// send failed
            
            break;
        case MessageComposeResultSent:
        {
            
            //do something
        }
            break;
        default:
            break;
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

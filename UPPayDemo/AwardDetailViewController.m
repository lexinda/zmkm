//
//  AwardDetailViewController.m
//  zmkm
//
//  Created by lele126 on 14-7-8.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import "AwardDetailViewController.h"

@interface AwardDetailViewController ()

@end

@implementation AwardDetailViewController

@synthesize _awardList;

@synthesize awardImageView;

@synthesize _HUD;

@synthesize award;

@synthesize shopLabel;

@synthesize twoLabel;

@synthesize threeLabel;

@synthesize fourLabel;

@synthesize fiveLabel;

@synthesize sixLabel;

@synthesize index;

@synthesize appAddress;

@synthesize viewDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"领奖啦";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [rightButton setFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
        
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:15.0];
        
        rightButton.titleLabel.font = font;
        
        [rightButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
        [rightButton setTitle:@"删除" forState:UIControlStateNormal];
        
        [rightButton setTintColor:[UIColor whiteColor]];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        [self.navigationItem setRightBarButtonItem:rightItem];
        
    }
    return self;
}

-(void)loadView{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *mainView = [[UIView alloc] initWithFrame:rect];
    
    [mainView setBackgroundColor:[UIColor whiteColor]];
    
    self.view = mainView;
}

-(void)logout{
    
    NSLog(@"删除");
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    //
    NSString *userIdKey = [NSString stringWithFormat:@"userId"];
    //
    NSString *userId = [setting objectForKey:userIdKey];
    
    NSString *awardId = [NSString stringWithFormat:@"%i",[award.id intValue]];
    
    NSString *deleteUrl = [NSString stringWithFormat:@"%@user/deleteAward?userId=%@&awardId=%@",domainName,userId,awardId];
    
    NSLog(@"%@",deleteUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:deleteUrl]];
    
    request.tag=3000;
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_HUD];
    
    //如果设置此属性则当前的view置于后台
    _HUD.dimBackground = YES;
    
    //设置对话框文字
    _HUD.labelText = @"加载中...";
    
    //显示对话框
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(1);
    } completionBlock:^{
        //操作执行完后取消对话框
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
    
    self.awardImageView = [[UIImageView alloc] init];
    
    CGRect imageRect;
    
    if ([UIDevice isRunningOniPhone5]) {
        imageRect =CGRectMake(0.0, 0.0, self.view.frame.size.width, 250);
    }else{
        
        imageRect =CGRectMake(0.0, 0.0, self.view.frame.size.width, 150);
    }
    
    [self.awardImageView setFrame:imageRect];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *awardImageUrl = [NSString stringWithFormat:@"%@%@",domainName,[self.award awardImage]];
    
    [self.awardImageView setImageWithURL:[NSURL URLWithString:awardImageUrl]
                        placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"awardImage.png"]]];
    
    [self.view addSubview:self.awardImageView];
    
    UILabel *oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, awardImageView.frame.size.height, 200, 20)];
    
    NSString *oneStr = [NSString stringWithFormat:@"抵用现金附送物品"];
    
    [oneLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:196.0/255.0 blue:6.0/255.0 alpha:1.0]];
    
    [oneLabel setFont:[UIFont fontWithName:@"Helvetica" size:19.0]];
    
    [oneLabel setText:oneStr];
    
    [self.view addSubview:oneLabel];
    
    self.shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, oneLabel.frame.origin.y+oneLabel.frame.size.height, self.view.frame.size.width, 30)];
    
    [self.shopLabel setTextColor:[UIColor colorWithRed:55.0/255.0 green:196.0/255.0 blue:6.0/255.0 alpha:1.0]];
    
    [self.shopLabel setText:[NSString stringWithFormat:@"本奖品由%@提供",[self.award awardProvide]]];
    
    [self.view addSubview:self.shopLabel];
    
    self.twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.shopLabel.frame.origin.y+self.shopLabel.frame.size.height, self.view.frame.size.width, 40)];
    
    [self.twoLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSString *twostr = [NSString stringWithFormat:@"奖励说明:%@",[self.award awardInfo]];
    
    [self.twoLabel setNumberOfLines:0];
    
    self.twoLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    [self.twoLabel setText:twostr];
    
    [self.view addSubview:self.twoLabel];
    
    self.threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.twoLabel.frame.size.height+self.twoLabel.frame.origin.y, self.view.frame.size.width, 25)];
    
    NSString *threestr = [NSString stringWithFormat:@"奖品编号:%@",[self.award awardNumber]];
    
    [self.threeLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    [self.threeLabel setText:threestr];
    
    [self.view addSubview:self.threeLabel];
    
    self.fourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.threeLabel.frame.size.height+self.threeLabel.frame.origin.y, self.view.frame.size.width, 25)];
    
    [self.fourLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSString *fourstr = [NSString stringWithFormat:@"地址:%@",[self.award awardAddress]];
    
    [self.fourLabel setText:fourstr];
    
    [self.view addSubview:self.fourLabel];
    
    self.fiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.fourLabel.frame.size.height+self.fourLabel.frame.origin.y, self.view.frame.size.width, 25)];
    
    [self.fiveLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSString *fivestr = [NSString stringWithFormat:@"联系电话:%@",[self.award awardPhone]];
    
    [self.fiveLabel setText:fivestr];
    
    [self.view addSubview:self.fiveLabel];
    
    self.sixLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.fiveLabel.frame.size.height+self.fiveLabel.frame.origin.y, self.view.frame.size.width, 25)];
    
    [self.sixLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSString *sixStr = [NSString stringWithFormat:@"有效期限:%@-%@",[self.award awardStart],[self.award awardEnd]];
    
    [self.sixLabel setText:sixStr];
    
    [self.view addSubview:self.sixLabel];
    
    self.sivenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, self.sixLabel.frame.size.height+self.sixLabel.frame.origin.y, self.view.frame.size.width, 25)];
    
    [self.sivenLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
    
    NSString *sivenStr = [NSString stringWithFormat:@"兑奖暗号:%@",[self.award awardSecret]];
    
    [self.sivenLabel setText:sivenStr];
    
    [self.view addSubview:self.sivenLabel];
    
    // Do any additional setup after loading the view.
    
    UIButton *changeView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [changeView setFrame:CGRectMake(0.0, self.view.frame.size.height-44-35-34, self.view.frame.size.width, 34)];
    
    [changeView setBackgroundImage:[UIImage imageNamed:@"cjdj3.png"] forState:UIControlStateNormal];
    
    [changeView setBackgroundImage:[UIImage imageNamed:@"change_1"] forState:UIControlStateSelected];
    
    [changeView addTarget:self action:@selector(loginOrRegister) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:changeView];
    
    UIButton *shareView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [shareView setFrame:CGRectMake(10.0, self.view.frame.size.height-74-45, self.view.frame.size.width-20.0, 45)];
    
    [shareView setBackgroundImage:[UIImage imageNamed:@"awardShared"] forState:UIControlStateNormal];
    
    
    [shareView addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareView];
    
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    NSError *error = [request error];
    
    NSLog(@"responseString:%@",error);
    
	_HUD.labelText = @"网络连接失败！";
    
    [_HUD show:YES];
    
    
}

-(void)loginOrRegister{
    
    [self showWithLabel];
    
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

- (void)showWithLabel {
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
	[self.view addSubview:_HUD];
	
	_HUD.delegate = self;
    
	_HUD.labelText = @"加载中...";
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(1);
    } completionBlock:^{
        //操作执行完后取消对话框
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [self shopLabel];
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if(request.tag == 2000){
        
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            
            NSString *userInfo = [bodyDatas objectForKey:@"resultAmount"];
            
            if([userInfo floatValue]/0.2 >0){
                
                NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
                
                NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
                
                NSString *domainName=[data objectForKey:@"domainName"];
                
                NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
                
                NSString *userIdKey = [NSString stringWithFormat:@"userId"];
                
                NSString * userId = [setting objectForKey:userIdKey];
                
                NSString *motionUrl = [NSString stringWithFormat:@"%@award/getMotionAward?userId=%@",domainName,userId];
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
                
                [request setTag:10001];
                
                [request setDelegate:self];
                
                [request startSynchronous];
            }else{
                
                UPViewController *upViewController = [[UPViewController alloc] init];
                
                [self.navigationController pushViewController:upViewController animated:YES];
                
            }
        }else{
            
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            
            [loginViewController set_redirectView:@"motion"];
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            
        }
        
        
    }else if(request.tag == 3000){
        
        UIAlertView *showSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:@"删除成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [showSuccess show];
        
    }else if(request.tag == 10001){
        
        
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyData = [datas objectForKey:@"body"];
            
            NSArray *awardList = [bodyData objectForKey:@"awardList"];
            
            NSLog(@"award%@",[awardList objectAtIndex:0]);
            
            NSDictionary *awardData = [awardList objectAtIndex:0];
            
            Award *awards = [[Award alloc] init];
            
            awards.id = [awardData objectForKey:@"id"];
            
            awards.awardImage = [awardData objectForKey:@"awardImage"];
            
            awards.awardInfo = [awardData objectForKey:@"awardInfo"];
            
            awards.awardNumber = [awardData objectForKey:@"awardNumber"];
            
            awards.awardAddress = [awardData objectForKey:@"awardAddress"];
            
            awards.awardPhone = [awardData objectForKey:@"awardPhone"];
            
            awards.awardStart = [awardData objectForKey:@"awardStart"];
            
            awards.awardEnd = [awardData objectForKey:@"awardEnd"];
            
            awards.awardSecret = [awardData objectForKey:@"awardSecret"];
            
            awards.awardProvide = [awardData objectForKey:@"awardProvide"];
            
            awards.awardMap = [awardData objectForKey:@"awardMap"];
            
            awards.awardRate = [awardData objectForKey:@"awardRate"];
            
            awards.createTime = [awardData objectForKey:@"createTime"];
            
            awards.updateTime = [awardData objectForKey:@"updateTime"];
            
            awards.awardType = [awardData objectForKey:@"awardType"];
            
            NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
            
            NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
            
            NSString *domainName=[data objectForKey:@"domainName"];
            
            NSString *awardImageUrl = [NSString stringWithFormat:@"%@%@",domainName,[awardData objectForKey:@"awardImage"]];
            
            [self.awardImageView setImageWithURL:[NSURL URLWithString:awardImageUrl]
                                placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"awardImage.png"]]];
            
            [self.shopLabel setText:[NSString stringWithFormat:@"本奖品由%@提供",[awardData objectForKey:@"awardProvide"]]];
            
            [self.twoLabel setText:[NSString stringWithFormat:@"奖励说明:%@",[awardData objectForKey:@"awardInfo"]]];
            
            [self.threeLabel setText:[NSString stringWithFormat:@"奖品编号:%@",[awardData objectForKey:@"awardNumber"]]];
            
            [self.fourLabel setText:[NSString stringWithFormat:@"地址:%@",[awardData objectForKey:@"awardAddress"]]];
            
            [self.fiveLabel setText:[NSString stringWithFormat:@"联系电话:%@",[awardData objectForKey:@"awardPhone"]]];
            
            [self.sixLabel setText:[NSString stringWithFormat:@"有效期限:%@-%@",[awardData objectForKey:@"awardStart"],[awardData objectForKey:@"awardEnd"]]];
            
            [self.sivenLabel setText:[NSString stringWithFormat:@"兑奖暗号:%@",[awardData objectForKey:@"awardSecret"]]];
        }
        
    }else if(request.tag == 2200){
        
        
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyData = [datas objectForKey:@"body"];
            
            NSString *appAddress = [bodyData objectForKey:@"appAddress"];
            
            self.appAddress=appAddress;
        }
        
    }else{
        
        if ([codeData intValue] == 0) {
            
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
    
//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[MainViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    
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
    
//    NSString *phone = nil;
    
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

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"didDismissWithButtonIndex");
    
    [self.viewDelegate removeAwardData:self.index];
    
    [self.navigationController popViewControllerAnimated:YES];
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

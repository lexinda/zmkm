//
//  MainViewController.m
//  zmkm
//
//  Created by zhumengle on 14-4-28.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize _mainScrollView;

@synthesize _pageControl;

@synthesize _HUD;

@synthesize _awardList;

@synthesize _motionButton;

@synthesize _superAwardList;

@synthesize testView;

@synthesize testView1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"newAward_04"] forBarMetrics:UIBarMetricsDefault];
        
        self.navigationItem.title = @"芝麻开门";
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:200 green:200 blue:200 alpha:1],[UIFont boldSystemFontOfSize:20.0f],[UIColor colorWithWhite:0.0 alpha:1], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor, nil]];
        
        [[UINavigationBar appearance] setTitleTextAttributes:dict];
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [infoButton setFrame:CGRectMake(0.0, 0.0, 27.0, 29.0)];
        
        [infoButton setBackgroundImage:[UIImage imageNamed:@"tou"] forState:UIControlStateNormal];
        
        [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        [self.navigationItem setRightBarButtonItem:rightItem];
        
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
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self showWithLabel];
    
    if (_awardList.count==0||_superAwardList.count==0) {
        
        _awardList = [[NSMutableArray alloc] init];
        
        _superAwardList = [[NSMutableArray alloc] init];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *latKey = [NSString stringWithFormat:@"lat"];
        
        NSString *latValue = [setting objectForKey:latKey];
        
        NSString *lngKey = [NSString stringWithFormat:@"lng"];
        
        NSString *lngValue = [setting objectForKey:lngKey];
        
        NSString *awardUrl = [NSString stringWithFormat:@"%@award/getNearAward?lat1=%@&lng1=%@",domainName,latValue,lngValue];
        
        //NSLog(@"%@",awardUrl);
        
        NSURL *url = [NSURL URLWithString:awardUrl];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        [request setDelegate:self];
        
        [request startSynchronous];
    }
    
    //[self showWithLabel];
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    _mainScrollView.pagingEnabled = YES;
    
    _mainScrollView.delegate = self;
    
    [self.view addSubview:_mainScrollView];    
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 159.0)];
    
    UIImage *topImage = [UIImage imageNamed:@"top.png"];
    
    [topImageView setImage:topImage];
    
    [_mainScrollView addSubview:topImageView];
    
    //NSLog(@"_imageArray%lu",(unsigned long)_awardList.count);
    
    UILabel *newLabel = [[UILabel alloc] init];
    
    [newLabel setFrame:CGRectMake(10.0, topImageView.frame.size.height+5, 100, 20)];
    
    [newLabel setText:@"最新大奖"];
    
    [newLabel setTextColor:[UIColor colorWithRed:65.0/255.0 green:189.0/255.0 blue:31.0/255.0 alpha:1.0]];

    [newLabel setTextAlignment:NSTextAlignmentLeft];
    
    [_mainScrollView addSubview:newLabel];
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0, newLabel.frame.origin.y+newLabel.frame.size.height, self.view.frame.size.width-20.0, 2)];
    
    UIImage *newScrollBg = [UIImage imageNamed:@"separate.png"];
    
    [newImageView setBackgroundColor:[UIColor colorWithPatternImage:newScrollBg]];
    
    [_mainScrollView addSubview:newImageView];
    
    CGRect textRect;
    
    if ([UIDevice isRunningOniPhone5]) {
        textRect =CGRectMake(11.0, newImageView.frame.origin.y+5.0, self.view.frame.size.width-22.0, 104.0);
    }else{
        
        textRect =CGRectMake(11.0, newImageView.frame.origin.y+5.0, self.view.frame.size.width-22.0, 54.0);
    }
    
    self.testView = [[testview alloc] initWithFrame:textRect];
    
    self.testView.delegateImage = self;
    
    [self.testView setBackgroundColor:[UIColor whiteColor]];
    
    [self.testView setDataArray:_awardList];
    
    [_mainScrollView addSubview:self.testView];
    
    UILabel *newLabel1 = [[UILabel alloc] init];
    
    CGRect labelRect1;
    
    if ([UIDevice isRunningOniPhone5]) {
        labelRect1 =CGRectMake(20.0, self.testView.frame.origin.y+testView.frame.size.height+10+50.0, 100, 20);
    }else{
        
        labelRect1 = CGRectMake(20.0, self.testView.frame.origin.y+testView.frame.size.height+10, 100, 20);
    }
    
    [newLabel1 setFrame:CGRectMake(10.0, self.testView.frame.origin.y+testView.frame.size.height+10, 100, 20)];
    
    [newLabel1 setText:@"超级大奖"];
    
    [newLabel1 setTextColor:[UIColor colorWithRed:65.0/255.0 green:189.0/255.0 blue:31.0/255.0 alpha:1.0]];
    
    [newLabel1 setTextAlignment:NSTextAlignmentLeft];
    
    [_mainScrollView addSubview:newLabel1];
    
    CGRect imageRect1;
    
    if ([UIDevice isRunningOniPhone5]) {
        imageRect1 =CGRectMake(10.0, newLabel1.frame.origin.y+newLabel1.frame.size.height, self.view.frame.size.width-20.0, 2.0);
    }else{
        
        imageRect1 = CGRectMake(10.0, newLabel1.frame.origin.y+newLabel1.frame.size.height, self.view.frame.size.width-20.0, 2.0);
    }
    
    UIImageView *newImageView1 = [[UIImageView alloc] initWithFrame:imageRect1];
    
    UIImage *newScrollBg1 = [UIImage imageNamed:@"separate.png"];
    
    [newImageView1 setBackgroundColor:[UIColor colorWithPatternImage:newScrollBg1]];
    
    [_mainScrollView addSubview:newImageView1];
    
    CGRect textRect1;
    
    if ([UIDevice isRunningOniPhone5]) {
        textRect1 =CGRectMake(11.0, newImageView1.frame.origin.y+5.0, self.view.frame.size.width-22.0, 104.0);
    }else{
        
        textRect1 =CGRectMake(11.0, newImageView1.frame.origin.y+5.0, self.view.frame.size.width-22.0, 54.0);
    }
    
    self.testView1 = [[testview alloc] initWithFrame:textRect1];
    
    self.testView1.delegateImage = self;
    
    [self.testView1 setBackgroundColor:[UIColor whiteColor]];
    
    [self.testView1 setDataArray:_superAwardList];
    
    [_mainScrollView addSubview:self.testView1];
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    
    [bgImageView setFrame:CGRectMake(self.view.frame.size.width, 0.0, self.view.frame.size.width, self.view.frame.size.height-44)];
    
    UIImage *bgImage = [UIImage imageNamed:@"mainBg"];
    
    [bgImageView setImage:bgImage];
    
    _motionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    CGRect motionRect = CGRectMake((self.view.frame.size.width-310)/2, self.view.frame.size.height-54-74, 310, 54);
    
    _motionButton.frame=motionRect;
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"awardNew1"] forState:UIControlStateNormal];
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"motionCheck"] forState:UIControlStateSelected];
    
    [_motionButton addTarget:self action:@selector(pushMotionView) forControlEvents:UIControlEventTouchUpInside];
    
    //    [_motionButton addTarget:self action:@selector(showWithLabel:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainScrollView addSubview:bgImageView];
    
    [self.view addSubview:_motionButton];
    
    CGRect pageRect = CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-30-44, 100, 20);
    
    _pageControl = [[QBluePageControl alloc] init];
    
    _pageControl.frame = pageRect;
    
    _pageControl.numberOfPages=2;
    
    _pageControl.currentPage=0;
    
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
//    [self.view addSubview:_pageControl];
    
}

-(void)showInfo{
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userAccountKey = [NSString stringWithFormat:@"userAccount"];
    
    NSString *userAccountvalue = [setting objectForKey:userAccountKey];
    
    NSString *userPasswordKey = [NSString stringWithFormat:@"userPassword"];
    
    NSString *userPasswordvalue = [setting objectForKey:userPasswordKey];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *userName = [userAccountvalue stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@user/login?userAccount=%@&userPassword=%@",domainName,userName,userPasswordvalue];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:loginUrl]];
    
    [request setTag:1111];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

-(void)pushMotionView{
    
    MotionViewController *motionViewControl = [[MotionViewController alloc] init];
    
    [motionViewControl setType:@"home"];
    
    [self.navigationController pushViewController:motionViewControl animated:YES];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int index =scrollView.contentOffset.x/self.view.frame.size.width;
    
    //NSLog(@"%deee",index);
    
    
    if (index == 0) {
         _pageControl.currentPage = index;
        
        self.navigationItem.title = @"芝麻开门";
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [infoButton setFrame:CGRectMake(0.0, 0.0, 37.0, 37.0)];
        
//        [infoButton setBackgroundImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
//        
//        [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    if (index == 1) {
        _pageControl.currentPage = index;
        
        self.navigationItem.title = @"芝麻开门";
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [infoButton setFrame:CGRectMake(0.0, 0.0, 37.0, 37.0)];
        
        [infoButton setBackgroundImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
        
        [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
        
        
        [self.navigationItem setRightBarButtonItem:rightItem];
        
    }
    
}

-(void)changePage:(id)sender{

    //NSLog(@"go");
    
    [_pageControl updateDots];
    
}

- (void)showWithLabel {
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
	[self.navigationController.view addSubview:_HUD];
	
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

    NSString *responseString = [request responseString];

    //NSLog(@"responseString:%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if (request.tag == 1111) {
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            
            NSDictionary *userInfo = [bodyDatas objectForKey:@"userInfo"];
            
            User *user = [[User alloc] init];
            
            [user setId:[userInfo objectForKey:@"id"]];
            
            [user setUserAccount:[userInfo objectForKey:@"userAccount"]];
            
            [user setUserPassword:[userInfo objectForKey:@"userPassword"]];
            
            [user setUserName:[userInfo objectForKey:@"userName"]];
            
            [user setUserGender:[userInfo objectForKey:@"userGender"]];
            
            [user setUserPhone:[userInfo objectForKey:@"userPhone"]];
            
            [user setUserEmail:[userInfo objectForKey:@"userEmail"]];
            
            [user setCreateTime:[userInfo objectForKey:@"createTime"]];
            
            [user setUpdateTime:[userInfo objectForKey:@"updateTime"]];
            
            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            
            NSString *userKey = [NSString stringWithFormat:@"userId"];
            
            [setting setObject:user.id forKey:userKey];
            
            NSString *userName = [NSString stringWithFormat:@"userName"];
            
            [setting setObject:user.userName forKey:userName];
            
            NSString *genderStr=@"";
            
            if ([user.userGender intValue] == 0) {
                genderStr = @"男";
            }else{
                genderStr = @"女";
            }
            
            NSString *userGender = [NSString stringWithFormat:@"userGender"];
            
            [setting setObject:genderStr forKey:userGender];
            
            NSString *userPhone = [NSString stringWithFormat:@"userPhone"];
            
            [setting setObject:user.userPhone forKey:userPhone];
            
            NSString *userEmail = [NSString stringWithFormat:@"userEmail"];
            
            [setting setObject:user.userEmail forKey:userEmail];
            
            [setting synchronize];
            
//            SelfTableViewController *selfTableViewController = [[SelfTableViewController alloc] initWithStyle:UITableViewStylePlain];
            
            NewSelfInfoViewController *selfTableViewController = [[NewSelfInfoViewController alloc] init];
            
            [self.navigationController pushViewController:selfTableViewController animated:YES];
        }else{
            
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            
            [loginViewController set_redirectView:@"self"];
            
            [self.navigationController pushViewController:loginViewController animated:YES];
            
        }

    }else if(request.tag==999){
    
        NSDictionary *bodyData = [datas objectForKey:@"body"];
        
        NSArray *awardList = [bodyData objectForKey:@"awardList"];
        
        for (int i=0;i<awardList.count;i++ ) {
            
            //NSLog(@"award%@",[awardList objectAtIndex:i]);
            
            NSDictionary *awardData = [awardList objectAtIndex:i];
            
            if ([[awardData objectForKey:@"awardType"] intValue] == 0) {
                
                Award *award = [[Award alloc] init];
                
                award.id = [awardData objectForKey:@"id"];
                
                award.awardImage = [awardData objectForKey:@"awardImage"];
                
                award.awardInfo = [awardData objectForKey:@"awardInfo"];
                
                award.awardNumber = [awardData objectForKey:@"awardNumber"];
                
                award.awardAddress = [awardData objectForKey:@"awardAddress"];
                
                award.awardPhone = [awardData objectForKey:@"awardPhone"];
                
                award.awardStart = [awardData objectForKey:@"awardStart"];
                
                award.awardEnd = [awardData objectForKey:@"awardEnd"];
                
                award.awardSecret = [awardData objectForKey:@"awardSecret"];
                
                award.awardProvide = [awardData objectForKey:@"awardProvide"];
                
                award.awardMap = [awardData objectForKey:@"awardMap"];
                
                award.awardRate = [awardData objectForKey:@"awardRate"];
                
                award.createTime = [awardData objectForKey:@"createTime"];
                
                award.updateTime = [awardData objectForKey:@"updateTime"];
                
                award.awardType = [awardData objectForKey:@"awardType"];
                
                [_awardList addObject:award];
                
            }else if ([[awardData objectForKey:@"awardType"] intValue] == 1) {
                
                Award *award = [[Award alloc] init];
                
                award.id = [awardData objectForKey:@"id"];
                
                award.awardImage = [awardData objectForKey:@"awardImage"];
                
                award.awardInfo = [awardData objectForKey:@"awardInfo"];
                
                award.awardNumber = [awardData objectForKey:@"awardNumber"];
                
                award.awardAddress = [awardData objectForKey:@"awardAddress"];
                
                award.awardPhone = [awardData objectForKey:@"awardPhone"];
                
                award.awardStart = [awardData objectForKey:@"awardStart"];
                
                award.awardEnd = [awardData objectForKey:@"awardEnd"];
                
                award.awardSecret = [awardData objectForKey:@"awardSecret"];
                
                award.awardProvide = [awardData objectForKey:@"awardProvide"];
                
                award.awardMap = [awardData objectForKey:@"awardMap"];
                
                award.awardRate = [awardData objectForKey:@"awardRate"];
                
                award.createTime = [awardData objectForKey:@"createTime"];
                
                award.updateTime = [awardData objectForKey:@"updateTime"];
                
                award.awardType = [awardData objectForKey:@"awardType"];
                
                [_superAwardList addObject:award];
                
            }
            
            [self.testView setNeedsDisplay];
            
            [self.testView1 setNeedsDisplay];
            
        }
        
    }else if(request.tag == 333){
        
        if ([codeData intValue] == 0) {
            
            NSDictionary *awardData = [datas objectForKey:@"body"];
            
            Award *award = [[Award alloc] init];
            
            award.id = [awardData objectForKey:@"id"];
            
            award.awardImage = [awardData objectForKey:@"awardImage"];
            
            award.awardName = [awardData objectForKey:@"awardName"];

            award.awardContent = [awardData objectForKey:@"awardContent"];
            
            award.awardInfo = [awardData objectForKey:@"awardInfo"];
            
            award.awardNumber = [awardData objectForKey:@"awardNumber"];
            
            award.awardAddress = [awardData objectForKey:@"awardAddress"];
            
            award.awardPhone = [awardData objectForKey:@"awardPhone"];
            
            award.awardStart = [awardData objectForKey:@"awardStart"];
            
            award.awardEnd = [awardData objectForKey:@"awardEnd"];
            
            award.awardSecret = [awardData objectForKey:@"awardSecret"];
            
            award.awardProvide = [awardData objectForKey:@"awardProvide"];
            
            award.awardMap = [awardData objectForKey:@"awardMap"];
            
            award.awardRate = [awardData objectForKey:@"awardRate"];
            
            award.createTime = [awardData objectForKey:@"createTime"];
            
            award.updateTime = [awardData objectForKey:@"updateTime"];
            
            award.awardType = [awardData objectForKey:@"awardType"];
            
            AwardContentViewController *awardContentViewController = [[AwardContentViewController alloc] init];
            
            awardContentViewController.award = award;
            
            [self.navigationController pushViewController:awardContentViewController animated:YES];
        }
        
       
    }else{
    
    if ([codeData intValue] == 0) {
        //NSLog(@"加载成功！");
        
        NSDictionary *bodyData = [datas objectForKey:@"body"];
        
        NSArray *awardList = [bodyData objectForKey:@"awardList"];
        
        for (int i=0;i<awardList.count;i++ ) {
            
            //NSLog(@"award%@",[awardList objectAtIndex:i]);
            
            NSDictionary *awardData = [awardList objectAtIndex:i];
            
            if ([[awardData objectForKey:@"awardType"] intValue] == 0) {
            
                Award *award = [[Award alloc] init];
            
                award.id = [awardData objectForKey:@"id"];
            
                award.awardImage = [awardData objectForKey:@"awardImage"];
            
                award.awardInfo = [awardData objectForKey:@"awardInfo"];
            
                award.awardNumber = [awardData objectForKey:@"awardNumber"];
            
                award.awardAddress = [awardData objectForKey:@"awardAddress"];
            
                award.awardPhone = [awardData objectForKey:@"awardPhone"];
            
                award.awardStart = [awardData objectForKey:@"awardStart"];
            
                award.awardEnd = [awardData objectForKey:@"awardEnd"];
            
                award.awardSecret = [awardData objectForKey:@"awardSecret"];
            
                award.awardProvide = [awardData objectForKey:@"awardProvide"];
            
                award.awardMap = [awardData objectForKey:@"awardMap"];
            
                award.awardRate = [awardData objectForKey:@"awardRate"];
            
                award.createTime = [awardData objectForKey:@"createTime"];
            
                award.updateTime = [awardData objectForKey:@"updateTime"];
            
                award.awardType = [awardData objectForKey:@"awardType"];
            
                [_awardList addObject:award];
                
            }else if ([[awardData objectForKey:@"awardType"] intValue] == 1) {
                
                Award *award = [[Award alloc] init];
                
                award.id = [awardData objectForKey:@"id"];
                
                award.awardImage = [awardData objectForKey:@"awardImage"];
                
                award.awardInfo = [awardData objectForKey:@"awardInfo"];
                
                award.awardNumber = [awardData objectForKey:@"awardNumber"];
                
                award.awardAddress = [awardData objectForKey:@"awardAddress"];
                
                award.awardPhone = [awardData objectForKey:@"awardPhone"];
                
                award.awardStart = [awardData objectForKey:@"awardStart"];
                
                award.awardEnd = [awardData objectForKey:@"awardEnd"];
                
                award.awardSecret = [awardData objectForKey:@"awardSecret"];
                
                award.awardProvide = [awardData objectForKey:@"awardProvide"];
                
                award.awardMap = [awardData objectForKey:@"awardMap"];
                
                award.awardRate = [awardData objectForKey:@"awardRate"];
                
                award.createTime = [awardData objectForKey:@"createTime"];
                
                award.updateTime = [awardData objectForKey:@"updateTime"];
                
                award.awardType = [awardData objectForKey:@"awardType"];
                
                [_superAwardList addObject:award];
                
            }            
            
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"请求数据错误！"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
    }
    
    }
    //NSData *responseData = [request responseData];
    
    [_HUD hide:YES];

}

-(void)requestFailed:(ASIHTTPRequest *)request{
    
    NSError *error = [request error];

    //NSLog(@"responseString:%@",error);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络连接失败，请重新连接！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
    
}

-(void)goBack{
    
    IntroductionTwoViewController *introductionTwoViewController = [[IntroductionTwoViewController alloc] init];
//    typedef NS_ENUM(NSInteger, UIModalTransitionStyle) {
//        UIModalTransitionStyleCoverVertical = 0,向上
//        UIModalTransitionStyleFlipHorizontal,翻转
//        UIModalTransitionStyleCrossDissolve,渐隐
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
//        UIModalTransitionStylePartialCurl,
//#endif
//    };
//   
    
    introductionTwoViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //[self presentModalViewController:infoViewController animated:YES];//备注1
    [self presentViewController:introductionTwoViewController animated:YES completion:^{//备注2
        NSLog(@"show InfoView!");
    }];
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"重新联网。。。。。");
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *latKey = [NSString stringWithFormat:@"lat"];
    
    NSString *latValue = [setting objectForKey:latKey];
    
    NSString *lngKey = [NSString stringWithFormat:@"lng"];
    
    NSString *lngValue = [setting objectForKey:lngKey];
    
    NSString *awardUrl = [NSString stringWithFormat:@"%@award/getNearAward?lat1=%@&lng1=%@",domainName,latValue,lngValue];
    
    //NSLog(@"%@",awardUrl);
    
    NSURL *url = [NSURL URLWithString:awardUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setTag:999];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
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

-(void)showAwardInfo:(int)id{
    
    [self showWithLabel];
    
    NSLog(@"reloadView%d",id);
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *awardUrl = [NSString stringWithFormat:@"%@award/getAwardById?awardId=%d",domainName,id];
    
    NSLog(@"%@",awardUrl);
    
    NSURL *url = [NSURL URLWithString:awardUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    request.tag = 333;
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

@end

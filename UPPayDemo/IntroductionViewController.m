//
//  IntroductionViewController.m
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "IntroductionViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

@synthesize _mainViewController;

@synthesize _introLeftView;

@synthesize _introRightView;

@synthesize _introBottomLeftView;

@synthesize _introBottomRightView;

@synthesize _introductionView;

@synthesize _topLabel;

@synthesize _centerLabel;

@synthesize _cllocationManager;

@synthesize mainScrollView;

@synthesize _HUD;

@synthesize _leadView;

@synthesize _awardList;

@synthesize _superAwardList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *mainView = [[UIView alloc] initWithFrame:rect];
    
    [mainView setBackgroundColor:[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0]];
    
    self.view = mainView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
//    _leadView = [[LeadScroll alloc] initWithFrame:self.view.frame];
//
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *isReadKey = [NSString stringWithFormat:@"isRead"];
    
    NSString *isRead = [setting objectForKey:isReadKey];
    
    if([isRead isEqualToString:@"1"]){
        
        for (UIView *view in [self.view subviews]) {
            [view removeFromSuperview];
        }
        
        CGRect mainRect = [[UIScreen mainScreen] bounds];
        
        _leadView = [[LeadScroll alloc] initWithFrame:mainRect];
        
        [_leadView setContentSize:CGSizeMake(mainRect.size.width*3, mainRect.size.height)];
        
        [_leadView set_leadDelegate:self];
        
        [self.view addSubview:_leadView];
        
    }
   
//
//    [self.view addSubview:_leadView];
//
//    _leadView = [[LeadScroll alloc] initWithFrame:CGRectMake(-20.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
//    
//    [_leadView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-20)];
//    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _awardList = [[NSMutableArray alloc] init];
    
    _superAwardList = [[NSMutableArray alloc] init];
    
    _cllocationManager = [[CLLocationManager alloc] init];
    
    _cllocationManager.delegate = self;
    
    _cllocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _cllocationManager.distanceFilter = 1000.0;
    
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [_cllocationManager startUpdatingLocation];
    }
    else {
        NSLog(@"请开启定位功能！");
    }    
    
    _introductionView = [[UIView alloc] initWithFrame:self.view.frame];
    
    CGPoint center=self.view.center;
    
    NSLog(@"%f,%f",center.x,center.y);
    
    UIImage *topLabelImg = [UIImage imageNamed:@"zmkm"];
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-142)/2, center.y-113-44-41, 142, 41)];
    [_topLabel setBackgroundColor:[UIColor colorWithPatternImage:topLabelImg]];
    
    [_introductionView addSubview:_topLabel];
    
    UIImage *centerLabelImg = [UIImage imageNamed:@"yyy"];
    
    _centerLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-118)/2, _topLabel.frame.origin.y+_topLabel.frame.size.height, 118, 44)];
    [_centerLabel setBackgroundColor:[UIColor colorWithPatternImage:centerLabelImg]];
    
    [_introductionView addSubview:_centerLabel];
    
    UIImage *introLeft = [UIImage imageNamed:@"intro_03"];
    
    _introLeftView = [[UIImageView alloc] initWithImage:introLeft];
    
    _introLeftView.frame = CGRectMake(center.x-113.0, center.y-109, 109, 113);
    
    [_introductionView addSubview:_introLeftView];
    
    UIImage *introRight = [UIImage imageNamed:@"intro_04"];
    
    _introRightView = [[UIImageView alloc] initWithImage:introRight];
    
    _introRightView.frame = CGRectMake(_introLeftView.frame.origin.x+_introLeftView.frame.size.width, _introLeftView.frame.origin.y, 109, 113);
    
    [_introductionView addSubview:_introRightView];
    
    UIImage *introBottomLeft = [UIImage imageNamed:@"intro_06"];
    
    _introBottomLeftView = [[UIImageView alloc] initWithImage:introBottomLeft];
    
    _introBottomLeftView.frame = CGRectMake(_introLeftView.frame.origin.x, _introLeftView.frame.size.height+_introLeftView.frame.origin.y, 109, 113);
    
    [_introductionView addSubview:_introBottomLeftView];
    
    UIImage *introBottomRight = [UIImage imageNamed:@"intro_07"];
    
    _introBottomRightView = [[UIImageView alloc] initWithImage:introBottomRight];
    
    _introBottomRightView.frame = CGRectMake(_introBottomLeftView.frame.origin.x+_introBottomLeftView.frame.size.width, _introBottomLeftView.frame.origin.y, 109, 113);
    
    [_introductionView addSubview:_introBottomRightView];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    UIImage *play = [UIImage imageNamed:@"play"];
    
    UIImage *check = [UIImage imageNamed:@"check"];
    
    [playButton setBackgroundImage:play forState:UIControlStateNormal];
    
    [playButton setBackgroundImage:check forState:UIControlStateSelected];
    
    playButton.frame=CGRectMake(center.x-22, center.y-5, 35.0, 18.0);
    
    [playButton addTarget:self action:@selector(animateGo) forControlEvents:UIControlEventTouchUpInside];
    
    [_introductionView addSubview:playButton];
    
    [self.view addSubview:_introductionView];
    
}
-(void)animateGo{
    NSLog(@"animateGo");
    
    NSLog(@"%f,%f",_introLeftView.center.x,_introLeftView.center.y);
    
    CALayer *_leftLayer = _introLeftView.layer;
    
    CALayer *_rightLayer = _introRightView.layer;
    
    CALayer *_bottomLeftLayer = _introBottomLeftView.layer;
    
    CALayer *_bottomRightLayer = _introBottomRightView.layer;
    
    float _leftX =_leftLayer.position.x/1.7;
    
    float _leftY =_leftLayer.position.y/1.2;
    
    float _rightX = _rightLayer.position.x+(self.view.frame.size.width-_rightLayer.position.x)/2;
    
    float _rightY = _rightLayer.position.y/1.2;
    
    float _bottomLeftX = _leftX;
    
    float _bottomLeftY = _bottomLeftLayer.position.y*1.2;
    
    float _bottomRightX = _rightX;
    
    float _bottomRightY = _bottomRightLayer.position.y*1.2;
    
    CALayer *_topLayer = _topLabel.layer;
    
    CGMutablePathRef topLabelPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(topLabelPath,NULL,_topLayer.position.x,_topLayer.position.y);
    
    CGPathAddLineToPoint(topLabelPath,NULL, _topLayer.position.x, _topLayer.position.y/2);
    
    CAKeyframeAnimation *_topAnimation =[self keyframeAniamtion:topLabelPath durTimes:1.3 Rep:1];
    
    [_topLayer addAnimation:_topAnimation forKey:nil];
    
    CALayer *_centerLayer = _centerLabel.layer;
    
    CGMutablePathRef centerLabelPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(centerLabelPath,NULL,_centerLayer.position.x,_centerLayer.position.y);
    
    CGPathAddLineToPoint(centerLabelPath,NULL, _centerLayer.position.x, _topLayer.position.y);
    
    CAKeyframeAnimation *_centerAnimation =[self keyframeAniamtion:centerLabelPath durTimes:1.3 Rep:1];
    
    [_centerLayer addAnimation:_centerAnimation forKey:nil];
    
    CGMutablePathRef leftPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(leftPath,NULL,_leftLayer.position.x,_leftLayer.position.y);
    
    CGPathAddLineToPoint(leftPath,NULL, _leftX, _leftY);
    
    CAKeyframeAnimation *_leftAnimation =[self keyframeAniamtion:leftPath durTimes:1.3 Rep:1];
    
    [_leftLayer addAnimation:_leftAnimation forKey:nil];
    
    CGMutablePathRef rightPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(rightPath,NULL,_rightLayer.position.x,_rightLayer.position.y);
    
    CGPathAddLineToPoint(rightPath,NULL, _rightX, _rightY);
    
    CAKeyframeAnimation *_rightAnimation =[self keyframeAniamtion:rightPath durTimes:1.3 Rep:1];
    
    [_rightLayer addAnimation:_rightAnimation forKey:nil];
    
    CGMutablePathRef bottomLeftPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(bottomLeftPath,NULL,_bottomLeftLayer.position.x,_bottomLeftLayer.position.y);
    
    CGPathAddLineToPoint(bottomLeftPath,NULL, _bottomLeftX, _bottomLeftY);
    
    CAKeyframeAnimation *_bottomLeftAnimation =[self keyframeAniamtion:bottomLeftPath durTimes:1.3 Rep:1];
    
    [_bottomLeftLayer addAnimation:_bottomLeftAnimation forKey:nil];
    
    CGMutablePathRef bottomRightPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(bottomRightPath,NULL,_bottomRightLayer.position.x,_bottomRightLayer.position.y);
    
    CGPathAddLineToPoint(bottomRightPath,NULL, _bottomRightX, _bottomRightY);
    
    CAKeyframeAnimation *_bottomRightAnimation =[self keyframeAniamtion:bottomRightPath durTimes:1.3 Rep:1];

    _bottomRightAnimation.delegate = self;
    
    [_bottomRightLayer addAnimation:_bottomRightAnimation forKey:nil];
    
}

-(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}
-(void)animationDidStart:(CAAnimation *)anim{
    
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:1.3f];
    
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    [animation setType:kCATransitionFade];
    
    [_introductionView removeFromSuperview];
    
    [self.view.layer addAnimation:animation forKey:nil];
    
}
//
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"end%hhd",flag);
    
    sleep(1);
    
    _leadView = [[LeadScroll alloc] initWithFrame:self.view.frame];
    
    [_leadView set_leadDelegate:self];
    
    [_leadView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height)];
    
    [self.view addSubview:_leadView];
    
}

- (void)showWithLabel {
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
	[self.view addSubview:_HUD];
	
	_HUD.delegate = self;
    
	_HUD.labelText = @"加载中...";
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(3);
    } completionBlock:^{
        //操作执行完后取消对话框
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
}

-(void)showView{
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
	[self.view addSubview:_HUD];
	
	_HUD.delegate = self;
    
	_HUD.labelText = @"正在载入，请稍后...";
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(3);
    } completionBlock:^{
        //操作执行完后取消对话框
        [_HUD removeFromSuperview];
        _HUD = nil;
    }];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *isReadKey = [NSString stringWithFormat:@"isRead"];
    
    NSString *isRead = @"1";
    
    [setting setObject: isRead forKey:isReadKey];
    
    [setting synchronize];
    
    _mainViewController = [[MainViewController alloc] init];
    
    [_mainViewController set_awardList:_awardList];
    
    [_mainViewController set_superAwardList:_superAwardList];
    
    [self.navigationController pushViewController:_mainViewController animated:NO];

}

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    NSLog(@"finish!!!");
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *latKey = [NSString stringWithFormat:@"lat"];
    
    [setting setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:latKey];
    
    NSString *lngKey = [NSString stringWithFormat:@"lng"];
    
    [setting setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:lngKey];
    
    [setting synchronize];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *awardUrl = [NSString stringWithFormat:@"%@award/getNearAward?lat1=%f&lng1=%f",domainName,newLocation.coordinate.latitude,newLocation.coordinate.longitude];
    
    NSLog(@"%@",awardUrl);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"123" message:awardUrl delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //
    //    [alert show];
    
    NSURL *url = [NSURL URLWithString:awardUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    // 停止位置更新
    [_cllocationManager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *latKey = [NSString stringWithFormat:@"lat"];
    
    [setting setObject:[NSString stringWithFormat:@"%f",0.0] forKey:latKey];
    
    NSString *lngKey = [NSString stringWithFormat:@"lng"];
    
    [setting setObject:[NSString stringWithFormat:@"%f",0.0] forKey:lngKey];
    
    [setting synchronize];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSString *awardUrl = [NSString stringWithFormat:@"%@award/getNearAward?lat1=%f&lng1=%f",domainName,0.0,0.0];
    
    NSLog(@"%@",awardUrl);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"123" message:awardUrl delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //
    //    [alert show];
    
    NSURL *url = [NSURL URLWithString:awardUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"responseString:%@",responseString);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"123" message:responseString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //
    //    [alert show];
    
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
            NSLog(@"加载成功！");
            
            NSDictionary *bodyData = [datas objectForKey:@"body"];
            
            NSArray *awardList = [bodyData objectForKey:@"awardList"];
            
            for (int i=0;i<awardList.count;i++ ) {
                
                NSLog(@"award%@",[awardList objectAtIndex:i]);
                
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
    
    NSLog(@"responseString:%@",error);
    
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"123" message:error delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    //    
    //    [alert show];
    
    
	_HUD.labelText = @"网络连接失败！";
    
    [_HUD show:YES];
    
    
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

-(void)redirectLeadView{

    NSLog(@"redirect");
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
	[self.view addSubview:_HUD];
	
	_HUD.delegate = self;
    
	_HUD.labelText = @"加载中...";
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        //对话框显示时需要执行的操作
        sleep(3);
    } completionBlock:^{
        //操作执行完后取消对话框
        [_HUD removeFromSuperview];
        _HUD = nil;
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *isReadKey = [NSString stringWithFormat:@"isRead"];
        
        NSString *isRead = @"1";
        
        [setting setObject: isRead forKey:isReadKey];
        
        [setting synchronize];
        
        _mainViewController = [[MainViewController alloc] init];
        
        [_mainViewController set_awardList:_awardList];
        
        [_mainViewController set_superAwardList:_superAwardList];
        
        [self.navigationController pushViewController:_mainViewController animated:NO];
        
    }];
   

}


@end

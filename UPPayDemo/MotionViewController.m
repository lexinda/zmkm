//
//  MotionViewController.m
//  zmkm
//
//  Created by zhumengle on 14-4-29.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "MotionViewController.h"

#import <AudioToolbox/AudioToolbox.h>

@interface MotionViewController ()

@end

@implementation MotionViewController

@synthesize _motionImageView;

@synthesize type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [self.navigationItem setTitle:@"摇一摇"];
        
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
    
    [mainView setBackgroundColor:[UIColor colorWithRed:234.0/255.0 green:229.0/255 blue:224.0/255.0 alpha:1.0]];
    
    self.view = mainView;
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:YES];
    
    self.type = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    
    UIImage *image = [UIImage imageNamed:@"motion_5"];
    
//    UIImage *image1 = [UIImage imageNamed:@"motion_2"];
//    
//    UIImage *image2 = [UIImage imageNamed:@"motion_3"];
    
    _motionImageView = [[UIImageView alloc] init];
    
    [_motionImageView setFrame:CGRectMake((self.view.frame.size.width-292.0)/2, (self.view.frame.size.height-248.0-134)/2, 292.0, 248.0)];
    
//    _motionImageView.animationImages = [NSArray arrayWithObjects:image,image1,image2, nil];
    
    _motionImageView.animationImages = [NSArray arrayWithObjects:image, nil];
    
    [_motionImageView setImage:image];
    
    _motionImageView.animationDuration=0.3;
    
    _motionImageView.animationRepeatCount=50;
    
    [self.view addSubview:_motionImageView];
    
    UILabel *motionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, (self.view.frame.size.height-248.0-134)/2+248.0, self.view.frame.size.width, 40.0)];
    
    [motionLabel setText:@"摇一摇开始抽大奖"];
    
    [motionLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:motionLabel];
    
    // Do any additional setup after loading the view.
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"start");
    
    [_motionImageView startAnimating];
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"end");
    
    //摇动结束
    
    if(event.subtype == UIEventSubtypeMotionShake) {
        
        sleep(2);
        
        [_motionImageView stopAnimating];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *userIdKey = [NSString stringWithFormat:@"userId"];
        
        NSString * userId = [setting objectForKey:userIdKey];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        NSString *motionUrl=@"";
        
        if(userId == NULL){
            
             motionUrl = [NSString stringWithFormat:@"%@award/getNomalMotionAward",domainName];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
            
            [request setDelegate:self];
            
            [request startSynchronous];
            
        }else{
            
            if ([self.type isEqualToString:@"home"]) {
                
                NSString *userFree = [NSString stringWithFormat:@"%@user/getFreeUserAward?userId=%d",domainName,[userId intValue]];
                
                NSLog(@"%@",userFree);
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:userFree]];
                
                [request setTag:5111];
                
                [request setDelegate:self];
                
                [request startSynchronous];
                
            }else{

                motionUrl = [NSString stringWithFormat:@"%@user/getUserAmount?userId=%d",domainName,[userId intValue]];
            
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
            
                [request setTag:4111];
            
                [request setDelegate:self];
            
                [request startSynchronous];
            }
            //    UIAlertView *loginInfo = [[UIAlertView alloc] initWithTitle:NSLocalizedString(userName, nil) message:NSLocalizedString(userPassword, nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //
            //    [loginInfo show];
        }
        
        NSLog(@"%@",motionUrl);
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if (request.tag == 4111) {
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
                
                [request setDelegate:self];
                
                [request startSynchronous];
                
            }else{
                
                UPViewController *upViewController = [[UPViewController alloc] init];
                
                [self.navigationController pushViewController:upViewController animated:YES];
                
            }
        }
    }else if (request.tag == 5111) {
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyDatas = [datas objectForKey:@"body"];
            
            NSString *userInfo = [bodyDatas objectForKey:@"isFree"];
            
            if([userInfo intValue]>0){
                
//                NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
//                
//                NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
//                
//                NSString *domainName=[data objectForKey:@"domainName"];
//                
//                NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
//                
//                NSString *userIdKey = [NSString stringWithFormat:@"userId"];
//                
//                NSString * userId = [setting objectForKey:userIdKey];
//                
//                NSString *motionUrl = [NSString stringWithFormat:@"%@user/getUserAmount?userId=%d",domainName,[userId intValue]];
//                
//                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
//                
//                [request setTag:4111];
//                
//                [request setDelegate:self];
//                
//                [request startSynchronous];
                
                NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
                
                NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
                
                NSString *domainName=[data objectForKey:@"domainName"];
                
                NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
                
                NSString *userIdKey = [NSString stringWithFormat:@"userId"];
                
                NSString * userId = [setting objectForKey:userIdKey];
                
                NSString *latKey = [NSString stringWithFormat:@"lat"];
                
                NSString *latValue = [setting objectForKey:latKey];
                
                NSString *lngKey = [NSString stringWithFormat:@"lng"];
                
                NSString *lngValue = [setting objectForKey:lngKey];
                
//                NSString *awardUrl = [NSString stringWithFormat:@"%@award/getNearAward?lat1=%@&lng1=%@",domainName,latValue,lngValue];
                
                NSString *motionUrl = [NSString stringWithFormat:@"%@award/getMotionAward?userId=%@&lat1=%@&lng1=%@",domainName,userId,latValue,lngValue];
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
                
                [request setDelegate:self];
                
                [request startSynchronous];
                
            }else{
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"您今天的摇奖次数已经用完！", nil) delegate:nil cancelButtonTitle:@"明天再来" otherButtonTitles:@"继续", nil];
                
                alert.delegate=self;
                
                [alert show];
                
            }
        }
    }else{
    
    if ([codeData intValue] == 0) {
        
        NSDictionary *bodyData = [datas objectForKey:@"body"];
        
        NSArray *awardList = [bodyData objectForKey:@"awardList"];
        
        NSLog(@"award%@",[awardList objectAtIndex:0]);
        
        NSDictionary *awardData = [awardList objectAtIndex:0];
        
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
        
        AwardViewController *awardViewController = [[AwardViewController alloc] init];
        
        [awardViewController setAward:award];
        
        [self.navigationController pushViewController:awardViewController animated:YES];
    }
    }
}


-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"cancel");
    
    //摇动结束
    
    if(event.subtype == UIEventSubtypeMotionShake) {
        
        sleep(2);
        
        [_motionImageView stopAnimating];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *userIdKey = [NSString stringWithFormat:@"userId"];
        
        NSString * userId = [setting objectForKey:userIdKey];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        NSString *motionUrl=@"";
        
        if(userId == NULL){
            
            motionUrl = [NSString stringWithFormat:@"%@award/getNomalMotionAward",domainName];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
            
            [request setDelegate:self];
            
            [request startSynchronous];
            
        }else{
            
            if ([self.type isEqualToString:@"home"]) {
                
                NSString *userFree = [NSString stringWithFormat:@"%@user/getFreeUserAward?userId=%d",domainName,[userId intValue]];
                
                NSLog(@"%@",userFree);
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:userFree]];
                
                [request setTag:5111];
                
                [request setDelegate:self];
                
                [request startSynchronous];
                
            }else{
                
                motionUrl = [NSString stringWithFormat:@"%@user/getUserAmount?userId=%d",domainName,[userId intValue]];
                
                ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
                
                [request setTag:4111];
                
                [request setDelegate:self];
                
                [request startSynchronous];
            }
            
//            motionUrl = [NSString stringWithFormat:@"%@award/getMotionAward?userId=%@",domainName,userId];
            
            //    UIAlertView *loginInfo = [[UIAlertView alloc] initWithTitle:NSLocalizedString(userName, nil) message:NSLocalizedString(userPassword, nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //
            //    [loginInfo show];
        }
        
        NSLog(@"%@",motionUrl);
        
        
    }
    
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    
    if (buttonIndex == 0) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MainViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
    
    if(buttonIndex == 1){
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *userIdKey = [NSString stringWithFormat:@"userId"];
        
        NSString * userId = [setting objectForKey:userIdKey];
        
        NSString *motionUrl = [NSString stringWithFormat:@"%@user/getUserAmount?userId=%d",domainName,[userId intValue]];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:motionUrl]];
        
        [request setTag:4111];
        
        [request setDelegate:self];
        
        [request startSynchronous];
        
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

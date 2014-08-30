//
//  NewAwardViewController.m
//  zmkm
//
//  Created by zhumengle on 14-5-1.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "NewAwardViewController.h"

@interface NewAwardViewController ()

@end

@implementation NewAwardViewController

@synthesize _aboutController;

@synthesize _motionButton;

@synthesize _HUD;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"芝麻开门";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
        UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [infoButton setFrame:CGRectMake(0.0, 0.0, 37.0, 37.0)];
        
        [infoButton setBackgroundImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
        
        [infoButton addTarget:self action:@selector(showInfo) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];

                               
        [self.navigationItem setRightBarButtonItem:rightItem];
        
        
    }
    return self;
}

-(void)loadView{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *mainView = [[UIView alloc] initWithFrame:rect];
    
    [mainView setBackgroundColor:[UIColor clearColor]];
    
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Do any additional setup after loading the view.
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    
    [bgImageView setFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    UIImage *bgImage = [UIImage imageNamed:@"mainBg"];
    
    [bgImageView setImage:bgImage];
    
    [self.view addSubview:bgImageView];
    
    _motionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    CGRect motionRect = CGRectMake((self.view.frame.size.width-238)/2, self.view.frame.size.height-94-64, 238, 54);
    
    _motionButton.frame=motionRect;
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"motion"] forState:UIControlStateNormal];
    
    [_motionButton setBackgroundImage:[UIImage imageNamed:@"motionCheck"] forState:UIControlStateSelected];
    
    [_motionButton addTarget:self action:@selector(pushMotionView) forControlEvents:UIControlEventTouchUpInside];
    
//    [_motionButton addTarget:self action:@selector(showWithLabel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_motionButton];
    
//    NSURL *url = [NSURL URLWithString:@"http://allseeing-i.com"];
//    
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    
//    [request setDelegate:self];
//    
//    [request startAsynchronous];
    
}

-(void)goBack{
    
   [self.navigationController popViewControllerAnimated:YES];
    
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
    
    NSString *loginUrl = [NSString stringWithFormat:@"%@user/login?userAccount=%@&userPassword=%@",domainName,userAccountvalue,userPasswordvalue];
    
    //    UIAlertView *loginInfo = [[UIAlertView alloc] initWithTitle:NSLocalizedString(userName, nil) message:NSLocalizedString(userPassword, nil) delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //
    //    [loginInfo show];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:loginUrl]];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request{

    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if (request.tag == 100) {
        if ([codeData intValue] == 0) {
            NSLog(@"加载成功！");
            
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
                
                //    [self.navigationController pushViewController:_motionViewController animated:YES];
                [self.navigationController pushViewController:awardViewController animated:YES];
                
                //            int n = [award.awardType intValue];
                //
                //            if([award.awardType intValue] == 0){
                //
                //                [_awardList addObject:award];
                //
                //            }else if([award.awardType intValue] == 1){
                //                [_superAwardList addObject:award];
                //            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"请求数据错误！"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
        }
    }else{
    
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
        
        SelfTableViewController *selfTableViewController = [[SelfTableViewController alloc] initWithStyle:UITableViewStylePlain];
        
        [self.navigationController pushViewController:selfTableViewController animated:YES];
    }else{
        
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        
        [loginViewController set_redirectView:@"self"];
        
        [self.navigationController pushViewController:loginViewController animated:YES];
        
    }
    }
}

- (IBAction)showWithLabel:(id)sender {
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:_HUD];
	
	_HUD.delegate = self;
	_HUD.labelText = @"Loading";
	
	[_HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(3);
}

//-(void)requestFinished:(ASIHTTPRequest *)request{
//    
//    NSString *responseString = [request responseString];
//    
//    NSLog(@"responseString:%@",responseString);
//    
//    //NSData *responseData = [request responseData];
//    
//}
//
//-(void)requestFailed:(ASIHTTPRequest *)request{
//    NSError *error = [request error];
//    
//    NSLog(@"responseString:%@",error);
//}

-(void)about{
    NSLog(@"about");
    
    _aboutController = [[AboutViewController alloc] init];
    
    [self.navigationController pushViewController:_aboutController animated:YES];
}

-(void)login{
    NSLog(@"login");
    
    LoginViewController *loginController = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginController animated:YES];
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

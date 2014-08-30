//
//  NewSelfInfoViewController.m
//  zmkm
//
//  Created by lele126 on 14-8-25.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import "NewSelfInfoViewController.h"

@interface NewSelfInfoViewController ()

@end

@implementation NewSelfInfoViewController

@synthesize _tableView;

@synthesize _itemsArrays;

@synthesize _HUD;

@synthesize userNameLabel;

@synthesize userAccout;

@synthesize clickTimes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"个人中心";
        
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
        
        [rightButton setTitle:@"注销" forState:UIControlStateNormal];
        
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
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)goBack{

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MainViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}

-(void)logout{
    
    NSLog(@"注销");
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    
    [loginViewController set_redirectView:@"self"];
    
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *selfTop = [UIImage imageNamed:@"self_top"];
    
    UIImageView *selfTopView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 147)];
    
    [selfTopView setImage:selfTop];
    
    [self.view addSubview:selfTopView];
    
    UIImageView *awardView = [[UIImageView alloc] initWithFrame:CGRectMake(selfTopView.frame.origin.x, selfTopView.frame.size.height+selfTopView.frame.origin.y+5.0, self.view.frame.size.width, self.view.frame.size.height-selfTopView.frame.size.height-74)];
    
    [awardView setImage:[UIImage imageNamed:@"selfAward"]];
    
    [self.view addSubview:awardView];
    
    UIImage *peopleImg = [UIImage imageNamed:@"people_img.jpg"];
    
    UIImageView *peopleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(33.0, 38.0, 100.0, 83.0)];
    
    [peopleImageView setImage:peopleImg];
    
    [self.view addSubview:peopleImageView];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userKey = [NSString stringWithFormat:@"userId"];
    
    NSString *userId = [setting objectForKey:userKey];
    
    NSString *userAccount = [NSString stringWithFormat:@"userAccount"];
    
    NSString *userAccountValue = [setting objectForKey:userAccount];
    
    NSString *getUserAwardUrl = [NSString stringWithFormat:@"%@award/getUserAward?userId=%@",domainName,userId];
    
    NSLog(@"%@",getUserAwardUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getUserAwardUrl]];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
    
    [self showWithLabel];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(200.0, 43.0, 200, 20.0)];
    
    [self.userNameLabel setText:[NSString stringWithFormat:@"%@",userAccountValue]];
    
    [self.view addSubview:self.userNameLabel];
    
    self.userAccout = [[UILabel alloc] initWithFrame:CGRectMake(self.userNameLabel.frame.origin.x, self.userNameLabel.frame.size.height+self.userNameLabel.frame.origin.y+4, 200, 20.0)];
    
    [self.userAccout setText:@"0.0"];
    
    [self.view addSubview:self.userAccout];
    
    self.clickTimes = [[UILabel alloc] initWithFrame:CGRectMake(self.userNameLabel.frame.origin.x, self.userAccout.frame.size.height+self.userAccout.frame.origin.y+4, 200.0, 20.0)];
    
    [self.clickTimes setText:@"1"];
    
    [self.view addSubview:self.clickTimes];
    
     _itemsArrays = [[NSMutableArray alloc] init];
    
    if ([UIDevice isRunningOniPhone5]) {
    
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(awardView.frame.origin.x+11.0, awardView.frame.origin.y+57.0, awardView.frame.size.width-22.0, awardView.frame.size.height-82.0) style:UITableViewStylePlain];
        
    }else{
    
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(awardView.frame.origin.x+11.0, awardView.frame.origin.y+50.0, awardView.frame.size.width-22.0, awardView.frame.size.height-75.0) style:UITableViewStylePlain];
        
    }
    
   
    
    _tableView.delegate = self;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    // Do any additional setup after loading the view.
}

-(void)requestFinished:(ASIHTTPRequest *)request{

    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if ([codeData intValue] == 0) {
        NSDictionary *bodyData = [datas objectForKey:@"body"];
        
        NSNumber *number = [bodyData objectForKey:@"userAmount"];
        
        NSString *userAmount = [NSString stringWithFormat:@"%.1f元",[number floatValue]];
        
        [self.userAccout setText:userAmount];
        
        NSString *userAmountKey = [NSString stringWithFormat:@"userAmount"];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        [setting setObject: userAmount forKey:userAmountKey];
        
        [setting synchronize];
        
        NSArray *array = [bodyData objectForKey:@"userAward"];
        
        for (int i=0;i<array.count;i++) {
            
            NSDictionary *dictionary = [array objectAtIndex:i];
            
            Award *award = [[Award alloc] init];
            
            award.id = [dictionary objectForKey:@"id"];
            
            award.awardImage = [dictionary objectForKey:@"awardImage"];
            
            award.awardName = [dictionary objectForKey:@"awardName"];
            
            award.awardContent = [dictionary objectForKey:@"awardContent"];
            
            award.awardInfo = [dictionary objectForKey:@"awardInfo"];
            
            award.awardNumber = [dictionary objectForKey:@"awardNumber"];
            
            award.awardAddress = [dictionary objectForKey:@"awardAddress"];
            
            award.awardPhone = [dictionary objectForKey:@"awardPhone"];
            
            award.awardStart = [dictionary objectForKey:@"awardStart"];
            
            award.awardEnd = [dictionary objectForKey:@"awardEnd"];
            
            award.awardSecret = [dictionary objectForKey:@"awardSecret"];
            
            award.awardProvide = [dictionary objectForKey:@"awardProvide"];
            
            award.awardMap = [dictionary objectForKey:@"awardMap"];
            
            award.awardRate = [dictionary objectForKey:@"awardRate"];
            
            award.createTime = @"";
            
            award.updateTime = @"";
            
            award.awardType = [dictionary objectForKey:@"awardType"];
            
            [_itemsArrays addObject:award];
        }
        
        [self.clickTimes setText:[NSString stringWithFormat:@"%i",_itemsArrays.count]];
        
        [_tableView reloadData];
        
    }
}


- (void)showWithLabel {
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.navigationController.view addSubview:_HUD];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _itemsArrays.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"selfCell";
    
    Award *award = [_itemsArrays objectAtIndex:indexPath.row];
    
    SelfAwardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[SelfAwardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier withAward:award];
        
    }
    
    return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Award *award = [_itemsArrays objectAtIndex:indexPath.row];
    
    AwardDetailViewController *awardDetailViewController = [[AwardDetailViewController alloc] init];
    
    [awardDetailViewController setIndex:indexPath.row];
    
    awardDetailViewController.award = award;
    
    [awardDetailViewController setViewDelegate:self];
    
    [self.navigationController pushViewController:awardDetailViewController animated:YES];
    
}

-(void)removeAwardData:(NSInteger)index{

    [_itemsArrays removeObjectAtIndex:index];
    
    [_tableView reloadData];
    
}

@end

//
//  IntroductionTwoViewController.m
//  zmkm
//
//  Created by lele126 on 14-8-11.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import "IntroductionTwoViewController.h"

@interface IntroductionTwoViewController ()

@end

@implementation IntroductionTwoViewController

@synthesize _HUD;

@synthesize mainScrollView;

@synthesize _leadView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)loadView{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    UIView *mainView = [[UIView alloc] initWithFrame:rect];
    
    CGRect rectstatus = [[UIApplication sharedApplication] statusBarFrame];
    
    [mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background4s.png"]]];
    
    self.view = mainView;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _leadView = [[LeadScroll alloc] initWithFrame:self.view.frame];
    
    [_leadView setContentSize:CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height)];
    
    [_leadView set_leadDelegate:self];
    
    [self.view addSubview:_leadView];
    
    // Do any additional setup after loading the view.
}

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
        
        [self dismissViewControllerAnimated:YES completion:^{
        
            NSLog(@"dismmiss");
            
        }];
        
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

@end

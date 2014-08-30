//
//  UPViewController.m
//  UPPayDemo
//
//  Created by liwang on 12-11-12.
//  Copyright (c) 2012年 liwang. All rights reserved.
//
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "UPViewController.h"
#import "UPPayPlugin.h"

#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80

#define kVCTitle          @"TN测试"
#define kBtnFirstTitle    @"获取订单，开始测试"
#define kWaiting          @"正在获取订单号,请稍后..."
#define kNote             @"提示"         
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


#define kMode             @"01"
#define kConfigTnUrl      @"http://222.66.233.198:8080/sim/app.jsp?user=%@"
#define kNormalTnUrl      @"http://222.66.233.198:8080/sim/gettn"
//120.204.69.167:10306
//222.66.233.198:8080
//172.17.254.198:10306

@interface UPViewController ()

@end

@implementation UPViewController
@synthesize mode;
@synthesize tnURL;
@synthesize configURL;
@synthesize amount;
@synthesize tn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"账户充值";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [self.navigationItem setLeftBarButtonItem:leftItem];       
        
    }
    return self;
}


- (void)dealloc
{
    self.mode = nil;
    self.tnURL = nil;
    self.configURL = nil;
    
    [super dealloc];
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
    
    //self.title = kVCTitle;
    self.mode = @"00";
    
//    self.tnURL = @"http://222.66.233.198:8080/sim/gettn";
    
    self.configURL = @"http://222.66.233.198:8080/sim/app.jsp?user=123456789";
    
    self.tnURL = @"http://bswlkj.gotoip55.com/order/getIphoneOrderInfo";
    
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add the normalTn button
    
    UIButton *orderAmount1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount1 setTitle:@"1元" forState:UIControlStateNormal];
    
    [orderAmount1 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount1 setFrame:CGRectMake(4.0, 20.0, 101.0, 33.0)];
    
    [orderAmount1 setTag:501];
    
    [orderAmount1 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount1];
    
    UIButton *orderAmount2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount2 setTitle:@"2元" forState:UIControlStateNormal];
    
    [orderAmount2 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount2 setFrame:CGRectMake(4.0+orderAmount1.frame.origin.x+orderAmount1.frame.size.width, orderAmount1.frame.origin.y, 101.0, 33.0)];
    
    [orderAmount2 setTag:502];
    
    [orderAmount2 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount2];
    
    UIButton *orderAmount3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount3 setTitle:@"5元" forState:UIControlStateNormal];
    
    [orderAmount3 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount3 setFrame:CGRectMake(4.0+orderAmount2.frame.origin.x+orderAmount2.frame.size.width, orderAmount2.frame.origin.y, 101.0, 33.0)];
    
    [orderAmount3 setTag:503];
    
    [orderAmount3 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount3];
    
    UIButton *orderAmount4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount4 setTitle:@"8元" forState:UIControlStateNormal];
    
    [orderAmount4 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount4 setFrame:CGRectMake(orderAmount1.frame.origin.x, orderAmount1.frame.origin.y+orderAmount1.frame.size.height+20.0, 101.0, 33.0)];
    
    [orderAmount4 setTag:504];
    
    [orderAmount4 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount4];
    
    UIButton *orderAmount5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount5 setTitle:@"10元" forState:UIControlStateNormal];
    
    [orderAmount5 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount5 setFrame:CGRectMake(4.0+orderAmount4.frame.origin.x+orderAmount4.frame.size.width, orderAmount4.frame.origin.y, 101.0, 33.0)];
    
    [orderAmount5 setTag:505];
    
    [orderAmount5 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount5];
    
    UIButton *orderAmount6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [orderAmount6 setTitle:@"20元" forState:UIControlStateNormal];
    
    [orderAmount6 setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
    
    [orderAmount6 setFrame:CGRectMake(4.0+orderAmount5.frame.origin.x+orderAmount5.frame.size.width, orderAmount5.frame.origin.y, 101.0, 33.0)];
    
    [orderAmount6 setTag:506];
    
    [orderAmount6 addTarget:self action:@selector(getAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:orderAmount6];
    
    CGFloat y = KYOffSet+50.0;
    UIButton* btnStartPay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[btnStartPay setTitle:kBtnFirstTitle forState:UIControlStateNormal];
    [btnStartPay addTarget:self action:@selector(normalPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnStartPay setFrame:CGRectMake((self.view.frame.size.width-199.0)/2, y, 199.0, 41.0)];
    
    [btnStartPay setTag:507];
    
     [btnStartPay setBackgroundImage:[UIImage imageNamed:@"orderSubmit"] forState:UIControlStateNormal];
    
    [self.view addSubview:btnStartPay];
    y += KBtn_height + KYOffSet;
    
    // Add the configTn button
    
    UIButton* btnConfig = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnConfig setTitle:@"配置自定义用户：123456789" forState:UIControlStateNormal];
    [btnConfig addTarget:self action:@selector(userPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnConfig setFrame:CGRectMake(KXOffSet, y, KBtn_width, KBtn_height)];
    //[self.view addSubview:btnConfig];
    
}

-(void)getAmount:(id)sender{

    UIButton *amountButton = (UIButton *)sender;

    if(amountButton.tag == 501){
        self.amount = [NSString stringWithFormat:@"%d",1];
    }else if (amountButton.tag == 502){
        self.amount = [NSString stringWithFormat:@"%d",2];
    }else if (amountButton.tag == 503){
        self.amount = [NSString stringWithFormat:@"%d",5];
    }else if (amountButton.tag == 504){
        self.amount = [NSString stringWithFormat:@"%d",8];
    }else if (amountButton.tag == 505){
        self.amount = [NSString stringWithFormat:@"%d",10];
    }else if (amountButton.tag == 506){
        self.amount = [NSString stringWithFormat:@"%d",20];
    }
    
    for (UIView *view:[self.view subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            
            if(button.tag == 507){
                
            }else{
            
                [button setBackgroundImage:[UIImage imageNamed:@"unOrder"] forState:UIControlStateNormal];
            }
        }
    }
    
    [amountButton setBackgroundImage:[UIImage imageNamed:@"order"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Alert

- (void)showAlertWait
{
    mAlert = [[UIAlertView alloc] initWithTitle:kWaiting message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [mAlert show];
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(mAlert.frame.size.width / 2.0f - 15, mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    [mAlert addSubview:aiv];
    [aiv release];
    [mAlert release];
}

- (void)showAlertMessage:(NSString*)msg
{
    mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [mAlert show];
    [mAlert release];
}
- (void)hideAlert
{
    if (mAlert != nil)
    {
        [mAlert dismissWithClickedButtonIndex:0 animated:YES];
        mAlert = nil;
    }
}

#pragma mark - UPPayPlugin Test


- (void)userPayAction:(id)sender
{
    if (![self.mode isEqualToString:@"00"])
    {
    NSURL* url = [NSURL URLWithString:self.configURL];
	NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
    [self showAlertWait];
    }
}


- (void)normalPayAction:(id)sender
{
    
    if(self.amount == NULL){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择充值金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
    
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        NSString *key = [NSString stringWithFormat:@"userId"];
        
        NSString *userId = [setting objectForKey:key];
        
        NSLog(@"userId%@",userId);
        
        NSString *urlTn = [NSString stringWithFormat:@"%@?userId=%@&orderAmount=%@",self.tnURL,userId,self.amount];
        
        NSLog(@"urlTn%@",urlTn);
        
        if ([self.mode isEqualToString:@"00"]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"重要提示" message:@"您现在即将进行的是一笔真实的消费,消费金额0.01元,点击确定开始支付." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            [alertView show];
//            [alertView release];
            NSURL* url = [NSURL URLWithString:urlTn];
            NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
            NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            [urlConn start];
            [self showAlertWait];
        }
        else
        {
            NSURL* url = [NSURL URLWithString:urlTn];
            NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
            NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
            [urlConn start];
            [self showAlertWait];
        }
    
    }
    
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSLog(@"%@",response);
    int code = [rsp statusCode];
    if (code != 200)
    {
        [self hideAlert];
        [self showAlertMessage:kErrorNet];
        [connection cancel];
        [connection release];
        connection = nil;
    }
    else
    {
        if (mData != nil)
        {
            [mData release];
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self hideAlert];
//    NSString *data = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
//    
//    NSDictionary *dataDictionary = [data objectFromJSONString];
//    
//    NSDictionary *bodyData = [dataDictionary objectForKey:@"body"];
//    
//    sleep(3);
//    NSLog(@"tn=%@",[bodyData objectForKey:@"tn"]);
//    NSString *str=[bodyData objectForKey:@"tn"];
//    
//    NSString *tn = [NSString stringWithFormat:@"%@",[bodyData objectForKey:@"tn"]];
    
    NSString *tnStr = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    
    if (tnStr != nil && tnStr.length > 0)
    {
        NSLog(@"tn=%@",tnStr);
        
        self.tn = tnStr;
        
        [UPPayPlugin startPay:self.tn mode:self.mode viewController:self delegate:self];
    }
    [tn release];
    [connection release];
    connection = nil;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self hideAlert];
    [self showAlertMessage:kErrorNet];
    [connection release];
    connection = nil;
}





- (void)UPPayPluginResult:(NSString *)result
{
    if([result isEqualToString:@"success"]){
        NSString *updateUrl = [NSString stringWithFormat:@"http://bswlkj.gotoip55.com/order/updateOrderStatus?tn=%@",self.tn];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:updateUrl]];
        
        [request setDelegate:self];
        
        [request startSynchronous];
        
    }else{
    
        NSString* msg = [NSString stringWithFormat:kResult, @"支付失败"];
        [self showAlertMessage:msg];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if ([codeData intValue] == 0) {
        
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MotionViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        
    }
}

- (void)segmanetDidSelected:(UISegmentedControl *)segment
{
    // development
    if (segment.selectedSegmentIndex == 0) {
        self.mode = @"01";
        self.tnURL = @"http://222.66.233.198:8080/sim/gettn";
        self.configURL = @"http://222.66.233.198:8080/sim/app.jsp?user=123456789";
    }
    
    // testment
    if (segment.selectedSegmentIndex == 1) {
        self.mode = @"02";
        self.tnURL = @"http://120.204.69.167:10306/sim/gettn";
        self.configURL = @"http://120.204.69.167:10306/sim/app.jsp?user=123456789";
    }
    
    // productment
    if (segment.selectedSegmentIndex == 2) {
        self.mode = @"00";
        self.tnURL = @"https://202.96.255.146/sim/gettn";
        self.configURL = @"";
    }
}

-(void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL* url = [NSURL URLWithString:self.tnURL];
        NSMutableURLRequest * urlRequest=[NSMutableURLRequest requestWithURL:url];
        NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        [urlConn start];
        [self showAlertWait];
    }
}

@end

//
//  AwardInfoView.m
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "AwardInfoView.h"

@implementation AwardInfoView

@synthesize _awardScrollView;

@synthesize _itemsArray;

@synthesize dialog;

@synthesize _HUD;

@synthesize reloadViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor colorWithRed:135.0/255.0 green:184.0/255.0 blue:115.0/255.0 alpha:1.0]];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    _itemsArray = [NSMutableArray array];
    
    self.dialog = [CODialog dialogWithWindow:self.window];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    
    NSString *userKey = [NSString stringWithFormat:@"userId"];
    
    NSString *userId = [setting objectForKey:userKey];
    
    NSString *getUserAwardUrl = [NSString stringWithFormat:@"%@award/getUserAward?userId=%@",domainName,userId];
    
    NSLog(@"%@",getUserAwardUrl);

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getUserAwardUrl]];
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
//    _HUD = [[MBProgressHUD alloc] initWithView:self];
//    
//    [self addSubview:_HUD];
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
//    }];
    
    _awardScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    int count = ceil(_itemsArray.count/3+0.2);
    
    if(count == 0){
        
        if(_itemsArray.count>0){
            
            count = 1;
        
        }
        
    }
    
    [_awardScrollView setContentSize:CGSizeMake(self.frame.size.width, count*80)];
    
    int width = (self.frame.size.width-6)/3;
    
    float y = 2.0;
    
    int index = 0;
    
    if (_itemsArray.count==0) {
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 40.0)];
        
        [infoLabel setText:@"您还没有奖品!"];
        
        [infoLabel setCenter:self.center];
        
        [_awardScrollView addSubview:infoLabel];
    }else{
        for (int i=0; i<count; i++) {
            
            float x = 7.0;
            
            for (int m=0; m<3; m++) {
                
                if(index>_itemsArray.count-1){
                    break;
                }
                
                Award *award = [_itemsArray objectAtIndex:index];
                
                NSString *imageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
                
                UIImageView *viewItems = [[UIImageView alloc] init];
                
                [viewItems setImageWithURL:[NSURL URLWithString:imageUrl]
                          placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"userAwardBigImage%d.png",i]]];
                
                [viewItems setFrame:CGRectMake(x, y, width-4.0, 80.0-4.0)];
                
                [viewItems setTag:index];
                
                viewItems.userInteractionEnabled=YES;
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
                
                [viewItems addGestureRecognizer:singleTap];
                
                [_awardScrollView addSubview:viewItems];
                
                index++;
                
                x+=width;
            }
            
            y+=80.0;
        }
        
        //320*255
    }
    [self addSubview:_awardScrollView];

}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
    if(request.tag == 3000){
        [self.dialog hideAnimated:NO];
        
        [self.reloadViewDelegate reloadView];
    }else{
    
    if ([codeData intValue] == 0) {
        
        NSDictionary *bodyData = [datas objectForKey:@"body"];
        
        NSString *userAmount = [bodyData objectForKey:@"userAmount"];
        
        NSString *userAmountKey = [NSString stringWithFormat:@"userAmount"];
        
        NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
        
        [setting setObject: userAmount forKey:userAmountKey];
        
        [setting synchronize];

        
        NSArray *awardList = [bodyData objectForKey:@"userAward"];
        
        for (int i=0;i<awardList.count;i++ ) {
            
            NSLog(@"award%@",[awardList objectAtIndex:i]);
            
            NSDictionary *awardData = [awardList objectAtIndex:i];
                
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
                
                [_itemsArray addObject:award];
        }
        
    }
    }
}

-(void)onClickImage:(UITapGestureRecognizer *)gestureRecognizer{
//    // here, do whatever you wantto do
    NSLog(@"imageview is clicked!");
//
//    UIImageView *view = (UIImageView *)gestureRecognizer.view;
//    UIImageView *alertView = [[UIImageView alloc] init];
//    
//    NSLog(@"%d",view.tag);
//    
//    Award *award = [_itemsArray objectAtIndex:view.tag];
//    
//    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
//    //
//    NSString *awardIdKey = [NSString stringWithFormat:@"awardId"];
//    
//    [setting setObject:award.id forKey:awardIdKey];
//    ////
//    [setting synchronize];
//    
//    [self.dialog resetLayout];
//    
//    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
//    
//    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    
//    NSString *domainName=[data objectForKey:@"domainName"];
//    
//    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
//    
//    [alertView setImageWithURL:[NSURL URLWithString:imageUrl]
//              placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"userAwardBigImage%d.png",view.tag]]];
//    
//    alertView.frame = CGRectMake(0, 0, 128, 128);
//    
//    self.dialog.title = award.awardNumber;
////    self.dialog.subtitle = @"Hi!";
//    self.dialog.dialogStyle = CODialogStyleCustomView;
//    self.dialog.customView = alertView;
//    
//    [self.dialog addButtonWithTitle:@"删除" target:self selector:@selector(showSuccess:)];
//    [self.dialog addButtonWithTitle:@"取消" target:self selector:@selector(hideAndShow:) highlighted:YES];
//    [self.dialog showOrUpdateAnimated:YES];
    
    UIImageView *view = (UIImageView *)gestureRecognizer.view;
    
    Award *award = [_itemsArray objectAtIndex:view.tag];
    
    [self.reloadViewDelegate showAwardDetail:award];
}

- (void)hideAndShow:(id)sender {
    [self.dialog hideAnimated:NO];
}

- (void)showSuccess:(id)sender {
    NSLog(@"success");

    NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    NSString *domainName=[data objectForKey:@"domainName"];
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    //
    NSString *userIdKey = [NSString stringWithFormat:@"userId"];
    //
    NSString *userId = [setting objectForKey:userIdKey];

    NSString *awardIdKey = [NSString stringWithFormat:@"awardId"];
    
    NSString *awardId = [setting objectForKey:awardIdKey];
    
    NSString *deleteUrl = [NSString stringWithFormat:@"%@user/deleteAward?userId=%@&awardId=%@",domainName,userId,awardId];
    
    NSLog(@"%@",deleteUrl);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:deleteUrl]];
    
    request.tag=3000;
    
    [request setDelegate:self];
    
    [request startSynchronous];
    
}

@end

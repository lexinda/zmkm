//
//  PeopleInfoCell.m
//  zmkm
//
//  Created by zhumengle on 14-5-5.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "PeopleInfoCell.h"

@implementation PeopleInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
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
        
        NSString *userName = [NSString stringWithFormat:@"userName"];
        
        NSString *userGender = [NSString stringWithFormat:@"userGender"];
        
        NSString *userPhone = [NSString stringWithFormat:@"userPhone"];
        
        NSString *userEmail = [NSString stringWithFormat:@"userEmail"];
        
        NSString *userAccount = [NSString stringWithFormat:@"userAccount"];
        
        NSString *userAmount = [NSString stringWithFormat:@"userAmount"];
        
        NSString *userAmountValue = [setting objectForKey:@"userAmount"];
        
        NSString *userNameValue = [setting objectForKey:userName];
        
        NSString *userAccountvalue = [setting objectForKey:userAccount];
        
        NSString *userGenderValue = [setting objectForKey:userGender];
        
        NSString *userPhoneValue = [setting objectForKey:userPhone];
        
        NSString *userEmailValue = [setting objectForKey:userEmail];
        
        UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 50.0, 20.0)];
        
        [amountLabel setText:@"余额:"];
        
        UILabel *amountLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(amountLabel.frame.size.width, 0.0, 100.0, 20.0)];
        
        [amountLabel1 setTextColor:[UIColor redColor]];
        
        if (userAccountvalue == NULL) {
            [amountLabel1 setText:[NSString stringWithFormat:@"%d",0]];
        }else{
            [amountLabel1 setText:[NSString stringWithFormat:@"%@",userAmountValue]];
        }
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, amountLabel.frame.size.height+amountLabel.frame.origin.y, 50.0, 20.0)];
        
        [userLabel setText:@"账号:"];
        
        UILabel *userLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(userLabel.frame.size.width, userLabel.frame.origin.y, 100.0, 20.0)];
        
        [userLabel1 setText:[NSString stringWithFormat:@"%@",userAccountvalue]];
        
        UILabel *saxLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, userLabel.frame.size.height+userLabel.frame.origin.y, 50.0, 20.0)];
        
        [saxLabel setText:@"性别:"];
        
        UILabel *saxLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(saxLabel.frame.size.width, saxLabel.frame.origin.y, 100.0, 20.0)];
        
        [saxLabel1 setText:[NSString stringWithFormat:@"%@",userGenderValue]];
        
        UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, saxLabel.frame.size.height+saxLabel.frame.origin.y, 50.0, 20.0)];
        
        [phoneLabel setText:@"手机:"];
        
        UILabel *phoneLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.frame.size.width, phoneLabel.frame.origin.y, 150.0, 20.0)];
        
        [phoneLabel1 setText:[NSString stringWithFormat:@"%@",userPhoneValue]];
        
        UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, phoneLabel.frame.size.height+phoneLabel.frame.origin.y, 50.0, 20.0)];
        
        [emailLabel setText:@"邮箱:"];
        
        UILabel *emailLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(emailLabel.frame.size.width, emailLabel.frame.origin.y, 250.0, 20.0)];
        
        [emailLabel1 setText:[NSString stringWithFormat:@"%@",userEmailValue]];
        
        [self addSubview:amountLabel];
        
        [self addSubview:amountLabel1];
        
        [self addSubview:userLabel];
        
        [self addSubview:userLabel1];
        
//        [self addSubview:saxLabel];
//        
//        [self addSubview:saxLabel1];
//        
//        [self addSubview:phoneLabel];
//        
//        [self addSubview:phoneLabel1];
//        
//        [self addSubview:emailLabel];
//        
//        [self addSubview:emailLabel1];
        
        
        
    }
    return self;
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    
    NSString *responseString = [request responseString];
    
    NSLog(@"%@",responseString);
    
    NSDictionary *datas = [responseString objectFromJSONString];
    
    NSNumber *codeData = [datas objectForKey:@"code"];
    
        if ([codeData intValue] == 0) {
            
            NSDictionary *bodyData = [datas objectForKey:@"body"];
            
            NSString *userAmount = [bodyData objectForKey:@"userAmount"];
            
            NSString *userAmountKey = [NSString stringWithFormat:@"userAmount"];
            
            NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
            
            [setting setObject: userAmount forKey:userAmountKey];
            
            [setting synchronize];
            
            
    }
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

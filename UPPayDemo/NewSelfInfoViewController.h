//
//  NewSelfInfoViewController.h
//  zmkm
//
//  Created by lele126 on 14-8-25.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainViewController.h"

#import "UIDevice+Resolutions.h"

#import "SelfAwardTableViewCell.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "AwardDetailViewController.h"

#import "MBProgressHUD.h"

#import "LoginViewController.h"

@interface NewSelfInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,MBProgressHUDDelegate,InputViewDelegate>

@property(strong,nonatomic)UITableView *_tableView;

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)NSMutableArray *_itemsArrays;

@property(strong,nonatomic)UILabel *userNameLabel;

@property(strong,nonatomic)UILabel *userAccout;

@property(strong,nonatomic)UILabel *clickTimes;

@end

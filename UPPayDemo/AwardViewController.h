//
//  AwardViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-2.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AwardViewController.h"

#import "LoginViewController.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "MBProgressHUD.h"

#import "Award.h"

#import "UIImageView+WebCache.h"

#import "UPViewController.h"

#import <AddressBookUI/AddressBookUI.h>

#import "UIDevice+Resolutions.h"

#import <MessageUI/MessageUI.h>

#import <AddressBookUI/AddressBookUI.h>

@interface AwardViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate,MBProgressHUDDelegate,MFMessageComposeViewControllerDelegate>

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)NSMutableArray *_awardList;

@property(strong,nonatomic)Award *award;

@property(strong,nonatomic)UIImageView *awardImageView;

@property(strong,nonatomic)UILabel *shopLabel;

@property(strong,nonatomic)UILabel *twoLabel;

@property(strong,nonatomic)UILabel *threeLabel;

@property(strong,nonatomic)UILabel *fourLabel;

@property(strong,nonatomic)UILabel *fiveLabel;

@property(strong,nonatomic)UILabel *sixLabel;

@property(strong,nonatomic)UILabel *sivenLabel;

@property(strong,nonatomic)NSString *appAddress;

@end

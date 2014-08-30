//
//  AwardContentViewController.h
//  zmkm
//
//  Created by zhumengle on 14-6-14.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginViewController.h"

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "MBProgressHUD.h"

#import "Award.h"

#import "UIImageView+WebCache.h"

#import "UPViewController.h"

#import "UIDevice+Resolutions.h"

#import <AddressBookUI/AddressBookUI.h>

#import "myUILabel.h"

#import <MessageUI/MessageUI.h>

@interface AwardContentViewController : UIViewController<MFMessageComposeViewControllerDelegate>

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)NSMutableArray *_awardList;

@property(strong,nonatomic)Award *award;

@property(strong,nonatomic)UIButton *_motionButton;

@property(strong,nonatomic)NSString *appAddress;
@end

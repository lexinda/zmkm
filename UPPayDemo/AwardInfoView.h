//
//  AwardInfoView.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

#import "JSONKit.h"

#import "MBProgressHUD.h"

#import "UIImageView+WebCache.h"

#import "Award.h"

#import "CODialog.h"

#import "reloadView.h"

@interface AwardInfoView : UIView

@property(strong,nonatomic)UIScrollView *_awardScrollView;

@property(strong,nonatomic)NSMutableArray *_itemsArray;

@property(strong,nonatomic)MBProgressHUD *_HUD;

@property(strong,nonatomic)CODialog *dialog;

@property(strong,nonatomic)id<reloadView> reloadViewDelegate;

@end

//
//  testview.h
//  zmkm
//
//  Created by zhumengle on 14-6-1.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Award.h"

#import "UIImageView+WebCache.h"

#import "reloadView.h"

@interface testview : UIView

@property(strong,nonatomic)UIScrollView *testView;

@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic)id<reloadView> delegateImage;

@end

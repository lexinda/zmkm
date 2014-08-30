//
//  AwardView.h
//  zmkm
//
//  Created by zhumengle on 14-5-2.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

#import "UIImageView+WebCache.h"

#import "Award.h"

#import "testview.h"

@interface AwardView : UIView<ASIHTTPRequestDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)NSMutableArray *_imageArray;

@property(strong,nonatomic)NSMutableArray *_supperImageArray;

@property(strong,nonatomic)UIScrollView *_smallView;

@property(strong,nonatomic)UIScrollView *_supperSmallView;

@property(nonatomic)int _timeCount;

@end

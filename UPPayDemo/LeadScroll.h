//
//  LeadScroll.h
//  zmkm
//
//  Created by lele126 on 14-8-24.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputViewDelegate.h"

@interface LeadScroll : UIScrollView<UIScrollViewDelegate>

@property(nonatomic)NSInteger _index;

@property(strong,nonatomic)NSTimer *timer;

@property(strong,nonatomic)id<InputViewDelegate> _leadDelegate;

@end

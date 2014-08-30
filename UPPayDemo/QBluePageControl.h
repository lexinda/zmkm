//
//  QBluePageControl.h
//  zmkm
//
//  Created by zhumengle on 14-5-2.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBluePageControl : UIPageControl

@property(strong,nonatomic)UIImage *_activeImage;

@property(strong,nonatomic)UIImage *_inactiveImage;

-(void)updateDots;

@end

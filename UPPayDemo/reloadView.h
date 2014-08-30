//
//  reloadView.h
//  zmkm
//
//  Created by zhumengle on 14-5-25.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol reloadView <NSObject>

-(void)reloadView;

-(void)showAwardInfo:(int)id;

-(void)showAwardDetail:(Award *)award;

@end

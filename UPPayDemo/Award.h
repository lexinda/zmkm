//
//  Award.h
//  zmkm
//
//  Created by zhumengle on 14-5-11.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Award : NSObject

@property(strong,nonatomic)NSNumber *id;

@property(strong,nonatomic)NSString *awardImage;

@property(strong,nonatomic)NSString *awardName;

@property(strong,nonatomic)NSString *awardContent;

@property(strong,nonatomic)NSString *awardInfo;

@property(strong,nonatomic)NSString *awardNumber;

@property(strong,nonatomic)NSString *awardAddress;

@property(strong,nonatomic)NSString *awardPhone;

@property(strong,nonatomic)NSString *awardStart;

@property(strong,nonatomic)NSString *awardEnd;

@property(strong,nonatomic)NSString *awardSecret;

@property(strong,nonatomic)NSString *awardProvide;

@property(strong,nonatomic)NSString *awardMap;

@property(strong,nonatomic)NSNumber *awardRate;

@property(strong,nonatomic)NSString *createTime;

@property(strong,nonatomic)NSString *updateTime;

@property(strong,nonatomic)NSNumber *awardType;


@end

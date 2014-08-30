//
//  User.h
//  zmkm
//
//  Created by zhumengle on 14-5-17.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(strong,nonatomic)NSNumber *id;

@property(strong,nonatomic)NSString *userAccount;

@property(strong,nonatomic)NSString *userPassword;

@property(strong,nonatomic)NSString *userName;

@property(strong,nonatomic)NSString *userGender;

@property(strong,nonatomic)NSString *userPhone;

@property(strong,nonatomic)NSString *userEmail;

@property(strong,nonatomic)NSDate *createTime;

@property(strong,nonatomic)NSDate *updateTime;

@end

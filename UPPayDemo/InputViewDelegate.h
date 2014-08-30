//
//  InputViewDelegate.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InputViewDelegate <NSObject>

-(void)upInputView:(UITextField *)textField;

-(void)downInputView:(UITextField *)textField;

-(void)userLogin:(NSString *)userName
    userPassword:(NSString *)userPassword;

-(void)userRegister:(NSString *)accountStr
           password:(NSString *)passwordStr
      passwordAgain:(NSString *)passwordAgainStr
           userName:(NSString *)userName
             gender:(NSString *)gender
              phone:(NSString *)userPhone
              email:(NSString *)email;

-(void)userModify:(NSNumber *)userId
         userName:(NSString *)userName
             gender:(NSString *)gender
              phone:(NSString *)userPhone
              email:(NSString *)email;

-(void)userPasswordModify:(NSString *)userPassword
         newUserPassword:(NSString *)newUserPassword;

-(void)pushModifyView;

-(void)pushModifyPasswordView;

-(void)redirectLeadView;

-(void)redirectRegView;

-(void)removeAwardData:(NSInteger)index;

@end

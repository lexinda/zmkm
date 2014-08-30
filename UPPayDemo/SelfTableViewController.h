//
//  SelfTableViewController.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewCell.h"

#import "TreeViewNode.h"

#import "AwardInfoCell.h"

#import "PeopleInfoCell.h"

#import "PeoplePasswordCell.h"

#import "User.h"

#import "ModifyUserInfoViewController.h"

#import "NewAwardViewController.h"

#import "ModifyUserPasswordViewController.h"

#import "reloadView.h"

#import "AwardDetailViewController.h"

@interface SelfTableViewController : UITableViewController<InputViewDelegate,reloadView>

@property(nonatomic) NSUInteger indentation;

@property(strong,nonatomic)NSArray *nodes;

@property(strong,nonatomic)NSMutableArray *displayArray;

-(void)excpandCollapseNode:(NSNotification *)notification;

@property(nonatomic)float _prewMoveY;

@property(nonatomic)int _preTag;

-(void)fillDisplayArray;

-(void)fillNodeWithChildrenArray:(NSArray *)childrenArray;

-(void)fillNodesArray;

-(NSArray *)fillChildrenForNode;

-(void)excpandAll:(id)sender;

-(void)collapseAll:(id)sender;

@end

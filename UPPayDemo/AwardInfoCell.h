//
//  AwardInfoCell.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AwardInfoView.h"

#import "TreeViewNode.h"

#import "reloadView.h"

#import "reloadView.h"

@interface AwardInfoCell : UITableViewCell<reloadView>

@property (retain, strong) TreeViewNode *treeNode;

@property(strong,nonatomic)id<reloadView> reloadAwardDelegate;

@end

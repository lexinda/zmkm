//
//  TableViewCell.h
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TreeViewNode.h"

#import "InputViewDelegate.h"

@interface TableViewCell : UITableViewCell

@property (retain, nonatomic)UILabel *cellLabel;

@property (retain, nonatomic)UIButton *cellButton;

@property (retain, strong) TreeViewNode *treeNode;

@property (nonatomic) BOOL isExpanded;

- (void)expand:(id)sender;

- (void)setTheButtonBackgroundImage:(UIImage *)backgroundImage;

@property(strong,nonatomic)id<InputViewDelegate> _inputViewDelegate;

@end

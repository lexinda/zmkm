//
//  SelfAwardTableViewCell.h
//  zmkm
//
//  Created by lele126 on 14-8-25.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Award.h"

#import "UIImageView+WebCache.h"

@interface SelfAwardTableViewCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAward:(Award *)award;

@end

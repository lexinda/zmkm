//
//  AwardInfoCell.m
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "AwardInfoCell.h"

@implementation AwardInfoCell

@synthesize reloadAwardDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        AwardInfoView *awardInfoView = [[AwardInfoView alloc] init];
        
        [awardInfoView setFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 190)];
        
        [awardInfoView setReloadViewDelegate:self];
        
        [self addSubview:awardInfoView];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    AwardInfoView *awardInfoView = [[AwardInfoView alloc] init];
    
    [awardInfoView setFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 190.0)];
    
    [awardInfoView setReloadViewDelegate:self];
    
    [self addSubview:awardInfoView];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadView{
    
    [self setNeedsDisplay];
}

-(void)showAwardDetail:(Award *)award{
    [self.reloadAwardDelegate showAwardDetail:award];
}

@end

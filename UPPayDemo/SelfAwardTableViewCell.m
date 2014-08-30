//
//  SelfAwardTableViewCell.m
//  zmkm
//
//  Created by lele126 on 14-8-25.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import "SelfAwardTableViewCell.h"

@implementation SelfAwardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withAward:(Award *)award
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIImage *image = [UIImage imageNamed:@"award_bg"];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 0.0, 42, 42)];
        
        [imageView setImage:image];
        
        [self addSubview:imageView];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        
        NSString *smllImageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
        
        UIImageView *webImageView = [[UIImageView alloc] init];
        
        [webImageView setImageWithURL:[NSURL URLWithString:smllImageUrl]
                     placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"awardImage.png"]]];
        
        [webImageView setFrame:CGRectMake(imageView.frame.origin.x+1, imageView.frame.origin.y+1, imageView.frame.size.width-2, imageView.frame.size.height-2)];

        [self addSubview:webImageView];
        
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.size.width+30.0, 1.0, 200.0, 13.0)];
        
        [topLabel setText:[NSString stringWithFormat:@"名称：%@",award.awardName]];
        
        [topLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        
        [self addSubview:topLabel];
        
        UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, topLabel.frame.origin.y+topLabel.frame.size.height+1.0, 200.0, 13.0)];
        
        [centerLabel setText:[NSString stringWithFormat:@"来源：%@",award.awardProvide]];
        
        [centerLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        
        [self addSubview:centerLabel];
        
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, centerLabel.frame.size.height+centerLabel.frame.origin.y+1.0, 200.0, 13.0)];
        
        [bottomLabel setText:[NSString stringWithFormat:@"日期：%@",award.awardEnd]];
        
        [bottomLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0]];
        
        [self addSubview:bottomLabel];
        
        UIImage *sepearate = [UIImage imageNamed:@"self_sepearte"];
        
        UIImageView *sepearateView = [[UIImageView alloc] initWithFrame:CGRectMake(topLabel.frame.origin.x, bottomLabel.frame.size.height+bottomLabel.frame.origin.y, 209.0, 1.0)];
        
        [sepearateView setImage:sepearate];
        
        [self addSubview:sepearateView];
        
    }
    return self;
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

@end

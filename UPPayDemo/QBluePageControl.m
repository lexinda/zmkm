//
//  QBluePageControl.m
//  zmkm
//
//  Created by zhumengle on 14-5-2.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "QBluePageControl.h"

@implementation QBluePageControl

@synthesize _activeImage;

@synthesize _inactiveImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _activeImage = [UIImage imageNamed:@"6"];
        
        _inactiveImage = [UIImage imageNamed:@"7"];
        
    }
    return self;
}

-(void)updateDots{

    for (int i=0; i<[self.subviews count]; i++) {
        
        UIView *dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            
            [dot setBackgroundColor:[UIColor colorWithPatternImage:_activeImage]];
            
        }else{
            
            [dot setBackgroundColor:[UIColor colorWithPatternImage:_inactiveImage]];
            
        }
        
    }
    
}

-(void)setCurrentPage:(NSInteger)currentPage{
    
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

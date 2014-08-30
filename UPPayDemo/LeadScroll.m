//
//  LeadScroll.m
//  zmkm
//
//  Created by lele126 on 14-8-24.
//  Copyright (c) 2014年 lele126. All rights reserved.
//

#import "LeadScroll.h"

@implementation LeadScroll

@synthesize _index;

@synthesize timer;

@synthesize _leadDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _index = 0;
        
        UIImage *lead1 = [UIImage imageNamed:@"lead1.jpg"];
        
        UIImageView *lead1View;
        
        lead1View = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        
        [lead1View setImage:lead1];
        
        [self addSubview:lead1View];
        
        UIImage *lead2 = [UIImage imageNamed:@"lead2.jpg"];
        
        UIImageView *lead2View = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        
        [lead2View setImage:lead2];
        
        [self addSubview:lead2View];
        
        UIImage *lead3 = [UIImage imageNamed:@"lead3.jpg"];
        
        UIImageView *lead3View = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*2, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        
        [lead3View setImage:lead3];
        
        [self addSubview:lead3View];
        
        self.pagingEnabled = YES;
        
        self.delegate = self;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)changeView{
    
    if(_index==0){
        
        [self setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    }
    if (_index==1) {
        
        [self setContentOffset:CGPointMake(320.0, 0.0) animated:YES];
    }
    if (_index==2) {
        
        [self setContentOffset:CGPointMake(640.0, 0.0) animated:YES];
        
        [self.timer invalidate];
    }
    
    _index++;
    
    if (_index>2) {
        _index=0;
    }
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    
    
    CGPoint point = scrollView.contentOffset;
    
    _index = point.x/320;
    
    if (_index==2) {
    
        [_leadDelegate redirectLeadView];
    
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    
    _index = point.x/320;
    
    if(_index==0){
        
        [self setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
    }
    if (_index==1) {
        
        [self setContentOffset:CGPointMake(320.0, 0.0) animated:YES];
    }
    if (_index==2) {
        
        [self setContentOffset:CGPointMake(640.0, 0.0) animated:YES];
        
        [_leadDelegate redirectLeadView];
    }

}

@end

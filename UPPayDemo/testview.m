//
//  testview.m
//  zmkm
//
//  Created by zhumengle on 14-6-1.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "testview.h"

@implementation testview

@synthesize testView;

@synthesize dataArray;

@synthesize delegateImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.testView =[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    
    [self.testView setContentSize:CGSizeMake(self.frame.size.width/3*dataArray.count, self.frame.size.height)];
    
    float smallX=0.0;
    
//    for (int i=0; i<10; i++) {
//        
//        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(startx, 0.0, self.frame.size.width/3, self.frame.size.height)];
//        if(i%2==0){
//            [contentView setBackgroundColor:[UIColor redColor]];
//        }else{
//            [contentView setBackgroundColor:[UIColor blueColor]];
//        }
//        
//        [self.testView addSubview:contentView];
//        
//        startx+=self.frame.size.width/3;
//        
//    }
    
    for (int i=0; i<dataArray.count; i++) {
        
        Award *award = [dataArray objectAtIndex:i];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        
        NSString *smllImageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
        
        UIImageView *webImageView = [[UIImageView alloc] init];
        
        webImageView.tag = [award.id intValue];
        
        webImageView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickImage:)];
        
        [webImageView addGestureRecognizer:singleTap];
        
        [webImageView setImageWithURL:[NSURL URLWithString:smllImageUrl]
                     placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"newAwardBigImage%d.png",i]]];
        
        [webImageView setFrame:CGRectMake(smallX, 0.0, self.frame.size.width/3-2.0, self.frame.size.height)];
        
        UILabel *infoLabel = [[UILabel alloc] init];
        
        [infoLabel setText:award.awardInfo];
        
        NSLog(@"%@",award.awardInfo),
        
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        
        [infoLabel setTextColor:[UIColor redColor]];
        
        [infoLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
        
        [infoLabel setFrame:CGRectMake(smallX, webImageView.frame.size.height+2, self.frame.size.width/3-2.0, 10.0 )];
        
        [self.testView addSubview:webImageView];
        
//        [self.testView addSubview:infoLabel];
        
        smallX+=self.frame.size.width/3;
        
    }
    
    [self addSubview:self.testView];
    
}

-(void)onClickImage:(UITapGestureRecognizer *)recognizer{
    
    UIImageView *imageView = (UIImageView *)[recognizer view];
    
    NSLog(@"12455%ld",(long)imageView.tag);
    
    [delegateImage showAwardInfo:imageView.tag];
}

@end

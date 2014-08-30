//
//  AwardView.m
//  zmkm
//
//  Created by zhumengle on 14-5-2.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "AwardView.h"

@implementation AwardView

@synthesize _smallView;

@synthesize _imageArray;

@synthesize _timeCount;

@synthesize _supperImageArray;

@synthesize _supperSmallView;

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
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 159.0)];
    
    UIImage *topImage = [UIImage imageNamed:@"top.jpg"];
    
    [topImageView setImage:topImage];
    
    [self addSubview:topImageView];
    
    NSLog(@"_imageArray%lu",(unsigned long)_imageArray.count);
    
    UILabel *newLabel = [[UILabel alloc] init];
    
    [newLabel setFrame:CGRectMake((self.frame.size.width-100)/2, topImageView.frame.size.height+5, 100, 20)];
    
    [newLabel setText:@"最新大奖"];
    
    [newLabel setTextColor:[UIColor redColor]];
    
    [newLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:newLabel];
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, newLabel.frame.origin.y+newLabel.frame.size.height+5, self.frame.size.width, 60.0)];
    
    UIImage *newScrollBg = [UIImage imageNamed:@"kuang"];
    
    [newImageView setBackgroundColor:[UIColor colorWithPatternImage:newScrollBg]];
    
    testview *testView = [[testview alloc] initWithFrame:CGRectMake(newImageView.frame.origin.x+11.0, topImageView.frame.origin.y, self.frame.size.width-22.0, 50.0)];
    
    [testView setDataArray:_imageArray];
    
//    _smallView = [[UIScrollView alloc] initWithFrame:CGRectMake(newImageView.frame.origin.x+11.0, topImageView.frame.origin.y, self.frame.size.width-22.0, 50.0)];
//    
//    [_smallView setBackgroundColor:[UIColor whiteColor]];
//    
//    _smallView.delegate=self;
//    
//    _smallView.pagingEnabled = YES;
//    
//    float smallWidth =(self.frame.size.width-22.0)/_imageArray.count;
//    
//    [_smallView setContentSize:CGSizeMake(5000, 50.0)];
//    
//    _smallView.showsVerticalScrollIndicator=YES;
//    
//    [_smallView setScrollEnabled:YES];
//    
//    float smallX=0.0;
//    
//    for (int i=0; i<_imageArray.count; i++) {
//        
//        Award *award = [_imageArray objectAtIndex:i];
//        
//        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
//        
//        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
//        
//        NSString *domainName=[data objectForKey:@"domainName"];
//        
//        
//        NSString *smllImageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
//        
//        UIImageView *webImageView = [[UIImageView alloc] init];
//        
//        [webImageView setImageWithURL:[NSURL URLWithString:smllImageUrl]
//                     placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"newAwardBigImage%d.png",i]]];
//        
//        [webImageView setFrame:CGRectMake(smallX, 3.0, smallWidth-2.0, _smallView.frame.size.height-6.0)];
//        
//        UILabel *infoLabel = [[UILabel alloc] init];
//        
//        [infoLabel setText:award.awardInfo];
//        
//        [infoLabel setTextAlignment:NSTextAlignmentCenter];
//        
//        [infoLabel setTextColor:[UIColor redColor]];
//        
//        [infoLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
//        
//        [infoLabel setFrame:CGRectMake(smallX, webImageView.frame.size.height, smallWidth-2.0, 20.0 )];
//        
//        [_smallView addSubview:webImageView];
//        
//        [_smallView addSubview:infoLabel];
//        
//        smallX+=smallWidth;
//        
//    }
//    
//    [newImageView addSubview:_smallView];
    
    [newImageView addSubview:testView];
    
    [self addSubview:newImageView];
    
    UIImage *tuoImage = [UIImage imageNamed:@"tuo"];
    
    UIImageView *tuoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, newImageView.frame.origin.y+newImageView.frame.size.height+5, self.frame.size.width, 40)];
    
    [tuoImageView setImage:tuoImage];
    
    [self addSubview:tuoImageView];
    
    UILabel *newLabel1 = [[UILabel alloc] init];
    
    [newLabel1 setFrame:CGRectMake((self.frame.size.width-100)/2, tuoImageView.frame.origin.y+tuoImageView.frame.size.height+5, 100, 20)];
    
    [newLabel1 setText:@"超级大奖"];
    
    [newLabel1 setTextColor:[UIColor redColor]];
    
    [newLabel1 setTextAlignment:NSTextAlignmentCenter];
    
    [self addSubview:newLabel1];
    
    UIImageView *newImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, newLabel1.frame.origin.y+newLabel1.frame.size.height+5, self.frame.size.width, 60.0)];
    
    UIImage *newScrollBg1 = [UIImage imageNamed:@"kuang2"];
    
    [newImageView1 setBackgroundColor:[UIColor colorWithPatternImage:newScrollBg1]];
    
    [self addSubview:newImageView1];
    
    _supperSmallView = [[UIScrollView alloc] initWithFrame:CGRectMake(newImageView1.frame.origin.x+11.0, topImageView.frame.origin.y, self.frame.size.width-22.0, 60.0)];
    
    [_supperSmallView setBackgroundColor:[UIColor whiteColor]];
    
    _supperSmallView.delegate = self;
    
    _smallView.pagingEnabled = YES;
    
    float smallWidth1 =(self.frame.size.width-22.0)/_supperImageArray.count;
    
    [_supperSmallView setContentSize:CGSizeMake(smallWidth1*_supperImageArray.count*2, 60.0)];
    
    float smallX1=0.0;
    
    for (int i=0; i<_supperImageArray.count; i++) {
        
        Award *award = [_supperImageArray objectAtIndex:i];
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
        NSString *domainName=[data objectForKey:@"domainName"];
        
        
        NSString *smllImageUrl = [NSString stringWithFormat:@"%@%@",domainName,award.awardImage];
        
        UIImageView *webImageView = [[UIImageView alloc] init];
        
        [webImageView setImageWithURL:[NSURL URLWithString:smllImageUrl]
                     placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"newAwardBigImage1%d.png",i]]];
        
        [webImageView setFrame:CGRectMake(smallX1, 3.0, smallWidth1-2.0, _smallView.frame.size.height-6.0)];
        
        UILabel *infoLabel = [[UILabel alloc] init];
        
        [infoLabel setText:award.awardInfo];
        
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        
        [infoLabel setTextColor:[UIColor redColor]];
        
        [infoLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
        
        [infoLabel setFrame:CGRectMake(smallX1, webImageView.frame.size.height, smallWidth1-2.0, 20.0 )];
        
        [_supperSmallView addSubview:webImageView];
        
        [_supperSmallView addSubview:infoLabel];
        
        smallX1+=smallWidth1;
        
    }
    
    [newImageView1 addSubview:_supperSmallView];
    
    _timeCount=0;
    
    if (_imageArray.count>3) {
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    }
    
}

-(void)scrollTimer{
    _timeCount++;
    if (self._timeCount==_imageArray.count) {
        self._timeCount=0;
    }
    
    float smallWidth =(self.frame.size.width-55)/_imageArray.count;
    
    [self._smallView scrollRectToVisible:CGRectMake(_timeCount*smallWidth, 0.0, self.frame.size.width, 200.0) animated:YES];
    
    [self._supperSmallView scrollRectToVisible:CGRectMake(_timeCount*smallWidth, 0.0, self.frame.size.width, 200.0) animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSLog(@"%feee",scrollView.contentOffset.x);
    
    int index =scrollView.contentOffset.x/self.frame.size.width;
    
}

//-(void)requestFinished:(ASIHTTPRequest *)request{
//    
//    NSString *responseString = [request responseString];
//    
//    NSLog(@"responseString:%@",responseString);
//    
//    //NSData *responseData = [request responseData];
//    
//}
//
//-(void)requestFailed:(ASIHTTPRequest *)request{
//    NSError *error = [request error];
//    
//    NSLog(@"responseString:%@",error);
//}

@end

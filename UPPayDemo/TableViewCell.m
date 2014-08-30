//
//  TableViewCell.m
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize cellLabel;

@synthesize cellButton;

@synthesize treeNode;

@synthesize isExpanded;

@synthesize _inputViewDelegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellBg"]]];
        
        CGRect cellLabelFrame = CGRectMake(101.0, (37-20)/2, 200.0, 20.0);
        
        CGRect buttonFrame = CGRectMake(0.0, (37-11)/2, 11.0, 11.0);
        
        self.cellButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        self.cellButton.frame = buttonFrame;
        
        [self.cellButton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.cellButton];
        
        self.cellLabel=[[UILabel alloc] initWithFrame:cellLabelFrame];
        
        [self addSubview:self.cellLabel];
        
        
        
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

- (void)drawRect:(CGRect)rect
{
    CGRect cellFrame = self.cellLabel.frame;
    CGRect buttonFrame = self.cellButton.frame;
    int indentation = self.treeNode.nodeLevel * 25;
    cellFrame.origin.x = buttonFrame.size.width + indentation + 5;
    buttonFrame.origin.x = 2 + indentation;
    self.cellLabel.frame = cellFrame;
    self.cellButton.frame = buttonFrame;
    
    if ([self.treeNode.nodeObject isEqualToString:@"个人资料"]) {
        CGRect modifyFrame = CGRectMake(self.frame.size.width-50.0, (37-20)/2, 50.0, 20.0);
        UIButton *modifyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [modifyButton setFrame:modifyFrame];
        
        [modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        
        [modifyButton addTarget:self action:@selector(userInfo) forControlEvents:UIControlEventTouchUpInside];
        
//        [self addSubview:modifyButton];
    }else if ([self.treeNode.nodeObject isEqualToString:@"密码修改"]) {
        CGRect modifyFrame = CGRectMake(self.frame.size.width-50.0, (37-20)/2, 50.0, 20.0);
        UIButton *modifyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [modifyButton setFrame:modifyFrame];
        
        [modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        
        [modifyButton addTarget:self action:@selector(userPassword) forControlEvents:UIControlEventTouchUpInside];
        
//        [self addSubview:modifyButton];
    }
}

-(void)userInfo{
    
    NSLog(@"xiugai");
    
    [_inputViewDelegate pushModifyView];
    
}

-(void)userPassword{
    [_inputViewDelegate pushModifyPasswordView];
}

- (void)setTheButtonBackgroundImage:(UIImage *)backgroundImage
{
    [self.cellButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (void)expand:(id)sender
{
    self.treeNode.isExpanded = !self.treeNode.isExpanded;
    [self setSelected:NO animated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ProjectTreeNodeButtonClicked" object:self];
}

@end

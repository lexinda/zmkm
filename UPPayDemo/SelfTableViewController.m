//
//  SelfTableViewController.m
//  zmkm
//
//  Created by zhumengle on 14-5-3.
//  Copyright (c) 2014年 zhumengle. All rights reserved.
//

#import "SelfTableViewController.h"

@interface SelfTableViewController ()

@end

@implementation SelfTableViewController

@synthesize indentation;

@synthesize nodes;

@synthesize displayArray;

@synthesize _preTag;

@synthesize _prewMoveY;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title=@"个人中心";
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [backButton setFrame:CGRectMake(0.0, 0.0, 50.0, 30.0)];
        
        [backButton setBackgroundImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
        
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [self.navigationItem setLeftBarButtonItem:leftItem];
        
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    NSLog(@"jiazai.........");
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setScrollEnabled:NO];
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-1.png"]]];
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(expandCollapseNode:) name:@"ProjectTreeNodeButtonClicked" object:nil];
        
        [self fillNodesArray];
        [self fillDisplayArray];
        
        [self.tableView reloadData];
        
        NSLog(@"%lu",(unsigned long)self.displayArray.count);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
    
   [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)expandCollapseNode:(NSNotification *)notification
{
    [self fillNoticeDisplayArray];
    [self.tableView reloadData];
}

-(void)fillNodesArray{
    
    TreeViewNode *firstLevelNode1 = [[TreeViewNode alloc] init];
    
    firstLevelNode1.nodeLevel=0;
    
    firstLevelNode1.nodeObject=[NSString stringWithFormat:@"奖池"];
    
    firstLevelNode1.isExpanded = YES;
    
    firstLevelNode1.nodeChildren=[[self fillChildrenForNode] mutableCopy];
    
    TreeViewNode *firstLevelNode2 = [[TreeViewNode alloc] init];
    
    firstLevelNode2.nodeLevel=0;
    
    firstLevelNode2.nodeObject=[NSString stringWithFormat:@"个人资料"];
    
    firstLevelNode2.isExpanded = YES;
    
    firstLevelNode2.nodeChildren=[[self fillChildrenForNode] mutableCopy];
    
//    TreeViewNode *firstLevelNode3 = [[TreeViewNode alloc] init];
//    
//    firstLevelNode3.nodeLevel=0;
//    
//    firstLevelNode3.isExpanded = NO;
//    
//    firstLevelNode3.nodeObject=[NSString stringWithFormat:@"密码修改"];
//    
//    firstLevelNode3.nodeChildren=[[self fillChildrenForNode] mutableCopy];
    
//    self.nodes = [NSMutableArray arrayWithObjects:firstLevelNode1,firstLevelNode2,firstLevelNode3,nil];
    self.nodes = [NSMutableArray arrayWithObjects:firstLevelNode1,firstLevelNode2,nil];
    
}

-(NSArray *)fillChildrenForNode{
    
    TreeViewNode *secondLevelNode1 = [[TreeViewNode alloc] init];
    
    secondLevelNode1.nodeLevel=1;
    
    secondLevelNode1.nodeObject = [NSString stringWithFormat:@"second"];
    
    NSArray *childrenArray = [NSArray arrayWithObjects:secondLevelNode1, nil];
    
    return childrenArray;
    
}

-(void)fillDisplayArray{
    
    self.displayArray = [[NSMutableArray alloc] init];
    
//    for (int i=0; i<self.nodes.count; i++) {
//        
//        TreeViewNode *node = [self.nodes objectAtIndex:i];
//        
//        [self.displayArray addObject:node];
//        
//        if(i==0){
//
//            [self fillNodeWithChildrenArray:node.nodeChildren];
//            
//        }
//        
//    }
    
    for (TreeViewNode *node in self.nodes) {
        [self.displayArray addObject:node];
        
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
    
}

-(void)fillNoticeDisplayArray{
    
    self.displayArray = [[NSMutableArray alloc] init];
    
    for (TreeViewNode *node in self.nodes) {
        [self.displayArray addObject:node];
        
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
    
}

-(void)fillNodeWithChildrenArray:(NSArray *)childrenArray{
    
    for (TreeViewNode *node in childrenArray) {
        [self.displayArray addObject:node];
        
        if (node.isExpanded) {
            [self fillNodeWithChildrenArray:node.nodeChildren];
        }
    }
    
}

-(void)excpandAll:(id)sender{
    
    [self fillNodesArray];
    
    [self fillDisplayArray];
    
    [self.tableView reloadData];
}

-(void)collapseAll:(id)sender{
    
    for (TreeViewNode *treeNode in self.nodes) {
        treeNode.isExpanded = NO;
    }
    
    [self fillDisplayArray];
    
    [self.tableView reloadData];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.displayArray.count>0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self.displayArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"treeNodeCell";
    
    NSLog(@"indexPath.row%ld",(long)indexPath.row);
    
    NSLog(@"node.nodeLevel%lu",(unsigned long)node.nodeLevel);
    
    if (indexPath.row == 1 && node.nodeLevel == 1) {
        
        AwardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil || [cell isKindOfClass:[TableViewCell class]] || [cell isKindOfClass:[PeoplePasswordCell class]] || [cell isKindOfClass:[PeopleInfoCell class]]) {
            
            cell = [[AwardInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }
        
        cell.reloadAwardDelegate = self;
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        
    }else if ((indexPath.row == 3 && node.nodeLevel == 1) || (indexPath.row == 2 && node.nodeLevel == 1)) {
        
        PeopleInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil || [cell isKindOfClass:[TableViewCell class]] || [cell isKindOfClass:[AwardInfoCell class]] || [cell isKindOfClass:[PeoplePasswordCell class]]) {
            
            cell = [[PeopleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
        }else{
            cell = [[PeopleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;
        
    }else if ((indexPath.row == 5 && node.nodeLevel == 1) || (indexPath.row == 4 && node.nodeLevel == 1)) {
        
//        PeoplePasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        
//        if (cell == nil || [cell isKindOfClass:[TableViewCell class]] || [cell isKindOfClass:[AwardInfoCell class]] || [cell isKindOfClass:[PeopleInfoCell class]]) {
//            
//            cell = [[PeoplePasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            
//        }
//        
//        return cell;
        
    }else{
    
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil || [cell isKindOfClass:[AwardInfoCell class]] || [cell isKindOfClass:[PeopleInfoCell class]] || [cell isKindOfClass:[PeoplePasswordCell class]]) {
            cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        cell.treeNode = node;
    
        cell._inputViewDelegate = self;
        
        cell.cellLabel.text = node.nodeObject;
    
        if([cell.cellLabel.text isEqualToString:@"密码修改"]){
            
            
        }else{
            cell.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:215.0/255.0 blue:42.0/255.0 alpha:1.0];
        
            if (node.isExpanded) {
                [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"close"]];
            }else{
                [cell setTheButtonBackgroundImage:[UIImage imageNamed:@"open"]];
            }
        }
    
        [cell setNeedsDisplay];
        
        return cell;
    }
    
    return NULL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TreeViewNode *node = [self.displayArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 1 && node.nodeLevel == 1) {
        return 190;
    }else if ((indexPath.row == 3 && node.nodeLevel == 1) || (indexPath.row == 2 && node.nodeLevel == 1)) {
//        return 110;
        return 50;
    }else if ((indexPath.row == 4 && node.nodeLevel == 1) || (indexPath.row == 5 && node.nodeLevel == 1)) {
        return 80;
    }else{
        return 37;
    }
}

-(void)upInputView:(UITextField *)textField{
    NSLog(@"shangyi-------------");
    
    CGRect textFrame = textField.frame;
    
    float textY = textFrame.origin.y+textFrame.size.height;
    
    float bottomY = self.view.frame.size.height-textY;
    
    if (bottomY >= 216) {
        _preTag = -1;
        
        return;
    }
    
    _preTag = textField.tag;
    
    float moveY = 216 - bottomY;
    
    _prewMoveY = moveY;
    
    NSTimeInterval animationDuration = 0.30f;
    
    CGRect frame = self.view.frame;
    
    frame.origin.y -= moveY;
    
    frame.size.height += moveY;
    
    self.view.frame = frame;
    
    [UIView beginAnimations:@"resizeView" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = frame;
    
    [UIView commitAnimations];
    
}

-(void)downInputView:(UITextField *)textField{
    NSLog(@"huanyuan-------------");
    
    
    
    if(_preTag == -1) //当编辑的View不是需要移动的View
    {
        return;
    }
    float moveY ;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(_preTag == textField.tag) //当结束编辑的View的TAG是上次的就移动
    {   //还原界面
        moveY =  _prewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    //self.view移回原位置
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    
}

-(void)pushModifyView{
    
    ModifyUserInfoViewController *modifyUserInfoViewControl = [[ModifyUserInfoViewController alloc] init];
    
    [self.navigationController pushViewController:modifyUserInfoViewControl animated:YES];
    
}

-(void)pushModifyPasswordView{
    
    ModifyUserPasswordViewController *modifyUserPasswordViewControl = [[ModifyUserPasswordViewController alloc] init];
    
    [self.navigationController pushViewController:modifyUserPasswordViewControl animated:YES];
    
}

-(void)showAwardDetail:(NSString *)award{
    
    
    AwardDetailViewController *awardDetailViewController = [[AwardDetailViewController alloc] init];
    
    awardDetailViewController.award = award;
    
    [self.navigationController pushViewController:awardDetailViewController animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

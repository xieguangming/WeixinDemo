//
//  WXFriendTableController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXFriendTableController.h"
#import "UIView+YYFrame.h"
#import "WXImageTableController.h"
#import "WXBaseNavController.h"


#define kScreenWidth    [UIScreen mainScreen].bounds.size.width


#import "WXFriendHeaderView.h"  //headView

@interface WXFriendTableController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak)UIImageView *activityView;  //活动转圈
@property (nonatomic, weak)UIView *containerView;
@property (nonatomic, assign, getter=isDragging) BOOL dragging; //手动拖动的标志
@property (nonatomic, assign)NSInteger num;  //记录调用次数
@property (nonatomic, assign)CGFloat currentY;

@end

@implementation WXFriendTableController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    //1.拍照按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(clickCameraItem)];
    
    //self.automaticallyAdjustsScrollViewInsets = YES;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    

    //2.设置headerView,此处有bug哈哈哈
    WXFriendHeaderView *friendHeaderView = [WXFriendHeaderView friendHeaderView];
    UIView *headerView =  [[UIView alloc]initWithFrame:friendHeaderView.frame];
    [headerView addSubview:friendHeaderView];
    self.tableView.tableHeaderView = headerView;
    
    
    //3.下拉的转圈
    UIImage *actImage = [UIImage imageNamed:@"activity"];
    UIImageView *activityView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    activityView.image = actImage;
    //3.1设置圆角
    activityView.layer.cornerRadius = 30 / 2;
    activityView.layer.masksToBounds = YES;
    self.activityView = activityView;
    
    //
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(15, 120, 30, 30)];
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:activityView];
    self.containerView  = containerView;
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
    [self.view addSubview:containerView];
    
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.dragging  = YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.num == 0) {
        self.num ++;
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat angle =  - offsetY * M_PI/30;
    
    if (self.dragging == YES) {
        if (offsetY <= 110) {
            self.containerView.y = 10 + offsetY;
            
        }
    }else {
        if (self.currentY < 120) {
            self.containerView.y = 10 + offsetY;
        }
    }
    
    self.activityView.transform = CGAffineTransformMakeRotation(angle);
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.dragging = NO;
    
    CGFloat currentY = self.containerView.y;
    self.currentY = currentY;

}

//滚动结束时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.frame = CGRectMake(15, 120, 30, 30);
        self.activityView.transform = CGAffineTransformMakeRotation(2 * M_PI);
    }];
    
}


#pragma mark CameraAction
-(void)clickCameraItem
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"选取照片", nil];
    [sheet showInView:self.view];

}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == actionSheet.firstOtherButtonIndex) {
        
        WXImageTableController *imageVC = [[WXImageTableController alloc]initWithStyle:UITableViewStylePlain];
        WXBaseNavController *imageNav = [[WXBaseNavController alloc]initWithRootViewController:imageVC];
        imageVC.navigationItem.title = @"照片";
        
        [self presentViewController:imageNav animated:NO completion:nil];
    }
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *ID = @"friendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    cell.textLabel.text  = [NSString stringWithFormat:@"%02zd",indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    footer.backgroundColor = [UIColor whiteColor];
    
    return footer;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

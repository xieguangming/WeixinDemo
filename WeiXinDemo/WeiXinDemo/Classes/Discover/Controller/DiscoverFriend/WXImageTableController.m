//
//  WXImageTableController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXImageTableController.h"

#import "WXPictureCollectionController.h"
#import "WXDiscoverNavController.h"

@interface WXImageTableController ()

@end

@implementation WXImageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置rightItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCancel)];
    
    //2.自定义UICollectionView
    [self jumpToPicVc];
    
}

-(void)clickCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)jumpToPicVc
{
    UICollectionViewFlowLayout  *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 50, 10);
    flowLayout.minimumLineSpacing = 6;
    flowLayout.minimumInteritemSpacing = 6;
    
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - 2*10 - 2*6)/3 -2;   //每个item的宽度
    flowLayout.itemSize = CGSizeMake(itemW, itemW);    //每个item的大小
    
    //初始化pic控制器
    WXPictureCollectionController  *picVc = [[WXPictureCollectionController alloc]initWithCollectionViewLayout:flowLayout];
    picVc.navigationItem.title = @"相册";
    WXDiscoverNavController *navPic = [[WXDiscoverNavController alloc]initWithRootViewController:picVc];
    [self presentViewController:navPic animated:NO completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
      static NSString *ID = @"imageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //config cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld相册",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 系统默认44
    return 44;

}

@end

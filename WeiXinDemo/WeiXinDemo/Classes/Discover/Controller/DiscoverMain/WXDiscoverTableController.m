//
//  WXDiscoverTableController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXDiscoverTableController.h"

@interface WXDiscoverTableController ()<UITableViewDataSource,UITableViewDelegate>

//数据源
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation WXDiscoverTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发现";
    
    [self loadData];
    
}

-(void)loadData
{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"DiscoverList.plist" ofType:nil];
   
    self.dataArray  = [NSArray arrayWithContentsOfFile:path];   //NSArray自动初始化了

}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = self.dataArray[section][@"items"];
    return items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *ID = @"disCell";
    NSArray *items = self.dataArray[indexPath.section][@"items"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    //config cell...
    cell.textLabel.text = items[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:items[indexPath.row][@"icon"]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  //cell的样式
    
    return cell;


}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *items = self.dataArray[indexPath.section][@"items"];
    NSDictionary *dict = items[indexPath.row];
    
    if ([dict[@"targetVcName"] length] > 0) {
        
        Class  class = NSClassFromString(dict[@"targetVcName"]);
        
        UIViewController *targetVC = [[class alloc]init];
        
        targetVC.navigationItem.title = dict[@"title"];
        targetVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:targetVC animated:YES];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

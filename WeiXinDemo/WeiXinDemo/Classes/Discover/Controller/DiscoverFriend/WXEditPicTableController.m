//
//  WXEditPicTableController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXEditPicTableController.h"
#import "WXEditHeaderView.h"     //headView

@interface WXEditPicTableController ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *dataArray;    //数据源

@end

@implementation WXEditPicTableController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.取消按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickCancelBtn)];
    
    //2.发送按钮
    UIButton *sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 24)];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(didClickSendBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:sendBtn];
    
    //3. 加载数据
    [self loadData];
    
    //4.设置表头
    WXEditHeaderView  *headerView = [[WXEditHeaderView alloc]initWithModels:self.imageArray];  
    self.tableView.tableHeaderView =  headerView;

    
}

-(void)loadData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"EditPic.plist" ofType:nil];
    self.dataArray = [NSArray arrayWithContentsOfFile:path];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//滑动时键盘掉下
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];
}


#pragma mark - BtnAction
-(void)didClickCancelBtn
{

    [self.view endEditing:YES];
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:nil message:@"推出此次编辑?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alert1 show];
    
}

-(void)didClickSendBtn
{
    UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:nil message:@"消息发送成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert2 show];

}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self dismissViewControllerAnimated:YES completion:nil];
    
    }
    

}

#pragma mark - UITableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = self.dataArray[section][@"items"];
    return  items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *ID = @"editCell";
    NSArray *items = self.dataArray[indexPath.section][@"items"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = items[indexPath.row][@"title"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}



@end

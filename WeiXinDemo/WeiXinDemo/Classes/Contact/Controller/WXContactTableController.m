//
//  WXContactTableController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXContactTableController.h"

@interface WXContactTableController ()

@end

@implementation WXContactTableController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"联系人";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"header_icon_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addContactItem)];
    
}

-(void)addContactItem
{
    NSLog(@"addContactItem");
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

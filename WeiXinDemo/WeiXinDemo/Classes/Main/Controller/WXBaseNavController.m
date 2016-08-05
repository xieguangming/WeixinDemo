//
//  YYBaseNavController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXBaseNavController.h"

@interface WXBaseNavController ()

@end

@implementation WXBaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Dimensional-_Code_Bg"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabBarTitle:(NSString *)titleStr withNorImage:(NSString *)norStr withSelImage:(NSString *)selStr
{
    self.tabBarItem.title = titleStr;
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.04 green:0.73 blue:0.03 alpha:1.00]
                                              }
                                   forState:UIControlStateSelected];
    UIImage *norImage = [UIImage imageNamed:norStr];
    UIImage *selImage = [UIImage imageNamed:selStr];
    
    norImage = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem.image = norImage;
    self.tabBarItem.selectedImage = selImage;
    
}



@end

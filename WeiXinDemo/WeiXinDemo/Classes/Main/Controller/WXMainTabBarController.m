//
//  WXMainTabBarController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXMainTabBarController.h"

//基类
#import "WXBaseNavController.h"

//navVC
#import "WXHomeNavController.h"
#import "WXContactNavController.h"
#import "WXDiscoverNavController.h"
#import "WXMyNavController.h"

//tableVC
#import "WXHomeTableController.h"
#import "WXContactTableController.h"
#import "WXDiscoverTableController.h"
#import "WXMyTableController.h"


@interface WXMainTabBarController ()

@end

@implementation WXMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addSubViewController];
    
    self.selectedIndex = self.viewControllers.count- 1;
    
    
}

-(void)addSubViewController
{
 
    //第1个home
    WXHomeTableController  *homeVC = [[WXHomeTableController alloc]init];
    WXHomeNavController  *home  = [[WXHomeNavController alloc]initWithRootViewController:homeVC];
    [home setTabBarTitle:@"微信" withNorImage:@"tabbar_mainframe" withSelImage:@"tabbar_mainframeHL"];
    
    
    //第2个contact
    WXContactTableController  *contactVC = [[WXContactTableController alloc]init];
    WXContactNavController *contact = [[WXContactNavController alloc]initWithRootViewController:contactVC];
    [contact setTabBarTitle:@"联系人" withNorImage:@"tabbar_contacts" withSelImage:@"tabbar_contactsHL"];
    
    //第3个discover
    WXDiscoverTableController *discoverVC = [[WXDiscoverTableController alloc]init];
    WXDiscoverNavController  *discover  = [[WXDiscoverNavController alloc]initWithRootViewController:discoverVC];
    [discover setTabBarTitle:@"发现" withNorImage:@"tabbar_discover" withSelImage:@"tabbar_discoverHL"];
    
    
    //第4个my
    WXMyTableController  *myVC = [[WXMyTableController alloc]init];
    WXMyNavController *my = [[WXMyNavController alloc]initWithRootViewController:myVC];
    [my setTabBarTitle:@"我" withNorImage:@"tabbar_me" withSelImage:@"tabbar_meHL"];

    
    self.viewControllers = @[home,contact,discover,my];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

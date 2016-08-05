//
//  WXFriendHeaderView.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXFriendHeaderView.h"

@implementation WXFriendHeaderView

//初始化
+(instancetype)friendHeaderView
{

    return [[[NSBundle mainBundle]loadNibNamed:@"WXFriendHeaderView" owner:nil options:nil]lastObject];
}

-(void)awakeFromNib{

}


@end

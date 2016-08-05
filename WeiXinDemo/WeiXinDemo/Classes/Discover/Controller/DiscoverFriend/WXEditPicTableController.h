//
//  WXEditPicTableController.h
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXBaseTableController.h"

@class WXPictureModel;

@interface WXEditPicTableController : WXBaseTableController

@property (nonatomic, strong)NSArray<WXPictureModel *>  *imageArray;

@end

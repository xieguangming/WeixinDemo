//
//  WXPictureCell.h
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXPictureModel,WXPictureCell;

//************************************************/
//自定义协议
@protocol WXPictureCellDelegate <NSObject>

@optional
-(void)pictureCell:(WXPictureCell *)cell withDidClickBtn:(UIButton *)btn;

@end
//************************************************/
@interface WXPictureCell : UICollectionViewCell

//单例方法
+(instancetype)pictureCell;

@property (nonatomic,weak)id<WXPictureCellDelegate>  delegate;
@property (nonatomic, strong)WXPictureModel  *model;

@end

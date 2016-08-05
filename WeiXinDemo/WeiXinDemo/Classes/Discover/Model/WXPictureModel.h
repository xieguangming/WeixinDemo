//
//  WXPictureModel.h
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXPictureModel : NSObject
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *btnImage;
@property (nonatomic,assign, getter=isClickedBtn) BOOL clickedBtn;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)pictureWithDict:(NSDictionary *)dict;


@end

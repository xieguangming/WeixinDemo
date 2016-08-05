//
//  WXPictureModel.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXPictureModel.h"

@implementation WXPictureModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self  setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

+(instancetype)pictureWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}


@end

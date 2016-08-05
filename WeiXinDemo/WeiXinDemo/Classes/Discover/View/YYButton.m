//
//  YYButton.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/3.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "YYButton.h"
#import "UIView+YYFrame.h"

@implementation YYButton

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.w - self.imageView.image.size.width) * 0.5, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    
    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame), self.w, self.h - CGRectGetMaxY(self.imageView.frame));

    
}

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

@end

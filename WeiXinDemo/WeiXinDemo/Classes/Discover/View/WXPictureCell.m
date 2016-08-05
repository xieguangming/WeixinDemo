//
//  WXPictureCell.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXPictureCell.h"
#import "WXPictureModel.h"

@interface WXPictureCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end



@implementation WXPictureCell

#pragma mark - 点击选中按钮
- (IBAction)clickSureBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pictureCell:withDidClickBtn:)]) {
        [self.delegate pictureCell:self withDidClickBtn:sender];
    }
}

+(instancetype)pictureCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WXPictureCell" owner:nil options:nil] lastObject];
}

//设置model
-(void)setModel:(WXPictureModel *)model
{
    _model = model;
    
    if (model.isClickedBtn) {
        self.sureBtn.selected = YES;
        
    }else{
        self.sureBtn.selected = NO;
    }
  
    NSString *iconName = [NSString stringWithFormat:@"%@.jpg",model.icon];
    self.iconView.image = [UIImage imageNamed:iconName];

}



- (void)awakeFromNib {
    // Initialization code
}

@end

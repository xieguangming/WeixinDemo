//
//  WXEditHeaderView.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXEditHeaderView.h"
#import "WXPictureModel.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width

#define COL 4

@interface WXEditHeaderView()<UITextViewDelegate>

@property (nonatomic, weak)UITextView  *textView;

@property (nonatomic, weak)UIButton  *addBtn;

@property (nonatomic, strong)NSString *changeTxt;  //记录用户的输入文字

@property (nonatomic, strong)NSMutableArray<UIButton *>  *btnArray;   //btn数组

@end


@implementation WXEditHeaderView
//懒加载
-(NSMutableArray<UIButton *> *)btnArray
{

    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
        
    }
    return _btnArray;


}

-(instancetype)initWithModels:(NSArray<WXPictureModel *> *)models
{
    if (self = [super init]) {
        NSInteger imageCount =  models.count;
        
        NSInteger row = imageCount / COL + 1;
        
        CGFloat btnW = 65;    //btn宽度
        CGFloat btnH = btnW;  //btn高度
        CGFloat txtH = 120;   //tex高度
        CGFloat margin = 10;  //上下间距
        
        self.frame = CGRectMake(0, 0, kScreenWidth, btnH * row + txtH + 3 * margin + (row-1)*margin);
        self.backgroundColor = [UIColor whiteColor];   //yellowColor
        
        
        //设置textView
        UITextView *txtView = [[UITextView alloc]init];
        txtView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        //设置代理
        txtView.delegate = self;
        txtView.text = @"这一刻的想法...";
        txtView.textColor = [UIColor lightGrayColor];
        self.textView  = txtView;
        
        [self addSubview:txtView];
        
        if (imageCount < 9) {
            imageCount ++;
            
            for (int i = 0; i < imageCount; i++) {
                UIButton *btn = [[UIButton alloc]init];
                if (i < imageCount -1) {
                 
                    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",models[i].icon];
                    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                }else if(i == imageCount - 1){ //刚好第9张
                    [btn setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
                    
                }
                [self addSubview:btn];
                
                [self.btnArray addObject:btn];
                
                }
            }else if(imageCount == 9)
            {
                for ( int i =0; i < imageCount; i++) {
                    UIButton *btn = [[UIButton alloc]init];
                    
                    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",models[i].icon];
                    
                    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                    [self addSubview:btn];
                    
                    [self.btnArray addObject:btn];
                }
            }
        }
    
      return self;

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = 65;
    CGFloat btnH = btnW;
    CGFloat txtH = 120;
    CGFloat margin = 10;
    
    self.textView.frame = CGRectMake(0, 0 ,kScreenWidth , txtH);
    
    for (int i =0; i <self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        
        NSInteger col_index = i % COL;  //列
        NSInteger row_index = i / COL;  //行
        
        CGFloat btnX = margin + col_index * (btnW + margin);
        CGFloat btnY = margin + txtH + margin + row_index *(btnH + margin);
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.changeTxt.length ==0) {
        self.textView.text = @"";
    }
    
    self.textView.textColor = [UIColor blackColor];
    
}

-(void)textViewDidChange:(UITextView *)textView
{

    self.changeTxt = textView.text;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textView.text.length == 0) {
        
        self.textView.text = @"这一刻的想法...";
        self.textView.textColor = [UIColor lightGrayColor];
    }

}


@end

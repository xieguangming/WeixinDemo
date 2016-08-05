//
//  WXShakeController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//

#import "WXShakeController.h"
#import "YYButton.h"   //自定义btn
#import "UIView+YYFrame.h"   //UIView分类

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define  kImageViewHeight 320

@interface WXShakeController ()

@property (nonatomic, weak)YYButton *upSelectedBtn;   //下方3个按钮

@property (nonatomic, weak)UIImageView *upImageView;   //向上图片

@property (nonatomic, weak)UIImageView *downImageView;  //向下图片

@property (nonatomic, weak)UIImageView *upLine;   //向上横线

@property (nonatomic, weak)UIImageView *downLine;  //向下横线

@property (nonatomic, weak)UIView *searchView;   //搜索框

@end

@implementation WXShakeController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor colorWithRed:0.16 green:0.18 blue:0.18 alpha:1.00];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(clickAction)];
    
    [self setViewBG];
    
    [self loadBottomBtn];  //下面3个按钮
    
    [self loadShakeImage];   //加载摇一摇图片
    
}

//实现摇一摇功能
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    self.upLine.hidden = NO;
    self.downLine.hidden = NO;
    
   [UIView animateWithDuration:0.6 animations:^{
       
       self.upImageView.y-= 60;
       self.upLine.y -=60;
       
       self.downImageView.y +=60;
       self.downLine.y +=60;
       
   } completion:^(BOOL finished) {
       //动画结束之后
       [UIView animateWithDuration:0.6 animations:^{
          
           self.upImageView.y +=60;
           self.upLine.y += 60;
           
           self.downImageView.y -=60;
           self.downLine.y -= 60;
       } completion:^(BOOL finished) {
           //横线隐藏
           self.upLine.hidden = YES;
           self.downLine.hidden = YES;
           
           //弹出搜索框
           [self showSearchView];
           
           //动画结束把searchView上2个子控件移除
            [self.searchView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
           
           
       }];
   }];
}

//显示搜索框
-(void)showSearchView
{
    //1.初始化searchView
    UIView *searchView = [[UIView alloc]init];
    searchView.frame = CGRectMake(0, CGRectGetMaxY(self.downImageView.frame) - 16, kScreenWidth, 50);
    
    //2.初始化转圈View
    UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc]init];
    [actView startAnimating];  //开启转圈
    
    //3. 初始化txtLbel
    UILabel *txtLbel = [[UILabel alloc]init];
    NSString *str = @"正在搜索同一时间一起摇晃手机的人";
    txtLbel.text = str;
    txtLbel.textColor = [UIColor whiteColor];
    txtLbel.numberOfLines = 0;
    txtLbel.font = [UIFont systemFontOfSize:15];
    
    CGFloat actW = 20;
    CGFloat actH = actW;
    CGFloat margin = 10;
    //4. 根据文字大小动态计算txtLbel高度
    CGSize txtSize = [str boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}
                                       context:nil].size;
    
    
    //5. 设置actView的frame
    CGFloat actX = (kScreenWidth - actW - txtSize.width - margin) * 0.5;   //转圈X
    CGFloat actY = (searchView.bounds.size.height - actH) * 0.5;   //转圈Y
    actView.frame = CGRectMake(actX, actY, actW, actH);
    
    //6.设置Txt的frame
    CGFloat txtX = CGRectGetMaxX(actView.frame) + margin;
    CGFloat txtY = (searchView.bounds.size.height - txtSize.height) * 0.5;
    txtLbel.frame = CGRectMake(txtX, txtY, txtSize.width, txtSize.height);
    
    //6. 子控件加到searchView上
    [searchView addSubview:actView];
    [searchView addSubview:txtLbel];
    [self.view addSubview:searchView];
    self.searchView = searchView;
    
    // [self.searchView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
}

-(void)loadShakeImage
{
    //1. 向上的图片
    UIImage *upImage = [UIImage imageNamed:@"Shake_Logo_Up"];
    UIImageView *upImageView = [[UIImageView alloc]initWithImage:upImage];
    upImageView.frame = CGRectMake((kScreenWidth - upImage.size.width) * 0.5, kScreenHeight * 0.5 - 64 - upImage.size.height, upImage.size.width, upImage.size.height);
    
    //2. 向下的图片
    UIImage *downImage = [UIImage imageNamed:@"Shake_Logo_Down"];
    UIImageView *downImageView = [[UIImageView alloc]initWithImage:downImage];
    downImageView.frame = CGRectMake((kScreenWidth - downImage.size.width) *0.5, CGRectGetMaxY(upImageView.frame), downImage.size.width, downImage.size.height);
    
    //3. 向上横线
    UIImageView *upLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Shake_Line_Up"]];
    upLine.frame = CGRectMake(0, CGRectGetMaxY(upImageView.frame), kScreenWidth, 5);
    
    //4. 向下横线
    UIImageView *downLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Shake_Line_Down"]];
    downLine.frame = CGRectMake(0, downImageView.frame.origin.y - 5, kScreenWidth, 5);
    
    upLine.hidden = YES;
    downLine.hidden = YES;
    
    [self.view addSubview:upImageView];
    [self.view addSubview:downImageView];
    [self.view addSubview:upLine];
    [self.view addSubview:downLine];
    
    //赋值
    self.upImageView = upImageView;
    self.downImageView = downImageView;
    self.upLine = upLine;
    self.downLine = downLine;
}

-(void)loadBottomBtn
{
    NSArray *titleArray = @[@"人",@"歌曲",@"电视"];
    NSArray *norImageArr = @[@"Shake_icon_people",@"Shake_icon_music",@"Shake_icon_tv"];
    NSArray *HLImageArr = @[@"Shake_icon_peopleHL",@"Shake_icon_musicHL",@"Shake_icon_tvHL"];
    
    CGFloat btnW = 80;  //按钮宽度
    CGFloat btnH = 60;  //按钮高度
    CGFloat btnY = kScreenHeight - btnH - 100;
    
    CGFloat margin = (kScreenWidth - 3*btnW) /4;  //按钮间距
    
    for (int i = 0;  i <3; i++) {
        YYButton *btn = [[YYButton alloc]init];
        
        [btn setImage:[UIImage imageNamed:norImageArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:HLImageArr[i]] forState:UIControlStateSelected];
        
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
        btn.frame = CGRectMake(margin + i*(btnW + margin), btnY, btnW, btnH);
        
        if (i == 0) {
            btn.selected = YES;
            self.upSelectedBtn = btn;
        }
        [self.view addSubview:btn];
    }
}

-(void)clickBtn:(YYButton *)sender
{
    self.upSelectedBtn.selected = NO;
    sender.selected = YES;
    self.upSelectedBtn = sender;
}

-(void)setViewBG
{
    UIImage *img = [UIImage imageNamed:@"ShakeHideImg_women"];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    
    imgView.userInteractionEnabled = YES;  //打开用户使能
    
    imgView.frame = CGRectMake((kScreenWidth - kImageViewHeight) *0.5, kScreenHeight *0.5 - kImageViewHeight *0.5 - 50, kImageViewHeight, kImageViewHeight);
    [self.view addSubview:imgView];

}

-(void)clickAction
{
    NSLog(@"编辑按钮...");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

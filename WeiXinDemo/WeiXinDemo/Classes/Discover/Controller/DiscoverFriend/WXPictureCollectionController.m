//
//  WXPictureCollectionController.m
//  WeiXinDemo
//
//  Created by 谢光明 on 16/8/4.
//  Copyright © 2016年 auratech. All rights reserved.
//


#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kScreenBounds   [UIScreen mainScreen].bounds

#import "WXPictureCollectionController.h"

#import "WXPictureCell.h"    //cell
#import "WXPictureModel.h"   //model

//控制器
#import "WXBaseNavController.h"
#import "WXEditPicTableController.h"

@interface WXPictureCollectionController ()<WXPictureCellDelegate>

@property (nonatomic,strong)NSMutableArray<UIButton *>   *selectedBtn;   //泛型数组

@property (nonatomic,strong)NSArray  *dataArray;   //数据源

@property (nonatomic,weak)UIView *footerView;   //footerView

@property (nonatomic,weak)UIButton *doneBtn;   //完成按钮

@property (nonatomic,weak)UIButton *previewBtn;  //预览按钮

@property (nonatomic,strong)NSMutableArray <WXPictureModel *>  *selImageArray;   //被选中的照片

@end

@implementation WXPictureCollectionController

static NSString * const reuseIdentifier = @"Cell";

//懒加载
-(NSMutableArray<WXPictureModel *> *)selImageArray
{
    if (!_selImageArray) {
        
        _selImageArray = [NSMutableArray array];
    }
    
    return _selImageArray;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"PictureCell" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            
            WXPictureModel *model = [WXPictureModel pictureWithDict:dict];
            
            [tempArray addObject:model];
        }
        
        _dataArray = tempArray;
    }
        return _dataArray;
}

-(NSMutableArray<UIButton *> *)selectedBtn
{
    if (!_selectedBtn) {
        
        _selectedBtn = [NSMutableArray array];
    }
    
    return _selectedBtn;

}

#pragma mark - 程序主入口
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //1. left返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem1)];
    
    //2. 注册xib创建的Cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"WXPictureCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(canclePicture)];
    
    
    //3. 自定义footerView
    UIView *footerView =  [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight -44, kScreenWidth, 44)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    
   //4. 完成按钮
    UIButton *doneBtn = [[UIButton alloc]init];
    doneBtn.enabled = NO;
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];    //选中颜色
    [doneBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];   //正常颜色
    doneBtn.frame = CGRectMake(kScreenWidth - 60, 0, 60, 44);
    [doneBtn addTarget:self action:@selector(clickDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.doneBtn = doneBtn;
    
    //5. 预览按钮
    UIButton *previewBtn = [[UIButton alloc]init];
    previewBtn.enabled = NO;
    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [previewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    previewBtn.frame = CGRectMake(0, 0, 60, 44);
    [previewBtn addTarget:self action:@selector(clickPreviewBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.previewBtn = previewBtn;
    
    //6.把完成和预览按钮放上去
    [footerView addSubview:doneBtn];
    [footerView addSubview:previewBtn];
    self.footerView = footerView;
    
    [self.navigationController.view addSubview:footerView];
    
}

#pragma mark - UIButtonAction
-(void)clickPreviewBtn:(UIButton *)sender
{
    NSLog(@"点击了预览按钮");
}

//点击完成进入编辑页面
-(void)clickDoneBtn:(UIButton *)sender
{
    WXEditPicTableController  *editPicVc = [[WXEditPicTableController alloc]init];
    WXBaseNavController *navEditVc = [[WXBaseNavController alloc]initWithRootViewController:editPicVc];
    
    editPicVc.imageArray = self.selImageArray;  
    [self presentViewController:navEditVc animated:YES completion:nil];
    
}

#pragma mark - 监听返回按钮
-(void)backItem1{
    [self.footerView removeFromSuperview];   //移除所有的子控件
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)canclePicture
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    WXPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark  WXPictureCell 代理方法实现

-(void)pictureCell:(WXPictureCell *)cell withDidClickBtn:(UIButton *)btn
{
    //最多只能选9张
    if ((self.selectedBtn.count == 9)&& (!btn.isSelected)){
      
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"最多选取9张照片哦,亲!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    btn.selected = !btn.isSelected;   //就是这个地方写错了
    
    NSIndexPath  *indexPath = [self.collectionView indexPathForCell:cell];
    
    WXPictureModel *model = self.dataArray[indexPath.row];
    
    if (btn.isSelected) {
        
        model.clickedBtn = YES;
        
        [self.selectedBtn addObject:btn];
        
        [self.selImageArray addObject:model];
        
    } else{
        
        model.clickedBtn = NO;
        [self.selectedBtn removeObject:btn];
        [self.selImageArray removeObject:model];
    }
    if (self.selectedBtn.count > 0) {
        
        self.doneBtn.enabled = YES;
        self.doneBtn.selected = YES;
        self.previewBtn.enabled = YES;
        self.previewBtn.selected = YES;
    }else {
        
        self.doneBtn.enabled = NO;
        self.doneBtn.selected = NO;
        self.previewBtn.enabled = NO;
        self.previewBtn.selected = NO;
    }

}


#pragma mark <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中了第%ld个 collectionView",indexPath.row);
}

@end

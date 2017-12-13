//
//  PicViewController.m
//  本地相册和视频
//
//  Created by 张杰 on 2016/10/21.
//  Copyright © 2016年 张杰. All rights reserved.
//

#import "PicViewController.h"
#import "JYAblumList.h"
#import "Cell.h"
@interface PicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,retain)NSMutableArray *dataArr;
@end

@implementation PicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //调用这个方法获取相册里的所有图片
    
    [_dataArr addObjectsFromArray:[[JYAblumTool sharePhotoTool] getAllAssetInPhotoAblumWithAscending:NO]];
    
    //此处必须要有创见一个UICollectionViewFlowLayout的对象
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    
    //同一行相邻两个cell的最小间距
    
    layout.minimumInteritemSpacing = 5;
    
    //最小两行之间的间距
    
    layout.minimumLineSpacing = 5;
    
    
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, 375, 667) collectionViewLayout:layout];
    
    _collectionView.backgroundColor=[UIColor whiteColor];
    
    _collectionView.delegate=self;
    
    _collectionView.dataSource=self;
    _collectionView.backgroundColor = [UIColor yellowColor];
    
    //这个是横向滑动
    
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    [self.view addSubview:_collectionView];
    
    
    
    /*
     
     *这是重点 必须注册cell
     
     */
    
    //这种是xib建的cell 需要这么注册
    
    UINib *cellNib=[UINib nibWithNibName:@"Cell" bundle:nil];
    
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
}
//一共有多少个组

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

//每一组有多少个cell

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}

//每一个cell是什么

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    PHAsset *asset = _dataArr[indexPath.row];
    
    [self getImageWithAsset:asset completion:^(UIImage *image) {
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.headerImageVIew.image=image;
        
    }];
    
    return cell;
    
}

//定义每一个cell的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    return CGSizeMake(115, 100);
    
}

//从这个回调中获取所有的图片

- (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion

{
    
    CGSize size = [self getSizeWithAsset:asset];
    
    [[JYAblumTool sharePhotoTool] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:completion];
    
}

#pragma mark - 获取图片及图片尺寸的相关方法

- (CGSize)getSizeWithAsset:(PHAsset *)asset

{
    
    CGFloat width  = (CGFloat)asset.pixelWidth;
    
    CGFloat height = (CGFloat)asset.pixelHeight;
    
    CGFloat scale = width/height;
    
    
    
    return CGSizeMake(self.collectionView.frame.size.height*scale, self.collectionView.frame.size.height);
    
}

@end

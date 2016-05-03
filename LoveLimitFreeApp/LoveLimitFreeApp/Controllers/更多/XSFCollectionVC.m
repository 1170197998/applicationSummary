//
//  XSFCollectionVC.m
//  LoveLimitFreeApp
//
//  Created by admin on 15/11/2.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "XSFCollectionVC.h"
#import "XSFCollectionViewCell.h"
@interface XSFCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>
{
    NSMutableDictionary *_mDictionary;
    NSMutableArray *_mArrayIcon;
    NSMutableArray *_mArrayTitle;
    NSMutableArray *_mArrayOfKey;
    
    UICollectionView *_collectionView;
    UICollectionViewFlowLayout *_collectionViewFlowLayout;
    BOOL _isEdit;
}
@end

@implementation XSFCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mArrayIcon = [NSMutableArray array];
    _mArrayTitle = [NSMutableArray array];
    _mArrayOfKey = [NSMutableArray array];
    [self setNavigationBar];
    
    [self getData];
    _isEdit = YES;
    [self creatCollectionView];
}

#pragma mark - 导航栏设置
- (void)setNavigationBar
{
    //去掉导航栏
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"收藏列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"详情返回"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];

    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(clickEditMode)];

    self.navigationItem.rightBarButtonItem = barButtonItem;
}

#pragma mark - 点击按钮进入编辑模式
- (void)clickEditMode
{
    if (_isEdit) {
        for (XSFCollectionViewCell *cell in _collectionView.visibleCells) {
            [UIView animateWithDuration:0.5 animations:^{
                cell.buttonDelete.hidden = NO;
            }];        }
        _isEdit = NO;
        
    } else {
        
        for (XSFCollectionViewCell *cell in _collectionView.visibleCells) {
            
            [UIView animateWithDuration:0.5 animations:^{
                cell.buttonDelete.hidden = YES;
            }];
        }
        _isEdit = YES;
    }
}
                                              
#pragma mark - 点击按钮返回上一界面
- (void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 获取沙盒路径中已经收藏的数据
- (void)getData
{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/collections.plist",NSHomeDirectory()];
    _mDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"%@",path);
    NSArray *array = [_mDictionary allValues];
    _mArrayOfKey = (NSMutableArray *)[_mDictionary allKeys];
    
    for (NSDictionary *dict in array) {
        
        [_mArrayTitle addObject:dict[@"name"]];
        [_mArrayIcon addObject:dict[@"iconUrl"]];
    }
}

#pragma mark - 创建collectionView
- (void)creatCollectionView
{
    _collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionViewFlowLayout.itemSize = CGSizeMake(100, 100);
    
    _collectionViewFlowLayout.minimumInteritemSpacing = 10;
    _collectionViewFlowLayout.minimumLineSpacing = 10;
    _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    
    //UICollectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:_collectionViewFlowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[XSFCollectionViewCell class] forCellWithReuseIdentifier:@"ID"];
    [self.view addSubview:_collectionView];
}

#pragma mark 返回多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _mDictionary.count;
}

#pragma mark 返回每个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XSFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];

    //为控件赋值
    cell.label.text = _mArrayTitle[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_mArrayIcon[indexPath.row]]];
    
    cell.buttonDelete.hidden = YES;
    cell.buttonDelete.tag = indexPath.row;
    [cell.buttonDelete addTarget:self action:@selector(clickButtonDelete:)forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark - 点击Button按钮进行删除
- (void)clickButtonDelete:(UIButton *)sender
{
    NSLog(@"%d --- %d",[_collectionView indexPathForCell:((UICollectionViewCell *)[sender superview])].row,sender.tag);
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/collections.plist",NSHomeDirectory()];
    [_mDictionary removeObjectForKey:_mArrayOfKey[sender.tag]];
    [_mDictionary writeToFile:path atomically:NO];
    
    //_collectionView indexPathForCell:((UICollectionViewCell *)[sender superview])].row
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_collectionView indexPathForCell:((UICollectionViewCell *)[sender superview])].row inSection:0];
    NSArray *deleteItems = @[indexPath];
    [_collectionView deleteItemsAtIndexPaths:deleteItems];
    
    [_collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

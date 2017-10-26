//
//  ViewController.m
//  Excel
//
//  Created by nbcb on 2017/10/26.
//  Copyright © 2017年 ZQC. All rights reserved.
//

#import "ViewController.h"
#import "ExcelCell.h"
#import "Masonry.h"

#define app_screen_width ([[UIScreen mainScreen] bounds].size.width)
#define app_screen_height ([[UIScreen mainScreen] bounds].size.height)

#define TitleHeight          20.0
#define DetailHeight         40.0
#define SubTitleHeight       20.0
#define SubDetailHeight      20.0
#define ItemWidth            175.0
#define ItemHeight           30.0
#define LeftSpace            10.0
#define TopSpace             10.0

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

{
    UICollectionView    *_collectionView;
    NSArray             *_dataArr;
    CGFloat             _itemHeight;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
    _dataArr = @[@[@"转入时间",
                   @"周一15:00前",
                   @"周一15:00 ~ 周二15:00",
                   @"周二15:00 ~ 周三15:00",
                   @"周三15:00 ~ 周四15:00",
                   @"周四15:00 ~ 周五15:00",
                   @"周五15:00 ~ 下周一15:00"],
                 @[@"收益计算时间",
                   @"周二",
                   @"周三",
                   @"周四",
                   @"周五",
                   @"下周一",
                   @"下周二"],
                 @[@"首次收益到账时间",
                   @"周三",
                   @"周四",
                   @"周五",
                   @"下周一",
                   @"下周二",
                   @"下周三"]];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (_collectionView) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)setupSubViews {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, app_screen_width - 5 * 2, TitleHeight + DetailHeight + SubTitleHeight + ItemHeight * 7 + SubDetailHeight + TopSpace * 6)];
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 0.5;
    [self.view addSubview:view];
    view.center = self.view.center;

    UILabel *title = [[UILabel alloc] init];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:13.f];
    title.text = @"收益计算规则";
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopSpace);
        make.left.offset(LeftSpace);
        make.right.offset(-LeftSpace);
        make.height.mas_equalTo(TitleHeight);
    }];
    
    UILabel *detail = [[UILabel alloc] init];
    detail.backgroundColor = [UIColor clearColor];
    detail.textColor = [UIColor blackColor];
    detail.font = [UIFont systemFontOfSize:13.f];
    detail.text = @"购买的资金，第二个工作日开始计算收益，遇节假日顺延，收益计算后的第二个工作日收益到账。";
    detail.numberOfLines = 0;
    [view addSubview:detail];
    
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopSpace * 2 + TitleHeight);
        make.left.offset(LeftSpace);
        make.size.mas_equalTo(CGSizeMake(app_screen_width - LeftSpace * 2, DetailHeight));
    }];
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.backgroundColor = [UIColor clearColor];
    subTitle.textColor = [UIColor blackColor];
    subTitle.font = [UIFont systemFontOfSize:13.f];
    subTitle.text = @"举例:";
    [view addSubview:subTitle];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopSpace * 3 + TitleHeight + DetailHeight);
        make.left.offset(LeftSpace);
        make.right.offset(-LeftSpace);
        make.height.mas_equalTo(TitleHeight);
    }];
    
    [self addCollectionView];
    
    [view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(TopSpace * 4 + TitleHeight + DetailHeight + SubTitleHeight);
        make.left.offset(LeftSpace);
        make.size.mas_equalTo(CGSizeMake(app_screen_width - (LeftSpace + 5) * 2, ItemHeight * 7));
    }];
    UILabel *subDetail = [[UILabel alloc] init];
    subDetail.backgroundColor = [UIColor clearColor];
    subDetail.textColor = [UIColor blackColor];
    subDetail.font = [UIFont systemFontOfSize:13.f];
    subDetail.text = @"温馨提示: 左右滑动浏览完整信息";
    [view addSubview:subDetail];
    
    [subDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-TopSpace);
        make.left.offset(LeftSpace);
        make.right.offset(-LeftSpace);
        make.height.mas_equalTo(SubDetailHeight);
    }];
}

- (void)addCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[ExcelCell class] forCellWithReuseIdentifier:@"ExcelCell"];
}

#pragma mark ### UIConllectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_dataArr[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    ExcelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExcelCell" forIndexPath:indexPath];
    cell.label.text = _dataArr[section][row];
    
    if ((section == 0 && row == 0) || section != 0) {
        
        cell.label.textAlignment = NSTextAlignmentCenter;
    }
    else {
        cell.label.textAlignment = NSTextAlignmentLeft;
    }
    return cell;
}

@end

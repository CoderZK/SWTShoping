//
//  SWTMineGuanZHuDinaPuCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineGuanZHuDinaPuCell.h"
#import "SWTGuanZhuCollectionCell.h"
@interface SWTMineGuanZHuDinaPuCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic , strong)UICollectionView *collectionView;
@property(nonatomic , strong)UICollectionViewFlowLayout *layout;
@property(nonatomic , strong)UIButton *headBt;
@property(nonatomic , strong)UILabel *nameLb;
@property(nonatomic , strong)UIButton *renZhengBt;
@property(nonatomic , strong)UIButton *jinDianBt;
@property(nonatomic , strong)UIScrollView *scrollview;

@property(nonatomic , strong)UIView *headV;

@end


@implementation SWTMineGuanZHuDinaPuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = WhiteColor;
        view.layer.cornerRadius = 3;
        view.clipsToBounds = YES;
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.bottom.right.equalTo(self).offset(-15);
            make.top.equalTo(self);
        }];
       
        self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-30, 30)];
        self.headV.backgroundColor = WhiteColor;
        [view addSubview:self.headV];
        [self addSubV];
        [self setCons];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(90, 134);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        layout.headerReferenceSize = CGSizeMake(0, 0);
        layout.footerReferenceSize = CGSizeMake(0, 0);
        
        UIScrollView * scrollView  =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, ScreenW - 30, 134)];
        [view addSubview:scrollView];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollview = scrollView;
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW - 30, 134) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:self.collectionView];
        [self.collectionView registerNib:[UINib nibWithNibName:@"SWTGuanZhuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)addSubV {
    
    self.headBt = [[UIButton alloc] init];
    self.headBt.layer.cornerRadius = 10;
    self.headBt.clipsToBounds = YES;
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    
    self.headBt.tag = 0;
    [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

    self.nameLb =[[UILabel alloc] init];
    self.nameLb.font = kFont(13);
    self.nameLb.text = @"货物优选";
    self.nameLb.textColor = CharacterColor50;
    
    self.renZhengBt =[[UIButton alloc] init];
    [self.renZhengBt setTitle:@" 官方" forState:UIControlStateNormal];
    self.renZhengBt.titleLabel.font = kFont(10);
    [self.renZhengBt setImage:[UIImage imageNamed:@"kkrenzheng"] forState:UIControlStateNormal];
    [self.renZhengBt setTitleColor:CharacterColor153 forState:UIControlStateNormal];
    
    self.jinDianBt =[[UIButton alloc] init];
    [self.jinDianBt setBackgroundImage:[UIImage imageNamed:@"jindian"] forState:UIControlStateNormal];
    self.jinDianBt.tag = 1;
       [self.jinDianBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
}

- (void)clickAction:(UIButton *)button {
   if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickGuanZhuDianPuView:withIndex:isClickHead:)]) {
       [self.delegate didClickGuanZhuDianPuView:self withIndex:button.tag isClickHead:YES];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    self.collectionView.size = CGSizeMake(100 * (self.dataArray.count), 134);
    self.scrollview.contentSize = CGSizeMake(100 * (self.dataArray.count), 134);
    [self.collectionView reloadData];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SWTGuanZhuCollectionCell * cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickGuanZhuDianPuView:withIndex:isClickHead:)]) {
        [self.delegate didClickGuanZhuDianPuView:self withIndex:indexPath.row isClickHead:NO];
    }
    
}

- (void)setCons {
    
    [self.headV addSubview:self.headBt];
    [self.headV addSubview:self.nameLb];
    [self.headV addSubview:self.renZhengBt];
    [self.headV addSubview:self.jinDianBt];
    
    [self.headBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.headV).offset(5);
        make.height.width.equalTo(@20);
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headBt.mas_right).offset(5);
        make.centerY.equalTo(self.headV);
        make.height.equalTo(@20);
    }];
    
    [self.renZhengBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headV);
        make.left.equalTo(self.nameLb.mas_right).offset(8);
        make.height.equalTo(@20);
    }];
    
    [self.jinDianBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headV);
        make.width.equalTo(@40);
        make.height.equalTo(@15);
        make.right.equalTo(self.headV).offset(-5);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end

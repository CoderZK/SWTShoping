//
//  SWTHeMaiDianPuShowVIew.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiDianPuShowVIew.h"
#import "SWTHeMaiDianPuOneCell.h"

@interface SWTHeMaiDianPuShowVIew()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIView *redV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *headBt,*dianPuBt;
@property(nonatomic , strong)UILabel *shopNameLB,*typeLB;

@end

@implementation SWTHeMaiDianPuShowVIew

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
       
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 380)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.whiteV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)].CGPath;
            self.whiteV.layer.mask = shapeLayer;

        
        
        self.redV = [[UIView alloc] init];
        self.redV.backgroundColor = RedBackColor;
        [self.whiteV addSubview:self.redV];
        
        
        self.headBt = [[UIButton alloc] init];
        self.headBt.layer.cornerRadius = 17.5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self.redV addSubview:self.headBt];
        
        self.shopNameLB = [[UILabel alloc] init];
        self.shopNameLB.textColor = CharacterColor50;
        self.shopNameLB.font = kFont(14);
        self.shopNameLB.text = @"玉成其美";
        [self.redV addSubview:self.shopNameLB];
        
        self.typeLB = [[UILabel alloc] init];
        self.typeLB.font = kFont(12);
        self.typeLB.textColor = CharacterColor102;
        self.typeLB.text = @"官方品质";
        [self.redV addSubview:self.typeLB];
        
        
        self.dianPuBt = [[UIButton alloc] init];
        [self.dianPuBt setBackgroundImage:[UIImage imageNamed:@"bg_jrzbj"] forState:UIControlStateNormal];
        self.dianPuBt.layer.cornerRadius = 15;
        self.dianPuBt.clipsToBounds = YES;
        [self.dianPuBt setTitle:@"店铺" forState:UIControlStateNormal];
        self.dianPuBt.titleLabel.font = kFont(14);
        [self.dianPuBt  addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.redV addSubview:self.dianPuBt];
        
        self.tableView   = [[UITableView alloc] init];
        self.tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.whiteV addSubview:_tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTHeMaiDianPuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];

        
        [self.redV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.whiteV);
            make.height.equalTo(@65);
        }];
        
        [self.headBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.redV).offset(15);
            make.width.height.equalTo(@35);
        }];
        [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headBt.mas_right).offset(5);
            make.height.equalTo(@17);
            make.top.equalTo(self.headBt);
        }];
        
        [self.typeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopNameLB);
            make.top.equalTo(self.shopNameLB.mas_bottom).offset(3);
            make.height.equalTo(@15);
        }];
        
        
        [self.dianPuBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.redV).offset(-15);
            make.centerY.equalTo(self.headBt);
            make.height.equalTo(@30);
            make.width.equalTo(@70);
        }];
        
        
  
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.top.equalTo(self.redV.mas_bottom);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.whiteV).offset(-34);
            }else {
                make.bottom.equalTo(self.whiteV);
            }
            
        }];
        
        
        [LSTTimer addTimerForTime:7200 identifier:@"listTimer" handle:nil];
           //配置通知发送和计时任务绑定 没有配置 就不会有通知发送
           [LSTTimer setNotificationForName:@"ListChangeNF" identifier:@"listTimer" changeNFType:LSTTimerSecondChangeNFTypeMS];
        
        
    }
    
    return self;
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 380;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [LSTTimer removeAllTimer];
    [LSTTimer removeTimerForIdentifier:@"listTimer"];
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTHeMaiDianPuOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SWTModel * model = self.dataArray[indexPath.row];
    [cell.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
       cell.titleLB.text = model.name;
        cell.jiaJiaLB.text =  [NSString stringWithFormat:@"￥%@",model.price];
    cell.numberLB.text =  [NSString stringWithFormat:@"%@/%@",model.isbuynum,model.num];
    
    NSTimeInterval  timeV = [NSString pleaseInsertStarTime:[NSString getDateWithDate:[NSDate date]] andInsertEndTime:model.starttime];
    
//    [cell.timeBt setTitle: [NSString stringWithFormat:@"%@    %@",[model.starttime substringToIndex:10],[model.endtime substringToIndex:10]] forState:UIControlStateNormal];
    cell.timeInterval = [NSString pleaseInsertEndTime:model.endtime] > 0 ?  [NSString pleaseInsertEndTime:model.endtime] : 0;;
    cell.rightBt.userInteractionEnabled = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SWTModel * model = self.dataArray[indexPath.row];
    if (model.resttimes.floatValue <= 0) {
        [SVProgressHUD showErrorWithStatus:@"商品已经结束"];
        return;
    }
    if (model.num.intValue == model.isbuynum.intValue) {
        [SVProgressHUD showSuccessWithStatus:@"商品已经被买走"];
        return;
    }
    
    
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(indexPath.row + 200)];
       }
    
    
}

- (void)clickAction:(UIButton *)button  {
     
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(100)];
    }
}

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    
    
}

- (void)setDataModel:(SWTModel *)dataModel {
    _dataModel = dataModel;
    [self.headBt sd_setBackgroundImageWithURL:[dataModel.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.shopNameLB.text = dataModel.name;
    
    
    
    
}

@end

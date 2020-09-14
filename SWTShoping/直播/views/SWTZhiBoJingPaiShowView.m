//
//  SWTZhiBoJingPaiShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoJingPaiShowView.h"
#import "SWTZhiBoJingPaiShowCell.h"
@interface SWTZhiBoJingPaiShowView()<UITableViewDelegate,UITableViewDataSource,SWTZhiBoJingPaiShowCellDelegate>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIView *redV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *headBt,*dianPuBt;
@property(nonatomic , strong)UILabel *shopNameLB,*typeLB;
@property(nonatomic , strong)UIButton *leftBtBt,*rightBt;
@property(nonatomic , assign)NSInteger  type;
@end




@implementation SWTZhiBoJingPaiShowView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 420)];
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
        self.dianPuBt.tag = 99;
        [self.dianPuBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.redV addSubview:self.dianPuBt];
        
        
        self.leftBtBt = [[UIButton alloc] init];
        [self.leftBtBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.leftBtBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.leftBtBt.selected = YES;
        self.leftBtBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.leftBtBt];
        [self.leftBtBt setTitle:@"竞拍" forState:UIControlStateNormal];
        self.leftBtBt.tag = 100;
        [self.leftBtBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        self.rightBt = [[UIButton alloc] init];
        [self.rightBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.rightBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.rightBt];
        [self.rightBt setTitle:@"一口价" forState:UIControlStateNormal];
        self.rightBt.tag = 101;
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView   = [[UITableView alloc] init];
        self.tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.whiteV addSubview:_tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTZhiBoJingPaiShowCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        
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
        
        [self.leftBtBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV);
            make.top.equalTo(self.redV.mas_bottom).offset(10);
            make.height.equalTo(@40);
            make.width.equalTo(@(ScreenW /2));
        }];
        
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteV);
            make.top.equalTo(self.leftBtBt);
            make.height.equalTo(@40);
            make.width.equalTo(@(ScreenW /2));
        }];
        
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.top.equalTo(self.leftBtBt.mas_bottom);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.whiteV).offset(-34);
            }else {
                make.bottom.equalTo(self.whiteV);
            }
            
        }];
        
        
    }
    
    return self;
}

- (void)didSelectShuaXinWithCell:(SWTZhiBoJingPaiShowCell *)cell {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    SWTModel * model = self.dataArray[indexPath.row];
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodid"] = model.ID;
    [zkRequestTool networkingPOST:liveNowgoodprice_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD dismiss];
            model.productprice = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            
            [self.tableView reloadData];
            
            
        }else {
            [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
    }];
    
    
}

- (void)clickAction:(UIButton *)button  {
    if (button.tag == 100) {
        self.leftBtBt.selected = YES;
        self.rightBt.selected = NO;
        self.type = 0;
    }else if (button.tag == 101){
        self.leftBtBt.selected = NO;
        self.rightBt.selected = YES;
        self.type = 1;
    }
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 420;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTZhiBoJingPaiShowCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.dataArray[indexPath.row].isJiPai = self.isJiPai;
    cell.model= self.dataArray[indexPath.row];
    cell.delegate = self;
    if (self.type == 0) {
        [cell.rightBt setTitle:@"出个价" forState:UIControlStateNormal];
    }else {
        [cell.rightBt setTitle:@"购买" forState:UIControlStateNormal];
    }
    cell.rightBt.userInteractionEnabled = NO;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(indexPath.row + 200)];
    }
    
}

- (void)setDataModel:(SWTModel *)dataModel {
    _dataModel = dataModel;
    [self.headBt sd_setBackgroundImageWithURL:[dataModel.avatar getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.shopNameLB.text = dataModel.name;
}


@end

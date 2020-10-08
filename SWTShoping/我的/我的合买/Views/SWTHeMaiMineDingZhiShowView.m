//
//  SWTHeMaiMineDingZhiShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaiMineDingZhiShowView.h"
#import "SWTHeMaiDianPuOneCell.h"
#import "SWTHeMaiDianPuOneCell.h"
@interface SWTHeMaiMineDingZhiShowView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *leftBtBt,*rightBt;

@property(nonatomic , assign)NSInteger  type;


@end

@implementation SWTHeMaiMineDingZhiShowView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 380)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:closeBt];
        
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, ScreenW, 17)];
        lb.font = kFont(15);
        lb.textColor = CharacterColor50;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"我的合买定制";
        [self.whiteV addSubview:lb];
        
        UIView * lineV = [[UIView alloc] init];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        self.leftBtBt = [[UIButton alloc] init];
        [self.leftBtBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.leftBtBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.leftBtBt.selected = YES;
        self.leftBtBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.leftBtBt];
        [self.leftBtBt setTitle:@"合买中" forState:UIControlStateNormal];
        self.leftBtBt.tag = 100;
        [self.leftBtBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        self.rightBt = [[UIButton alloc] init];
        [self.rightBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.rightBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.rightBt];
        [self.rightBt setTitle:@"待完成" forState:UIControlStateNormal];
        self.rightBt.tag = 101;
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView   = [[UITableView alloc] init];
        self.tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.whiteV addSubview:_tableView];
        
        //        [self.tableView registerNib:[UINib nibWithNibName:@"SWTHeMaiDianPuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTHeMaiDianPuOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.width.equalTo(@30);
            make.right.equalTo(self.whiteV).offset(-5);
            make.top.equalTo(self.whiteV).offset(5);
        }];
        
        
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(closeBt.mas_bottom).offset(10);
            make.left.right.equalTo(self.whiteV);
            make.height.equalTo(@20);
        }];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.height.equalTo(@0.5);
            make.top.equalTo(lb.mas_bottom).offset(10);
        }];
        
        [self.leftBtBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV);
            make.top.equalTo(lb.mas_bottom).offset(10);
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
        
        
//        [LSTTimer addTimerForTime:7200 identifier:@"listTimer" handle:nil];
//        //配置通知发送和计时任务绑定 没有配置 就不会有通知发送
//        [LSTTimer setNotificationForName:@"ListChangeNF" identifier:@"listTimer" changeNFType:LSTTimerSecondChangeNFTypeMS];
        
    }
    
    return self;
}


- (void)clickAction:(UIButton *)button  {
    if (button.tag == 100) {
        self.leftBtBt.selected = YES;
        self.rightBt.selected = NO;
    }else {
        self.leftBtBt.selected = NO;
        self.rightBt.selected = YES;
    }
    self.type = button.tag-100;
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 380;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
//    [LSTTimer removeAllTimer];
//       [LSTTimer removeTimerForIdentifier:@"listTimer"];
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
    cell.titleLB.text = model.goodname;
    cell.jiaJiaLB.text =  [NSString stringWithFormat:@"￥%@",model.chipped_price.getPriceAllStr];
    cell.numberLB.text =  [NSString stringWithFormat:@"%@/%@",model.isbuynum,model.chipped_num];
    cell.rightBt.hidden = self.type;
    //    [cell.timeBt setTitle: @"已完成" forState:UIControlStateNormal];
    if (model.sharedict.count > 0) {
        [cell.timeBt setTitle:[NSString stringWithFormat:@"%@小时后商家未发布抽签将自动退款",model.sharedict[0].value] forState:UIControlStateNormal];
    }else {
        [cell.timeBt setTitle: @"" forState:UIControlStateNormal];
    }
    cell.rightBt.tag = indexPath.row;
    [cell.rightBt addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)action:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(indexPath.row + 200)];
    }
    
}

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    
    [self.tableView reloadData];
    
    
}

@end

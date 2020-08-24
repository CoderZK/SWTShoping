//
//  SWTChanPinSearchView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTChanPinSearchView.h"
#import "SWTShaiXuanBtView.h"
@interface SWTChanPinSearchView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITextField *nameTF,*biaoHaoTF,*diJiaTF,*gaoJiaTF;

@end


@implementation SWTChanPinSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        
        self.tableView = [[UITableView alloc] init];
        [self.whiteV addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.whiteV);
        }];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        
    }
    
    return self;
}

- (void)initHeadV {
    self.leiBieID = self.chanPinKuID = self.timeType = self.feiLeiID = @"";
    [self.headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    self.headView.clipsToBounds = YES;
    if (self.type == 0) {
        self.headView.mj_h = 0;
        self.tableView.tableHeaderView = self.headView;
    }  else  if (self.type == 1) {
        
        

        
        NSMutableArray * arrTwo = @[].mutableCopy;
        for (SWTModel * mm  in self.canPinKuArr) {
            [arrTwo addObject:mm.name];
        }
        
        [arrTwo addObject:@"全部"];
        
        SWTShaiXuanBtView * cangKu  = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10,  10 , ScreenW - 20 , 20)];
        [self.headView addSubview:cangKu];
        cangKu.isNOCanSelectAll = YES;
        cangKu.isTitleArr = YES;
        cangKu.dataArray = arrTwo;
        Weak(weakSelf);
        cangKu.mj_h = cangKu.hh;
        cangKu.selectBlock = ^(NSInteger index) {
            if (index == self.canPinKuArr.count) {
                self.chanPinKuID = @"";
            }else {
                self.chanPinKuID = self.canPinKuArr[index].ID;
            }
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:self.chanPinKuID];
            }
        };
    
        self.headView.mj_h = 300;
        self.tableView.tableHeaderView = self.headView;
        
    }else if (self.type == 2) {
        //筛选
        UILabel * LB2  =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 20)];
        LB2.text = @"产品类别";
        LB2.font = kFont(15);
        [self.headView addSubview:LB2];
        
        NSArray * arr = @[@"一口价",@"拍即得",@"全部"];
        
        SWTShaiXuanBtView * chanpinLeiBie  = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(LB2.frame) + 10 , ScreenW - 20 , 20)];
        [self.headView addSubview:chanpinLeiBie];
        chanpinLeiBie.isTitleArr = YES;
        chanpinLeiBie.isNOCanSelectAll = YES;
        chanpinLeiBie.dataArray = arr;
        Weak(weakSelf);
        chanpinLeiBie.mj_h = chanpinLeiBie.hh;
        chanpinLeiBie.selectBlock = ^(NSInteger index){
            if (index == 2) {
                self.leiBieID = @"";
            }else {
                self.leiBieID =  [NSString stringWithFormat:@"%ld",index];
            }
        };
        
        
        UILabel * LB3  =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(chanpinLeiBie.frame), ScreenW - 20, 20)];
        LB3.text = @"产品分类";
        LB3.font = kFont(15);
        [self.headView addSubview:LB3];
        
          NSMutableArray * arrThree = @[].mutableCopy;
              for (SWTModel * mm  in self.canPinFenLeiArr) {
                  [arrThree addObject:mm.name];
              }
              
              [arrThree addObject:@"全部"];
        
        SWTShaiXuanBtView * chanpinFenLei  = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(LB3.frame) + 10 , ScreenW - 20 , 20)];
        [self.headView addSubview:chanpinFenLei];
        chanpinFenLei.isTitleArr = YES;
        chanpinFenLei.isNOCanSelectAll = YES;
        chanpinFenLei.dataArray = arrThree;
        
        chanpinFenLei.mj_h = chanpinFenLei.hh;
        chanpinFenLei.selectBlock = ^(NSInteger index){
            if (index == self.canPinFenLeiArr.count) {
                self.feiLeiID = @"";
            }else {
                self.feiLeiID = self.canPinFenLeiArr[index].ID;
            }
        };
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(chanpinFenLei.frame), ScreenW - 30, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self.headView addSubview:backV];
        
        UILabel * lb  = [[UILabel alloc] init];
        lb.font = kFont(14);
        lb.text = @"产品名称";
        lb.frame = CGRectMake(15, CGRectGetMaxY(backV.frame)+15, 80, 20);
        [self.headView addSubview:lb];
        
        UITextField * TF  = [[UITextField alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(backV.frame)+10, ScreenW - 120, 30)];
        TF.font = kFont(14);
        TF.placeholder = @"根据产品名搜索";
        self.nameTF = TF;
        [self.headView addSubview:TF];
        
        
        UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(TF.frame) + 10, ScreenW - 30, 0.6)];
        backV1.backgroundColor = lineBackColor;
        [self.headView addSubview:backV1];
        
        UILabel * lb1  = [[UILabel alloc] init];
        lb1.font = kFont(14);
        lb1.text = @"产品编号";
        lb1.frame = CGRectMake(15, CGRectGetMaxY(backV1.frame)+15, 80, 20);
        [self.headView addSubview:lb1];
        
        UITextField * TF1  = [[UITextField alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(backV1.frame)+10, ScreenW - 120, 30)];
        TF1.font = kFont(14);
        TF1.placeholder = @"根据产品编号搜索";
        self.biaoHaoTF = TF1;
        [self.headView addSubview:TF1];
        
        UIView * backV2 =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(TF1.frame) + 10, ScreenW - 30, 0.6)];
        backV2.backgroundColor = lineBackColor;
        [self.headView addSubview:backV2];
        
        UILabel * lb2  = [[UILabel alloc] init];
        lb2.font = kFont(14);
        lb2.text = @"价格";
        lb2.frame = CGRectMake(15, CGRectGetMaxY(backV2.frame)+15, 80, 20);
        [self.headView addSubview:lb2];
        
        UILabel * lb3  = [[UILabel alloc] init];
        lb3.font = kFont(14);
        lb3.text = @"至";
        lb3.textAlignment = NSTextAlignmentCenter;
        lb3.frame = CGRectMake((ScreenW - 60)/2, CGRectGetMaxY(lb2.frame)+15, 60, 20);
        [self.headView addSubview:lb3];
        
        
        UITextField * TF2  = [[UITextField alloc] initWithFrame:CGRectMake((ScreenW )/2 - 30 - 150, CGRectGetMaxY(lb2.frame)+10, 150, 30)];
        TF2.font = kFont(14);
        TF2.placeholder = @"最低价";
        self.diJiaTF = TF2;
        TF2.textAlignment = NSTextAlignmentRight;
        TF2.keyboardType = UIKeyboardTypeDecimalPad;
        [self.headView addSubview:TF2];
        
        UITextField * TF3  = [[UITextField alloc] initWithFrame:CGRectMake((ScreenW)/2 + 30 , CGRectGetMaxY(lb2.frame)+10, 150, 30)];
        TF3.font = kFont(14);
        TF3.placeholder = @"最高价";
        TF3.textAlignment = NSTextAlignmentLeft;
        TF3.keyboardType = UIKeyboardTypeDecimalPad;
        [self.headView addSubview:TF3];
        self.gaoJiaTF = TF3;
        
        
        UILabel * LB4  =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(TF3.frame) + 10, ScreenW - 20, 20)];
        LB4.text = @"创建时间";
        LB4.font = kFont(15);
        [self.headView addSubview:LB4];
        
        NSArray * arr3 =@[@"今天",@"近7天",@"近30天",@"全部"] ;
        
        SWTShaiXuanBtView * timeV  = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(LB4.frame) + 10 , ScreenW - 20 , 20)];
        [self.headView addSubview:timeV];
        timeV.isTitleArr = YES;
        timeV.isNOCanSelectAll = YES;
        timeV.dataArray = arr3;
        
        timeV.mj_h = timeV.hh;
        timeV.selectBlock = ^(NSInteger index){
            self.timeType =  [NSString stringWithFormat:@"%ld",index+1];
        };
        
        UIButton * chongzhiBt  =[[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 2 - 20 - 70, CGRectGetMaxY(timeV.frame) + 15, 70, 30)];
        chongzhiBt.backgroundColor = UIColor.groupTableViewBackgroundColor;
        [chongzhiBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chongzhiBt setTitle:@"重置" forState:UIControlStateNormal];
        chongzhiBt.titleLabel.font = kFont(14);
        chongzhiBt.tag = 100;
        [chongzhiBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * confirmBt  =[[UIButton alloc] initWithFrame:CGRectMake(ScreenW / 2 +20, CGRectGetMaxY(timeV.frame) + 15, 70, 30)];
        confirmBt.backgroundColor = GreenColor;
        [confirmBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [confirmBt setTitle:@"确定" forState:UIControlStateNormal];
        confirmBt.titleLabel.font = kFont(14);
        confirmBt.tag = 101;
        [confirmBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.headView addSubview:chongzhiBt];
        [self.headView addSubview:confirmBt];
        self.headView.mj_h = CGRectGetMaxY(confirmBt.frame) + 30;
        self.whiteV.mj_h = self.frame.size.height;
        self.tableView.tableHeaderView = self.headView;
    }
    [self.tableView reloadData];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (void)setType:(NSInteger)type {
    _type = type;
    [self initHeadV];
}

- (void)clickAction:(UIButton *)button {
    if (button.tag == 100) {
        self.type = 2;
        self.leiBieID = self.chanPinKuID = self.timeType = self.feiLeiID = @"";
        
        
    }else {
        
        NSMutableDictionary  * dict = @{}.mutableCopy;
        dict[@"type"] = self.leiBieID;
        dict[@"category_id"] = self.feiLeiID;
        dict[@"sn"] = self.biaoHaoTF.text;
        dict[@"title"] = self.nameTF.text;
        dict[@"price_start"] = self.diJiaTF.text;
        dict[@"price_end"] = self.gaoJiaTF.text;
        dict[@"date"] = self.timeType;
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:dict];
        }
        
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = 0;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = -500;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(indexPath.row)];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end

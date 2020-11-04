//
//  SWTMJAddCHanPinKuSHowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddCHanPinKuSHowView.h"
#import "SWTMJAddChanPinNeiCell.h"
#import "SWTShaiXuanBtView.h"
@interface SWTMJAddCHanPinKuSHowView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UILabel *titleLB,*LB2;
@property(nonatomic , strong)UIView  *headV;
@property(nonatomic,assign)BOOL isNeiXuan;
@property(nonatomic , strong)SWTShaiXuanBtView *pvvv;
@property(nonatomic , strong)SWTModel *selectModel;
@end

@implementation SWTMJAddCHanPinKuSHowView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 450)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        
        
        UIButton * closeBt  =[[UIButton alloc] init];
        [closeBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [closeBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:closeBt];
        
        [closeBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@30);
            make.right.equalTo(self.whiteV).offset(-10);
            make.top.equalTo(self.whiteV).offset(10);
        }];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, ScreenW, 17)];
        lb.font = kFont(15);
        lb.textColor = CharacterColor50;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"品名";
        [self.whiteV addSubview:lb];
        
        UIView * lineV = [[UIView alloc] init];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteV).offset(-15);
            make.left.equalTo(self.whiteV).offset(15);
            make.top.equalTo(self.whiteV).offset(50);
            make.height.equalTo(@0.5);
        }];
        
        
        UILabel * lb2 = [[UILabel alloc] init];
        lb2.font = kFont(15);
        lb2.textColor = CharacterColor50;
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.text = @"请慎重选择,无跨品类";
        [self.whiteV addSubview:lb2];
        self.LB2 = lb2;
        
        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.top.equalTo(lineV.mas_bottom).offset(15);
            make.height.equalTo(@17);
        }];
        
        
        self.tableView = [[UITableView alloc] init];
        [self.whiteV addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.whiteV);
            make.top.equalTo(lb2.mas_bottom).offset(5);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJAddChanPinNeiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
        self.tableView.tableHeaderView = self.headV;
        
    }
    
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isNeiXuan) {
        return 0;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJAddChanPinNeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.dataArray[indexPath.row].name;
    cell.leftBt.tag = indexPath.row;
    [cell.leftBt addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.clipsToBounds = YES;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.titleLB.text = self.dataArray[indexPath.row].name;
    self.selectModel = self.dataArray[indexPath.row];
    self.LB2.text = @"请选择二级分类";
    self.isNeiXuan  = YES;
    
    [self.headV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray * arr2 =@[].mutableCopy;
    for (SWTModel * mNei in self.dataArray[indexPath.row].children) {
        [arr2 addObject:mNei.name];
    }
    
    self.pvvv  = [[SWTShaiXuanBtView alloc] initWithFrame:CGRectMake(10, 10 , ScreenW - 20 , 20)];
    [self.headV addSubview:self.pvvv];
    self.pvvv.isTitleArr = YES;
    self.pvvv.isNOCanSelectAll = YES;
    self.pvvv.dataArray = arr2;
    
    self.pvvv.mj_h = self.pvvv.hh;
    Weak(weakSelf);
    self.pvvv.selectBlock = ^(NSInteger index){
        [weakSelf click];
    };
    [self.headV addSubview:self.pvvv];
    self.headV.mj_h = CGRectGetMaxY(self.pvvv.frame) + 10;
    self.tableView.tableHeaderView = self.headV;
    [self.tableView reloadData];
}


- (void)click {
    
    for (int i = 0 ; i < self.selectModel.children.count; i++) {
        UIButton * bt = (UIButton *)[self.pvvv viewWithTag:i+100];
        if (bt.selected) {
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@{@"idone":self.selectModel.ID,@"idtwo":self.selectModel.children[i].ID,@"name":self.selectModel.children[i].name}];
                [self dismiss];
            }
            break;
        }
    }
    
}

- (void)leftAction:(UIButton *)button {
    SWTModel * model = self.dataArray[button.tag];
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@{@"idone":model.ID,@"idtwo":model.ID,@"name":model.name}];
            [self dismiss];
    }
    
}


- (void)action:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag)];
    }
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 450;
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



@end

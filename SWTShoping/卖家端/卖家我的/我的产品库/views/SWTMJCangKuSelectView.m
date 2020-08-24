//
//  SWTMJCangKuSelectView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJCangKuSelectView.h"
#import "SWTMJChanPinKuNeiCell.h"
#import "SWTShaiXuanBtView.h"
@interface SWTMJCangKuSelectView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *cancelBt,*confirmBt;

@end

@implementation SWTMJCangKuSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 450)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        
        self.cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(15,10, 50, 40)];
               [self.cancelBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               self.cancelBt.tag = 100;
               [self.cancelBt setTitle:@"取消" forState:UIControlStateNormal];
               [self.cancelBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
               [self.whiteV addSubview:self.cancelBt];
               
               self.confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 65, 10, 50, 40)];
               [self.confirmBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
               self.confirmBt.tag = 101;
               [self.confirmBt setTitle:@"确定" forState:UIControlStateNormal];
               [self.confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
              [self.whiteV addSubview:self.confirmBt];
        
       
        
        UIView * lineV = [[UIView alloc] init];
        lineV.backgroundColor = lineBackColor;
        [self.whiteV addSubview:lineV];
        
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.whiteV).offset(-15);
            make.left.equalTo(self.whiteV).offset(15);
            make.top.equalTo(self.whiteV).offset(50);
            make.height.equalTo(@0.5);
        }];
        
        
        
      
        
        self.tableView = [[UITableView alloc] init];
        [self.whiteV addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.whiteV);
            make.top.equalTo(lineV.mas_bottom).offset(5);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJChanPinKuNeiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
      
        
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
  
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJChanPinKuNeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row].name;
    if (self.dataArray[indexPath.row].isSelect) {
        cell.imgV.image = [UIImage imageNamed:@"bbdyx34"];
    }else {
        cell.imgV.image = [UIImage imageNamed:@"dyx44"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.dataArray[indexPath.row].isSelect = !self.dataArray[indexPath.row].isSelect;
    [self.tableView reloadData];
    
}


- (void)confirmAction {
    
    
    NSMutableArray * arr = @[].mutableCopy;
    for (SWTModel * model  in self.dataArray) {
        if (model.isSelect) {
            [arr addObject:model];
        }
    }
    if (arr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"至少要选择一个"];
        return;
    }
    [self dismiss];
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:arr];
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

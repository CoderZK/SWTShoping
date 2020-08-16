//
//  SWTMJAddVideoTypeShowView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJAddVideoTypeShowView.h"
#import "SWTAddVideoTypeCell.h"
@interface SWTMJAddVideoTypeShowView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UITextField *TF;
@property(nonatomic , strong)UIButton *confirmBt,*cancelBt;

@property(nonatomic , strong)UILabel *titleLB;
@property(nonatomic , strong)UIView  *headV;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIView *footView;
@property(nonatomic , strong)ALCSearchView *searchTitleView;
@end

@implementation SWTMJAddVideoTypeShowView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
 
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 500)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
      
        
        UILabel * lb  = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenW - 40, 20)];
        lb.text = @"视频分类";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(14);
        [self.whiteV addSubview:lb];
        self.titleLB = lb;
        
     
        self.cancelBt = [[UIButton alloc] initWithFrame:CGRectMake(15, 50, 50, 40)];
        [self.cancelBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.cancelBt.tag = 100;
        [self.cancelBt setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteV addSubview:self.cancelBt];
        
        self.confirmBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 65, 50, 50, 40)];
        [self.confirmBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.confirmBt.tag = 101;
        [self.confirmBt setTitle:@"确定" forState:UIControlStateNormal];
        [self.confirmBt addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
       [self.whiteV addSubview:self.confirmBt];
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTAddVideoTypeCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.whiteV addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.whiteV);
            make.top.equalTo(self.whiteV).offset(100);
        }];
        
    }
    
    return self;
}

- (void)initheadV {
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    
    self.searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 35)];
    self.searchTitleView.searchTF.delegate = self;
    
    self.searchTitleView.isPush = NO;
    self.searchTitleView.isBlack = YES;
    self.searchTitleView.searchTF.placeholder = @"请输入商品名称";
    
    
    @weakify(self);
    [[[self.searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
    }];
    [self.headV addSubview:self.searchTitleView];
    
    self.tableView.tableHeaderView = self.headV;
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 0) {
        self.titleLB.text = @"视频分类";
    }else if (type == 1) {
        self.titleLB.text = @"关联商品";
        [self initheadV];
    }
}

- (void)confirmAction{
   
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:self.TF.text];
    }
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 500;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTAddVideoTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



@end

//
//  SWTMJMineChanPinListTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineChanPinListTVC.h"
#import "SWTMJSearchBt.h"
#import "SWTMJChanPinListCell.h"
#import "SWTChanPinSearchView.h"
@interface SWTMJMineChanPinListTVC ()
@property(nonatomic , strong)UIView *seacrchV;
@property(nonatomic , strong)SWTMJSearchBt *leftBt,*centerBt,*rightBt;

@end

@implementation SWTMJMineChanPinListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"产品列表";
    
    [self initHeadV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJChanPinListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)initHeadV  {
    self.seacrchV = [[UIView alloc] init];
    [self.view addSubview:self.seacrchV];
    self.seacrchV.backgroundColor = [UIColor whiteColor];
  
   
    
    [self.seacrchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@50);
        
    }];
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.5, ScreenW, 0.5)];
      backV.backgroundColor = lineBackColor;
     [self.seacrchV addSubview:backV];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.seacrchV.mas_bottom);
    }];
    
    CGFloat ww = [@"我" getWidhtWithFontSize:14];
    
    CGFloat space = (ScreenW - 40 - 11*ww - 30)/2.0;
    
    self.leftBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(20, 5, ww * 6 + 10, 40)];
    self.leftBt.tag = 100;
    [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBt.textLB.text = @"入库时间升序";
    [self.seacrchV addSubview:self.leftBt];
    
    self.centerBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftBt.frame) + space, 5, ww * 3 + 10, 40)];
    self.centerBt.tag = 101;
    [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.centerBt.textLB.text = @"产品库";
    [self.seacrchV addSubview:self.centerBt];
    
    self.rightBt = [[SWTMJSearchBt alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.centerBt.frame) + space, 5, ww * 2 + 10, 40)];
      self.rightBt.tag = 102;
      [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
      self.rightBt.textLB.text = @"筛选";
      [self.seacrchV addSubview:self.rightBt];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJChanPinListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)clickAction:(UIButton *)button {
    SWTChanPinSearchView *searchV  = [[SWTChanPinSearchView alloc] initWithFrame:CGRectMake(0,sstatusHeight + 50 + 44, ScreenW, ScreenH - (sstatusHeight + 50 + 44) )];
    
    searchV.type = button.tag -100;
    if (button.tag == 100) {
        searchV.dataArray = @[@"升序",@"降序"];
    }else {
        searchV.dataArray = @[];
    }
    [searchV show];
}

@end

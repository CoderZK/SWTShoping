//
//  SWTFenLeiFirstVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/2.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTFenLeiFirstVC.h"
#import "SWTFenLeiFirstLeftCell.h"
@interface SWTFenLeiFirstVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView *leftV,*rightTV;
@end

@implementation SWTFenLeiFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    
    [self setNavigateView];
    
   
    
    
    [self addTV];
}

- (void)addTV {
    
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenW, 0.5)];
       backV.backgroundColor = lineBackColor;
       [self.view addSubview:backV];
       

       UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(99.5, 40, 0.5, ScreenH - sstatusHeight - 44 - 40)];
       backVTwo.backgroundColor = lineBackColor;
       [self.view addSubview:backVTwo];
    
    self.leftV  =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, 99, ScreenH - sstatusHeight - 44 - 40)];
    [self.leftV registerNib:[UINib nibWithNibName:@"SWTFenLeiFirstLeftCell" bundle:nil] forCellReuseIdentifier:@"SWTFenLeiFirstLeftCell"];
    self.leftV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.leftV.delegate = self;
    self.leftV.dataSource = self;
    [self.view addSubview:self.leftV];
    
    
    
}




- (void)setNavigateView {
    
    ALCSearchView * searchTitleView = [[ALCSearchView alloc] initWithFrame:CGRectMake(15, 0, ScreenW - 30, 35)];
    searchTitleView.searchTF.delegate = self;
    
    searchTitleView.isPush = NO;
    searchTitleView.isBlack = YES;
    searchTitleView.searchTF.placeholder = @"请输入竞拍品";
    
  
    @weakify(self);
    [[[searchTitleView.searchTF rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        @strongify(self);
        if (value.length > 0) {
            return YES;
        }else {
            return NO;
        }
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"======\n%@",x);
    }];
    [self.view addSubview:searchTitleView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTFenLeiFirstLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTFenLeiFirstLeftCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLB.text = @"玉翠珠宝";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


@end

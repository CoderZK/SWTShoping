//
//  SWTGoodsDetailFourCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTGoodsDetailFourCell.h"
#import "SWTGoodsDetailNeiCell.h"

@interface SWTGoodsDetailFourCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UIView *backV;
@property(nonatomic , strong)UITableView *tableView;
@end

@implementation SWTGoodsDetailFourCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
 
        self.backV =[[UIView alloc] init];
        self.backV.backgroundColor = BackgroundColor;
        [self addSubview:self.backV];
        [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
        }];
        
    
        self.tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.backV addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.backV);
            make.top.equalTo(self.backV).offset(10);
        }];
        
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTGoodsDetailNeiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.backV addSubview:self.tableView];

    }
    return self;
}

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count > 3 ? 3:self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTGoodsDetailNeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view==nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 30, 40)];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 30,40)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
        [view addSubview:button];
        [button addTarget:self action:@selector(clickFootV:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100;
    }
    view.clipsToBounds = YES;
    return view;
}


- (void)clickFootV:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"1234"];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.dataArray.count > 3 ? 40:0.01;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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

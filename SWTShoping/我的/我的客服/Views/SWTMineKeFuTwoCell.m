//
//  SWTMineKeFuTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineKeFuTwoCell.h"
#import "SWTKeFuTwoNeiCell.h"

@interface SWTMineKeFuTwoCell()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SWTMineKeFuTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 20;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
        
        self.imgV = [[UIImageView alloc] init];//WithFrame:CGRectMake(55, 10, ScreenW - 100, 40)];
        self.imgV.backgroundColor = WhiteColor;
        self.imgV.userInteractionEnabled = YES;
        
        [self addSubview:self.imgV];
        
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(55);
            make.width.equalTo(@(ScreenW - 100));
            make.bottom.equalTo(self).offset(-10);
        }];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, ScreenW - 130, 17)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.text = @"热门咨询";
        self.titleLB.font = kFont(14);
        [self.imgV addSubview:self.titleLB];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(20, 27, ScreenW - 130, 0.5)];
        self.lineV.backgroundColor = lineBackColor;
        [self.imgV addSubview:self.lineV];
        
        self.tableview = [[UITableView alloc] init];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        [self.tableview registerClass:[SWTKeFuTwoNeiCell class] forCellReuseIdentifier:@"cell"];
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.imgV  addSubview:self.tableview];
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgV).offset(20);
            make.bottom.equalTo(self.imgV).offset(-10);
            make.right.equalTo(self.imgV).offset(-10);
            make.top.equalTo(self.lineV.mas_bottom);
        }];
        
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[NSString stringWithFormat:@" · %@",self.dataArray[indexPath.row]] getHeigtWithFontSize:13 lineSpace:0 width:ScreenW - 140] + 10 ;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTKeFuTwoNeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = [NSString stringWithFormat:@" · %@",self.dataArray[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]]];
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end

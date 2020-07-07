//
//  SWTMineYouHuiQuanCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/7.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineYouHuiQuanCell.h"
#import "SWTMineYouHuiQuanNeiCell.h"
@interface SWTMineYouHuiQuanCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UILabel *shopNameLB;
@end

@implementation SWTMineYouHuiQuanCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * whiteV = [[UIView alloc] init];
        whiteV.layer.cornerRadius = 5;
        whiteV.clipsToBounds = YES;
        whiteV.backgroundColor = WhiteColor;
        [self addSubview:whiteV];
        [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self);
            make.top.equalTo(self).offset(10);
        }];
        
        
        UIImageView * imgV  =[[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"shop1-1"];
        [whiteV addSubview:imgV];
        
        self.shopNameLB  =[[UILabel alloc] init];
        self.shopNameLB.textColor = CharacterColor50;
        self.shopNameLB.font = kFont(14);
        self.shopNameLB.text  = @"水井坊";
        [whiteV addSubview:self.shopNameLB];
        
        UIButton * button  =[[UIButton alloc] init];
        [whiteV addSubview:button];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteV).offset(5);
            make.top.equalTo(whiteV).offset(10);
            make.width.height.equalTo(@20);
        }];
        
        [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgV.mas_right).offset(5);
            make.centerY.equalTo(imgV.mas_centerY);
            make.height.equalTo(@20);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(whiteV).offset(5);
            make.bottom.right.equalTo(whiteV).offset(-5);
        }];
        
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [whiteV addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteV).offset(5);
            make.right.equalTo(whiteV).offset(-5);
            make.top.equalTo(whiteV).offset(40);
            make.bottom.equalTo(whiteV).offset(-10);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineYouHuiQuanNeiCell" bundle:nil] forCellReuseIdentifier:@"SWTMineYouHuiQuanNeiCell"];
     
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineYouHuiQuanNeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineYouHuiQuanNeiCell" forIndexPath:indexPath];
    return cell;
}

- (void)clickAction:(UIButton *)button {
    if (self.clickHeadOrCellBlock != nil) {
           self.clickHeadOrCellBlock(0, NO);
       }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.clickHeadOrCellBlock != nil) {
        self.clickHeadOrCellBlock(indexPath.row, NO);
    }
    
    
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

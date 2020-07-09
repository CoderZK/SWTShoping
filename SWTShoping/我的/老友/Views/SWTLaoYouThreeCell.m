//
//  SWTLaoYouThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouThreeCell.h"
#import "SWTLaoYouDesNeiOneCell.h"
#import "SWTLaoYouDesNeiTwoCell.h"
@interface SWTLaoYouThreeCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIImageView *titleImgV;


@end

@implementation SWTLaoYouThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] init];
        self.whiteV.backgroundColor = WhiteColor;
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        [self addSubview:self.whiteV];
        
        [self.whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(40);
            make.height.equalTo(@1);
            
        }];
        
        self.titleImgV = [[UIImageView alloc] init];
        [self addSubview:self.titleImgV];
        [self.titleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@178);
            make.height.equalTo(@25);
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(27.5);
        }];
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.whiteV addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.top.equalTo(self.whiteV).offset(30);
            make.bottom.equalTo(self.whiteV).offset(-10);
//            make.height.equalTo(@1);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouDesNeiOneCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouDesNeiOneCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouDesNeiTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouDesNeiTwoCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 40;
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    
        
        
        
        
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(self.tableView.contentSize.height+10));
//    }];
    
    NSLog(@"%f",self.tableView.contentSize.height);
    
    [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.tableView.contentSize.height+10 + 40));
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50+indexPath.row * 10;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 1) {
        SWTLaoYouDesNeiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouDesNeiOneCell" forIndexPath:indexPath];
        cell.topV.hidden = cell.bottomV.hidden = NO;
        if (indexPath.row == 0) {
            cell.topV.hidden = YES;
        }else if (indexPath.row + 1 == self.dataArray.count) {
            cell.bottomV.hidden = YES;
        }
        cell.titleLB.text = self.dataArray[indexPath.row];
        self.titleImgV.image = [UIImage imageNamed:@"shop_icon_title3"];
        return cell;
    }else {
        SWTLaoYouDesNeiTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouDesNeiTwoCell" forIndexPath:indexPath];
        cell.imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"shop_icon_%ld",indexPath.row+7]];
        cell.contentLB.text = self.dataArray[indexPath.row];
        self.titleImgV.image = [UIImage imageNamed:@"shop_icon_title4"];
        if (indexPath.row + 1 == self.dataArray.count) {
             NSLog(@"%f",self.tableView.contentSize.height);
            [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.tableView.contentSize.height+10 + 40));
            }];
            
        }
        return cell;
    }

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

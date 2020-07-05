//
//  SWTLaoYouOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouOneCell.h"



@implementation SWTLaoYouOneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.shopNameBt = [[UIButton alloc] init];
        [self.shopNameBt setImage:[UIImage imageNamed:@"shop1-1"] forState:UIControlStateNormal];
        self.shopNameBt.titleLabel.font = kFont(14);
        [self.shopNameBt setTitle:@"水御堂" forState:UIControlStateNormal];
        [self addSubview:self.shopNameBt];
        [self.shopNameBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        self.shopNameBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.leftimgV = [[UIImageView alloc] init];
        self.leftimgV.image = [UIImage imageNamed:@"369"];
        [self addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(13);
        self.leftOneLB.textColor = CharacterColor70;
        [self addSubview:self.leftOneLB];
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(13);
        self.leftTwoLb.textColor = CharacterColor70;
        [self addSubview:self.leftTwoLb];
        
        
        self.leftThreeLB = [[UILabel alloc] init];
        self.leftThreeLB.font = kFont(13);
        self.leftThreeLB.textColor = CharacterColor70;
        [self addSubview:self.leftThreeLB];
        
        self.rightImgV = [[UIImageView alloc] init];
        self.rightImgV.image = [UIImage imageNamed:@"cpjl_yzp"];
        [self addSubview:self.rightImgV];
        
        [self.shopNameBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.height.equalTo(@17);
        }];
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopNameBt.mas_bottom).offset(10);
            make.left.equalTo(self).offset(15);
            make.height.width.equalTo(@85);
        }];
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
            make.height.equalTo(@17);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.leftimgV.mas_right).offset(5);
                   make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
                   make.height.equalTo(@17);
               }];
        
        
        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.leftimgV.mas_right).offset(5);
                   make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
                   make.height.equalTo(@17);
               }];
        
        UIView * backV =[[UIView alloc] init];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
        
        [backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self);
        }];
        
    }
    return self;
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

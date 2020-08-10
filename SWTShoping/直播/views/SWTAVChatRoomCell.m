//
//  SWTAVChatRoomCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAVChatRoomCell.h"



@implementation SWTAVChatRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backV = [[UIView alloc] init];
        self.backV.layer.cornerRadius = 15;
        self.backV.clipsToBounds = YES;
        [self addSubview:self.backV];
        
        self.headImgV = [[UIImageView alloc] init];
        [self.backV addSubview:self.headImgV];
        self.headImgV.layer.cornerRadius = 13;
        self.headImgV.image = [UIImage imageNamed:@"369"];
        self.headImgV.clipsToBounds = YES;
        
        self.leveBt = [[UIButton alloc] init];
        self.leveBt.titleLabel.font = kFont(13);
        self.leveBt.layer.cornerRadius = 8;
        self.leveBt.backgroundColor = RGB(212, 136, 26);
        [self.leveBt setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
        [self.leveBt setTitle:@"2" forState:UIControlStateNormal];
        self.leveBt.clipsToBounds = YES;
        
        [self.backV addSubview:self.leveBt];
        
        
        
        
        self.nameLB = [[UILabel alloc] init];
        self.nameLB.textColor = YellowColor;
        self.nameLB.font = kFont(12);
        self.nameLB.text = @"哈二分法";
        [self.backV addSubview:self.nameLB];
        
        self.contentLB  = [[UILabel alloc] init];
        self.contentLB.textColor = WhiteColor;
        self.contentLB.font = kFont(12);
        self.contentLB.text = @"好的啊啊";
        [self.backV addSubview:self.contentLB];
        
        
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        
        [self.backV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(20);
            make.height.equalTo(@30);
        }];
        
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backV).offset(2);
            make.height.width.equalTo(@26);
            make.centerY.equalTo(self.backV);
        }];
        
        [self.leveBt  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(10);
            make.centerY.equalTo(self.backV);
            make.height.equalTo(@16);
            make.width.equalTo(@40);
        }];
        
        [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leveBt.mas_right).offset(10);
            make.centerY.equalTo(self.backV);
        }];;
        
        [self.contentLB  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLB.mas_right).offset(10);
            make.centerY.equalTo(self.backV);
            make.right.equalTo(self.backV).offset(-10);
        }];;
        
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

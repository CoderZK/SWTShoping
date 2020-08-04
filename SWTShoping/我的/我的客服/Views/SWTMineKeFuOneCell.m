//
//  SWTMineKeFuOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineKeFuOneCell.h"

@implementation SWTMineKeFuOneCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.headBt = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 20;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
        
        self.imgV = [[UIImageView alloc] init];//WithFrame:CGRectMake(55, 10, ScreenW - 100, 40)];
        self.imgV.backgroundColor = WhiteColor;
    
        [self addSubview:self.imgV];
    
        [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(20);
            make.left.equalTo(self).offset(55);
            make.width.equalTo(@(ScreenW - 100));
            make.bottom.equalTo(self).offset(-10);
        }];
        
        self.titleLB = [[UILabel alloc] init];//WithFrame:CGRectMake(20, 5, ScreenW - 130, 30)];
        self.titleLB.numberOfLines = 0;
        self.titleLB.text = @"您好, 请问有什么可以帮助到您? 如果为解决问题,可以输入\"人工客服\"";
        self.titleLB.font = kFont(13);
        [self.imgV addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgV).offset(20);
            make.top.equalTo(self.imgV).offset(5);
            make.right.equalTo(self.imgV).offset(-10);
            make.bottom.equalTo(self.imgV).offset(-5);
        }];
        
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

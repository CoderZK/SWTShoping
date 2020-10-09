//
//  SWTAvChatZhongQianCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/10/9.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAvChatZhongQianCell.h"


@implementation SWTAvChatZhongQianCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backYellowView = [[UIView alloc] init];
        self.backYellowView.layer.cornerRadius = 15;
        self.backYellowView.clipsToBounds = YES;
        self.backYellowView.backgroundColor = RGB(205, 173, 31);
        [self addSubview:self.backYellowView];
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.textColor = WhiteColor;
        self.titleLB.font = kFont(13);
        [self.backYellowView addSubview:self.titleLB];
        
        [self.backYellowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.height.equalTo(@30);
            
        }];
        
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backYellowView);
            make.left.equalTo(self.backYellowView).offset(10);
            make.right.equalTo(self.backYellowView).offset(-20);
        }];
        
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        
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

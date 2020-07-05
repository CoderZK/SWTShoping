//
//  SWTBottomBt.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTBottomBt.h"

@implementation SWTBottomBt


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconImgView];
        [self addSubview:self.textLabel];
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(5);
            make.size.equalTo(@18);
        }];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(10);
        }];
    }
    return self;
}

- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [UIImageView new];
    }
    return _iconImgView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = CharacterColor50;
        _textLabel.font = [UIFont systemFontOfSize:9];
    }
    return _textLabel;
}

@end

//
//  SWTMineBaoBiaoHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineBaoBiaoHeadView.h"

@implementation SWTMineBaoBiaoHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * view  =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.backgroundColor = BackgroundColor;
        
        self.leftLB = [[UILabel alloc] init];
        self.leftLB.font = kFont(14);
        [self addSubview:self.leftLB];
        [self.leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self);
        }];
        
        self.rightBt = [[UIButton alloc] init];
        [self.rightBt setTitle:@"查看更多 >" forState:UIControlStateNormal];
        [self.rightBt setTitleColor:CharacterColor102 forState:UIControlStateNormal];
        self.rightBt.titleLabel.font = kFont(14);
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [self addSubview:self.rightBt];
        
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self);
            make.width.equalTo(@200);
        }];
        
    }
    self.backgroundColor = WhiteColor;
    return self ;
}

@end

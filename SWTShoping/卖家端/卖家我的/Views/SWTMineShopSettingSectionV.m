//
//  SWTMineShopSettingSectionV.m
//  SWTZBMH
//
//  Created by kunzhang on 2020/8/3.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineShopSettingSectionV.h"

@implementation SWTMineShopSettingSectionV

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self  =[super initWithReuseIdentifier:reuseIdentifier];
    if (self != nil) {
        
        self.titelLB = [[UILabel alloc] init];

        self.titelLB.font = kFont(14);
        self.titelLB.textColor = CharacterColor70;
        [self addSubview:self.titelLB];
        
        [self.titelLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.bottom.equalTo(self);
        }];
        
    }
    self.backgroundColor = BackgroundColor;
    return self;
}
@end

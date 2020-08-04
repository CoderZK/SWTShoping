//
//  SWTMineKeFuHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineKeFuHeadView.h"

@implementation SWTMineKeFuHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.LBOne = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 20, 15)];
        self.LBOne.textColor = CharacterColor70;
        self.LBOne.font = kFont(12);
        self.LBOne.textAlignment = NSTextAlignmentCenter;
        self.LBOne.text = @"今天:10:30";
        [self addSubview:self.LBOne];
        
        self.LBTwo = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, ScreenW - 20, 15)];
        self.LBTwo.textColor = CharacterColor70;
        self.LBTwo.font = kFont(12);
        self.LBTwo.textAlignment = NSTextAlignmentCenter;
        self.LBTwo.text = @"机器人为您服务";
        [self addSubview:self.LBTwo];
        
        
        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

@end

//
//  MJHeMaiHeadFootView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiHeadFootView.h"

@implementation MJHeMaiHeadFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, (ScreenW - 30)/2, 20)];
        self.leftLB.font = kFont(14);
        self.leftLB.textColor = CharacterColor102;
        self.leftLB.text = @"合买";
        [self addSubview:self.leftLB];
        
        self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(15,ScreenW - (ScreenW - 30)/2 - 15, (ScreenW - 30)/2, 20)];
        self.rightLB.font = kFont(14);
        self.rightLB.textColor = CharacterColor102;
        self.rightLB.text = @"时间";
        [self addSubview:self.rightLB];
        
        
        
    }
    return self;
}

@end

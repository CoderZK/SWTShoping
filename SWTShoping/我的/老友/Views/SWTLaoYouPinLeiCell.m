//
//  SWTLaoYouPinLeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouPinLeiCell.h"
#import "SWTMineHomeButton.h"

@interface SWTLaoYouPinLeiCell()
@property(nonatomic , strong)UIView *whiteV;
@end


@implementation SWTLaoYouPinLeiCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] init];
        
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        [self.whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        [self addsub];
        
    }
    self.clipsToBounds = YES;
    return self;
}



- (void)addsub {
    NSArray * arr = @[@"玉翠租宝",@"工艺作品",@"文玩杂项",@"紫砂陶壶",@"书画抓可",@"查究滋补",@"花鸟文娱",@"奢侈品"];
    CGFloat space = (ScreenW - 4* 80)/5;
    for (int i = 0 ; i < arr.count; i++) {
        SWTMineHomeButton * buttom  =[[SWTMineHomeButton alloc] initWithFrame:CGRectMake(space + (space + 80)* (i%4), (i/4)* 100  , 80, 80) withImageWidth:50];
        buttom.titleLB.text = arr[i];
        [self.whiteV addSubview:buttom];
    }
    
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

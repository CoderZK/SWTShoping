//
//  SWTShopIntroducePingJiaCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopIntroducePingJiaCell.h"

@interface SWTShopIntroducePingJiaCell()
@property(nonatomic , strong)UIImageView *headImgV;
@property(nonatomic , strong)UILabel *nameLB,*timeLB,*contentLB;
@property(nonatomic , strong)SWTXingXingView *xingV;
@property(nonatomic , strong)UIView *whiteV;
@end

@implementation SWTShopIntroducePingJiaCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self) {
        self.headImgV = [UIImageView alloc];
        
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end

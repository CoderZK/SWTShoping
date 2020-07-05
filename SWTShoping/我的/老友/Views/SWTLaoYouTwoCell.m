//
//  SWTLaoYouTwoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouTwoCell.h"

@implementation SWTLaoYouTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * arr1 = @[@"一键开店",@"直播卖货",@"精选优选",@"获得流量",@"分类众多",@"一分钟"];
        NSArray * arr2 = @[@"快键发布拍品",@"流量足出货快",@"好品质卖高货",@"长期留住客户",@"分类齐全",@"发布拍品"];
        
        CGFloat space = (ScreenW - 28 * 3) / 6;
        
        for (int i = 0 ; i < arr1.count; i++) {
            
            UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(space + (2*space + 28) * (i % 3), 30 + i / 3 * 80, 28, 28)];
            imgV.image = [UIImage imageNamed: [NSString stringWithFormat:@"shop_icon_%d",i+1]];
            [self addSubview:imgV];
            
            UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/3 * (i % 3), CGRectGetMaxY(imgV.frame), ScreenW /3, 17)];
            lb1.font = kFont(13);
            lb1.textColor = WhiteColor;
            lb1.textAlignment = NSTextAlignmentCenter;
            lb1.text = arr1[i];
            [self addSubview:lb1];
            
            UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/3 * (i % 3), CGRectGetMaxY(lb1.frame), ScreenW /3, 13)];
            lb2.font = kFont(11);
            lb2.textColor = WhiteColor;
            lb2.textAlignment = NSTextAlignmentCenter;
            lb2.text = arr2[i];
            [self addSubview:lb2];
            
        }

        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
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

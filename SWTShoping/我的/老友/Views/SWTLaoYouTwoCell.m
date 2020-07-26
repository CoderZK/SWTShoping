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
            imgV.tag = 300+i;
            [self addSubview:imgV];
            
            UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/3 * (i % 3), CGRectGetMaxY(imgV.frame), ScreenW /3, 17)];
            lb1.font = kFont(13);
            lb1.textColor = WhiteColor;
            lb1.textAlignment = NSTextAlignmentCenter;
            lb1.text = arr1[i];
            lb1.tag = 100+i;
            [self addSubview:lb1];
            
            UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW/3 * (i % 3), CGRectGetMaxY(lb1.frame), ScreenW /3, 13)];
            lb2.font = kFont(11);
            lb2.textColor = WhiteColor;
            lb2.textAlignment = NSTextAlignmentCenter;
            lb2.text = arr2[i];
            lb2.tag = 200+i;
            [self addSubview:lb2];
            
        }

        
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    if (dataDict == nil) {
        return;
    }
    UILabel * lb1 = [self viewWithTag:100];
    UILabel * lb2 = [self viewWithTag:101];
    UILabel * lb3 = [self viewWithTag:102];
    UILabel * lb4 = [self viewWithTag:103];
    UILabel * lb5 = [self viewWithTag:104];
    UILabel * lb6 = [self viewWithTag:105];
    UILabel * lb7 = [self viewWithTag:200];
    UILabel * lb8 = [self viewWithTag:201];
    UILabel * lb9 = [self viewWithTag:202];
    UILabel * lb10 = [self viewWithTag:203];
    UILabel * lb11 = [self viewWithTag:204];
    UILabel * lb12 = [self viewWithTag:205];
    
    UIImageView * imgV1 = [self viewWithTag:300];
    UIImageView * imgV2 = [self viewWithTag:301];
    UIImageView * imgV3 = [self viewWithTag:302];
    UIImageView * imgV4 = [self viewWithTag:303];
    UIImageView * imgV5 = [self viewWithTag:304];
    UIImageView * imgV6 = [self viewWithTag:305];
    
    lb1.text = self.dataDict[@"label1"];
    lb2.text = self.dataDict[@"label2"];
    lb3.text = self.dataDict[@"label3"];
    lb4.text = self.dataDict[@"labe4"];
    lb5.text = self.dataDict[@"label5"];
    lb6.text = self.dataDict[@"label6"];
    lb7.text = self.dataDict[@"sublabel1"];
    lb8.text = self.dataDict[@"sublabel2"];
    lb9.text = self.dataDict[@"sublabel3"];
    lb10.text = self.dataDict[@"sublabel4"];
    lb11.text = self.dataDict[@"sublabel5"];
    lb12.text = self.dataDict[@"sublabel6"];
    
    [imgV1 sd_setImageWithURL:[dataDict[@"labelpic1"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [imgV2 sd_setImageWithURL:[dataDict[@"labelpic2"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [imgV3 sd_setImageWithURL:[dataDict[@"labelpic3"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [imgV4 sd_setImageWithURL:[dataDict[@"labelpic4"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [imgV5 sd_setImageWithURL:[dataDict[@"labelpic5"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    [imgV6 sd_setImageWithURL:[dataDict[@"labelpic6"] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];

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

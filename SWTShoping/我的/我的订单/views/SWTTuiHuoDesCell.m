//
//  SWTTuiHuoDesCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoDesCell.h"

@implementation SWTTuiHuoDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backV.clipsToBounds = YES;
    self.backV.layer.cornerRadius  = 3;
    self.backV.backgroundColor = BackgroundColor;
    
    
      
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReasonStr:(NSString *)reasonStr {
    _reasonStr = reasonStr;
    self.leftOneLB.text =  [NSString stringWithFormat:@"退款或退货原因:%@",reasonStr];
}

- (void)setContextStr:(NSString *)contextStr {
    _contextStr = contextStr;
    self.leftTwoLB.text = contextStr;
}

- (void)setPicArr:(NSArray<UIImage *> *)picArr {
    _picArr = picArr;
    [self.picV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (picArr.count == 0) {
        self.picCons.constant = 0;
    }else {
        self.picCons.constant = 70;
        
        for (int i = 0 ; i < picArr.count; i++) {
            UIImageView * imgV  = [[UIImageView alloc] initWithFrame:CGRectMake(80 * i , 0, 70, 70)];
            [self.picV addSubview:imgV];
            imgV.image = picArr[i];
        }
        
    }
}

@end

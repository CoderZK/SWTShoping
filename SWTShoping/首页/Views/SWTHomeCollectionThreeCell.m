//
//  SWTHomeCollectionThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeCollectionThreeCell.h"

@implementation SWTHomeCollectionThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    
    [self.imgV sd_setImageWithURL:[model.goodimg getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.name;
    
    NSArray * arr = [model getTypeLBArr];
    self.typeOneLB.hidden = self.typeTwoLB.hidden = YES;
    if (arr.count > 0 ) {
        self.typeOneLB.hidden = NO;
        self.typeOneLB.text =  [NSString stringWithFormat:@" %@ ",arr[0]];
    }
    
    if (arr.count > 1 ) {
        self.typeTwoLB.hidden = NO;
        self.typeTwoLB.text =  [NSString stringWithFormat:@" %@ ",arr[1]];
        
    }
    
    if (arr.count == 0) {
        self.yyCons.constant = self.heightCons.constant = 0;
    }else {
        self.yyCons.constant = 5;
        self.heightCons.constant = 15;
    }
    NSString * price =  [NSString stringWithFormat:@"￥%@",[model.goodprice getPriceStr]];;
    self.moneyLB.text = price;
    self.numberLB.text = model.bidsnum;
    
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
    
    
    
}

@end

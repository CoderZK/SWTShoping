//
//  SWTMJVideoCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJVideoCell.h"

@implementation SWTMJVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:model.img.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
}

@end

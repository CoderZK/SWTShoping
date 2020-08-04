//
//  SWTKeFuTwoNeiCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/4.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTKeFuTwoNeiCell.h"

@implementation SWTKeFuTwoNeiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.font = kFont(13);
        self.titleLB.textColor = CharacterColor70;
        self.titleLB.numberOfLines = 0;
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(0);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
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

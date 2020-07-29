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

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self addsub];
}

- (void)addsub {
    CGFloat space = (ScreenW - 4* 80)/5;
    for (int i = 0 ; i < self.dataArray.count; i++) {
        SWTMineHomeButton * buttom  =[[SWTMineHomeButton alloc] initWithFrame:CGRectMake(space + (space + 80)* (i%4), (i/4)* 100  , 80, 80) withImageWidth:50];
        buttom.titleLB.text = self.dataArray[i].name;
        [buttom.imgV sd_setImageWithURL:[self.dataArray[i].pic getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
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

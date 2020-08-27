//
//  SWTMJRefundCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/27.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJRefundCell.h"

@interface SWTMJRefundCell()
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UILabel *reasonLB;
@property(nonatomic , strong)UILabel *desLB;
@property(nonatomic , strong)UIScrollView *scrollView;

@end

@implementation SWTMJRefundCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] init];
        self.whiteV.backgroundColor = BackgroundColor;
        [self addSubview:self.whiteV];
        [self addSubview:self.whiteV];
        
        [self.whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(5);
            make.bottom.right.equalTo(self).offset(-5);
        }];
        
        self.reasonLB = [[UILabel alloc] init];
        self.reasonLB.font = kFont(13);
        self.reasonLB.textColor = CharacterColor102;
        self.reasonLB.numberOfLines = 0;
        [self.whiteV addSubview:self.reasonLB];
        
        [self.reasonLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(10);
            make.top.equalTo(self.whiteV).offset(10);
            make.right.equalTo(self.whiteV).offset(-10);
        }];
        
        self.desLB = [[UILabel alloc] init];
        self.desLB.font = kFont(13);
        self.desLB.textColor = CharacterColor102;
        self.desLB.numberOfLines = 0;
        [self.whiteV addSubview:self.desLB];
        
        [self.desLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(10);
            make.top.equalTo(self.reasonLB.mas_bottom).offset(10);
            make.right.equalTo(self.whiteV).offset(-10);
        }];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.clipsToBounds = YES;
        [self.whiteV addSubview:self.scrollView];
        
        CGFloat ww = (ScreenW - 50)/4;
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(10);
            make.right.equalTo(self.whiteV).offset(-10);
            make.bottom.equalTo(self.whiteV).offset(-10);
            make.top.equalTo(self.desLB.mas_bottom).offset(10);
            make.height.equalTo(@(ww));
        }];
        
        
        
        
    }
    return self;
}


- (void)setModel:(SWTModel *)model {
    _model = model;
    self.reasonLB.text =  [NSString stringWithFormat:@"退款原因:%@",model.reason];
    self.desLB.text = [NSString stringWithFormat:@"退款原因:%@",model.text];
    if (model.refundImgs.count == 0) {
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
            make.bottom.equalTo(self.whiteV).offset(-5);
        }];
    }else {
        CGFloat ww = (ScreenW - 50)/4;
        [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ww));
            make.bottom.equalTo(self.whiteV).offset(-10);
        }];
        
        [self setPics];
        
    }
}

- (void)setPics {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = (ScreenW - 50)/4;
    self.scrollView.contentSize = CGSizeMake(ww * self.model.refundImgs.count * (ww + 10) + 10, ww);
    for (int i = 0 ; i < self.model.refundImgs.count; i++) {
        
        UIImageView * imgV  = [[UIImageView alloc] initWithFrame:CGRectMake(10+ (10 + ww) * i , 0, ww, ww)];
        [self.scrollView addSubview:imgV];
        imgV.tag = i;
        [self.scrollView addSubview:imgV];
        [imgV sd_setImageWithURL:[self.model.refundImgs[i] getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        imgV.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
           [imgV addGestureRecognizer:tap];
        
    }
}



- (void)tapAction:(UITapGestureRecognizer *)tap  {
    NSInteger tag = tap.view.tag;
    
    [[zkPhotoShowVC alloc] initWithArray:self.model.refundImgs index:tag];
    
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

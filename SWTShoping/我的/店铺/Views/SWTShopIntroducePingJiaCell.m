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
@property(nonatomic , strong)UIView *picV;
@end

@implementation SWTShopIntroducePingJiaCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    if (self) {
        self.headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 35, 35)];
        [self addSubview:self.headImgV];
        
        self.headImgV.layer.cornerRadius = 17.5;
        self.headImgV.clipsToBounds = YES;
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgV.frame) + 3, 17, 200, 15)];
        self.nameLB.tintColor = CharacterColor70;
        self.nameLB.font = kFont(13);
        self.nameLB.text = @"实施家电费";
        [self addSubview:self.nameLB];
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgV.frame) + 3, 33, 200, 15)];
        self.timeLB.tintColor = CharacterColor70;
        self.timeLB.font = kFont(12);
        [self addSubview:self.timeLB];
        self.timeLB.text = @"2020-04-22";
        CGFloat ww  = 12*5+3*4;
        self.xingV = [[SWTXingXingView alloc] initWithFrame:CGRectMake(ScreenW - ww - 15, 15 +  (35-12)/2.0, ww, 12)];
        self.xingV.userInteractionEnabled = NO;
        [self addSubview:self.xingV];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxX(self.headImgV.frame) + 15, ScreenW - 30, 20)];
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        self.contentLB.text = @"恶违法群殴文件佛群殴群殴金融界区日哦金佛期间我放假哦亲王嘉尔佛几千万";
        
        
        self.picV =[[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxX(self.contentLB.frame) + 15, ScreenW - 30, (ScreenW - 30 - 30)/4)];
        [self addSubview:self.picV];

    
        
        
        
    }
    return self;
}


- (void)setPics:(NSArray *)arr {
    
    [self.picV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (arr.count== 0 || self.model.img.length == 0) {
        return;
    }
    
    CGFloat space = 10;
    CGFloat leftM = 0;
    CGFloat ww = (ScreenW - 30 - 30)/4;
    for (int i = 0 ; i< arr.count; i++) {

        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(leftM + (space+ ww) * i, 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;

        
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.picV addSubview:anNiuBt];
        
        [anNiuBt sd_setBackgroundImageWithURL:[arr[i] getPicURL] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        
        
        
        
        
    }
    
}

//点击图片
- (void)hitAction:(UIButton *)anNiuBt {
    
    [[zkPhotoShowVC alloc] initWithArray:[self.model.img componentsSeparatedByString:@","] index:anNiuBt.tag -100];
    
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.headImgV sd_setImageWithURL:[model.avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.text = model.nickname;
    self.timeLB.text = model.finishtime;
    self.contentLB.attributedText =[model.comment getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterColor70];
    self.contentLB.mj_h = [model.comment getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 30];
    self.xingV.score = model.score.intValue;
    [self setPics:[model.img componentsSeparatedByString:@","]];
    
    if (model.comment.length == 0) {
        if (model.img.length ==0 ) {
            model.HHHHHH = 65;
        }else {
            self.picV.mj_y = 65;
            model.HHHHHH = CGRectGetMaxY(self.picV.frame) + 10;
        }
    }else {
       if (model.img.length ==0 ) {
            model.HHHHHH = CGRectGetMaxY(self.contentLB.frame)+10;
        }else {
            self.picV.mj_y = CGRectGetMaxY(self.contentLB.frame)+10;
            model.HHHHHH = CGRectGetMaxY(self.picV.frame) + 10;
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end

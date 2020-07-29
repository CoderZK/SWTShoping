//
//  SWTPingJiaHeadV.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/11.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTPingJiaHeadV.h"
#import "SWTXingXingView.h"
@interface SWTPingJiaHeadV()


@end

@implementation SWTPingJiaHeadV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.whiteView = [[UIView alloc] init];
        self.whiteView.layer.cornerRadius = 5;
        self.whiteView.clipsToBounds = YES;
        self.whiteView.backgroundColor = WhiteColor;
        [self addSubview:self.whiteView];
        
        self.leftimgV = [[UIImageView alloc] init];
        self.leftimgV.image = [UIImage imageNamed:@"369"];
        [self.whiteView addSubview:self.leftimgV];
        
        self.leftimgV.layer.cornerRadius = 3;
        self.leftimgV.clipsToBounds = YES;
        
        self.leftOneLB = [[UILabel alloc] init];
        self.leftOneLB.font = kFont(14);
        self.leftOneLB.textColor = CharacterColor70;
        self.leftOneLB.text = @"式搜救请我而佛";
        self.leftOneLB.numberOfLines = 0;
        [self.whiteView addSubview:self.leftOneLB];
        
        self.leftTwoLb = [[UILabel alloc] init];
        self.leftTwoLb.font = kFont(12);
        self.leftTwoLb.textColor = CharacterColor70;
        self.leftTwoLb.text = @"尺寸: 250 * 200";
        [self.whiteView addSubview:self.leftTwoLb];
        
        
        //        self.leftThreeLB = [[UILabel alloc] init];
        //        self.leftThreeLB.font = kFont(13);
        //        self.leftThreeLB.textColor = RedColor;
        //        self.leftThreeLB.text = @"退款: ￥145";
        //        [self.whiteView addSubview:self.leftThreeLB];
        
        
        UILabel * miaoShuLB  =[[UILabel alloc] init];
        miaoShuLB.text = @"描述相符";
        miaoShuLB.font = kFont(14);
        [self.whiteView addSubview:miaoShuLB];
        
        self.textV = [[IQTextView alloc] init];
        self.textV.placeholder = @"在这里写下您的评价,并上传卖家秀哦~";
        self.textV.font = kFont(14);
        [self.whiteView addSubview:self.textV];
        //        self.textV.backgroundColor = [UIColor redColor];
        
        
        self.xingView1 = [[SWTXingXingView alloc] initWithFrame:CGRectMake(0, 0, 27*5-10, 17)];
        [self.whiteView addSubview:self.xingView1];
        self.xingView1.delegateSignal = [[RACSubject alloc] init];
        
        
        UILabel * miaoShuLB1  =[[UILabel alloc] init];
        miaoShuLB1.text = @"非常差";
        miaoShuLB1.font = kFont(14);
        [self.whiteView addSubview:miaoShuLB1];
        self.manyiLB = miaoShuLB1;
        
        
        @weakify(self);
        [self.xingView1.delegateSignal subscribeNext:^(NSNumber * x) {
            @strongify(self);
            
            if (x.intValue <= 0) {
                miaoShuLB1.text = @"差";
            }else if (x.intValue <= 2){
                miaoShuLB1.text = @"一般";
            }else if (x.intValue <= 3){
                miaoShuLB1.text = @"很好";
            }else {
                miaoShuLB1.text = @"非常好";
            }
            
            
            
        }];
        
        self.picV =[[UIScrollView alloc] init];
        [self.whiteView addSubview:self.picV];
        
        //        self.whiteTwoView = [[UIView alloc] init];
        //        self.whiteTwoView.backgroundColor = WhiteColor;
        //        self.whiteTwoView.layer.cornerRadius = 5;
        //        self.whiteTwoView.clipsToBounds = YES;
        //        [self addSubview:self.whiteTwoView];
        
        //
        //        UILabel * miaoShuLB3  =[[UILabel alloc] init];
        //        miaoShuLB3.text = @"水御堂";
        //        miaoShuLB3.font = kFont(14);
        //        [self.whiteTwoView addSubview:miaoShuLB3];
        //        self.shopNameLB = miaoShuLB3;
        //
        //        UILabel * lb1 = [[UILabel alloc] init];
        //        lb1.font = kFont(13);
        //        lb1.textColor = CharacterColor70;
        //        lb1.text = @"服务态度";
        //        [self.whiteTwoView addSubview:lb1];
        //
        //        self.xingView2  =[[SWTXingXingView alloc] initWithFrame:CGRectMake(0, 0, 25*5 -10, 15)];
        //        [self.whiteTwoView addSubview:self.xingView2];
        //
        //        UILabel * lb2 = [[UILabel alloc] init];
        //        lb2.font = kFont(13);
        //        lb2.textColor = CharacterColor70;
        //        lb2.text = @"物流态度";
        //        [self.whiteTwoView addSubview:lb2];
        //
        //        self.xingView3  =[[SWTXingXingView alloc] initWithFrame:CGRectMake(0, 0, 25*5 -10, 15)];
        //        [self.whiteTwoView addSubview:self.xingView3];
        
        
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(@(90 + 20 + 150 + 20 + 17+ 15 + 95));
        }];
        
        
        
        [self.leftimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.whiteView).offset(10);
            make.left.equalTo(self.whiteView).offset(10);
            make.height.width.equalTo(@85);
        }];
        
        
        
        [self.leftOneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.whiteView).offset(-10);
            make.top.equalTo(self.leftimgV).offset(8);
        }];
        
        [self.leftTwoLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV.mas_right).offset(5);
            make.right.equalTo(self.whiteView).offset(-10);
            make.top.equalTo(self.leftOneLB.mas_bottom).offset(7);
            make.height.equalTo(@17);
        }];
        
        
        //        [self.leftThreeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.leftimgV.mas_right).offset(5);
        //            make.right.equalTo(self).offset(-10);
        //            make.top.equalTo(self.leftTwoLb.mas_bottom).offset(7);
        //            make.height.equalTo(@17);
        //        }];
        
        
        [miaoShuLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV);
            make.top.equalTo(self.leftimgV.mas_bottom).offset(15);
        }];
        
        [self.xingView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(17 * 5 + 4*10));
            make.height.equalTo(@17);
            make.left.equalTo(miaoShuLB.mas_right).offset(15);
            make.centerY.equalTo(miaoShuLB);
            
        }];
        
        [self.manyiLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@17);
            make.left.equalTo(self.xingView1.mas_right).offset(15);
            make.centerY.equalTo(miaoShuLB);
            
        }];
        
        [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(miaoShuLB.mas_bottom).offset(20);
            make.left.equalTo(self.leftimgV);
            make.right.equalTo(self.whiteView).offset(-10);
            make.height.equalTo(@150);
        }];
        
        [self.picV  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftimgV);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@((ScreenW - 30 - 50)/4));
            make.top.equalTo(self.textV.mas_bottom).offset(20);
        }];
        
        // 90 + 20 + 150 + 20 + 17 + 15 + 95
        
        
        //        [self.whiteTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.equalTo(self.whiteView);
        //            make.top.equalTo(self.whiteView.mas_bottom).offset(15);
        //            make.height.equalTo(@140);
        //        }];
        //
        //        [self.shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.top.equalTo(self.whiteTwoView).offset(10);
        //            make.height.equalTo(@20);
        //
        //        }];
        //        [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.shopNameLB);
        //            make.top.equalTo(self.shopNameLB.mas_bottom).offset(10);
        //            make.height.equalTo(@20);
        //        }];
        //
        //        [self.xingView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(lb1.mas_right).offset(15);
        //            make.top.equalTo(lb1).offset(2.5);
        //            make.height.equalTo(@15);
        //            make.width.equalTo(@(25*5-10));
        //        }];
        //
        //        [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(self.shopNameLB);
        //            make.top.equalTo(lb1.mas_bottom).offset(10);
        //            make.height.equalTo(@20);
        //        }];
        //
        //        [self.xingView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(lb2.mas_right).offset(15);
        //            make.top.equalTo(lb2).offset(2.5);
        //            make.height.equalTo(@15);
        //            make.width.equalTo(@(25*5-10));
        //        }];
        //
        
        
    }
    
    return self;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.leftimgV sd_setImageWithURL:[model.thumb getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.leftOneLB.text = model.goodname;
    self.leftTwoLb.text = model.spec;
    self.leftThreeLB.hidden = YES;
    self.shopNameLB.text = model.store_name;
    
}


- (void)setPicArr:(NSMutableArray<UIImage *> *)picArr {
    _picArr = picArr;
    [self setPics];
}




- (void)setPics {
    
    [self.picV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger allNu = self.picArr.count < 4 ? self.picArr.count + 1:4;
    
    CGFloat space = 10;
    CGFloat leftM = 5;
    CGFloat ww = (ScreenW - 30 - 50)/4;
    for (int i = 0 ; i< allNu; i++) {
        
        
        
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(leftM + (space+ ww) * i, 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        anNiuBt.backgroundColor = RGB(250, 250, 250);
        
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.picV addSubview:anNiuBt];
        
        UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(ww - 25 , 0, 25, 25)];
        
        deleteBt.tag = 200+i;
        [deleteBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i<self.picArr.count) {
            [anNiuBt setBackgroundImage:self.picArr[i] forState:UIControlStateNormal];
            
            [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
            [anNiuBt addSubview:deleteBt];
        }else {
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"feedback_addpic"] forState:UIControlStateNormal];
            
            
        }
        
        
        
    }
    
}

- (void)hitAction:(UIButton *)anNiuBt {
    
    if (anNiuBt.tag >=200) {
        //删除
        [self.picArr removeObjectAtIndex:anNiuBt.tag - 200];
        [self setPics];
//        [self.delegateSignal sendNext: [NSString stringWithFormat:@"%ld",anNiuBt.tag - 200]];
    }else {
        if (anNiuBt.tag - 100  == self.picArr.count) {
            //添加图片
            if (self.delegateSignal) {
                [self.delegateSignal sendNext:@"123"];
            }
            
        }
    }
}



@end

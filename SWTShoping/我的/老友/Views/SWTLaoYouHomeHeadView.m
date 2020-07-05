//
//  SWTLaoYouHomeHeadView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouHomeHeadView.h"

@interface SWTLaoYouHomeHeadView()



@end

@implementation SWTLaoYouHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
        imgV.backgroundColor =[UIColor redColor];
        
        [self addSubview:imgV];
        
        UIImageView * imgVTwo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 40, ScreenW - 30, 220)];
        imgVTwo.image =[UIImage imageNamed:@"card"];
        [self addSubview:imgVTwo];
        
        UILabel * lb1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, ScreenW - 30, 25)];
        lb1.textAlignment = NSTextAlignmentCenter;
        lb1.textColor = WhiteColor;
        lb1.font = [UIFont systemFontOfSize:20 weight:0.2];
        [imgVTwo addSubview:lb1];
        lb1.text = @"即可开店  月入百万";
        
        UILabel * lb2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lb1.frame) + 20, ScreenW - 30, 17)];
        lb2.textAlignment = NSTextAlignmentCenter;
        lb2.textColor = WhiteColor;
        lb2.font = kFont(13);
        [imgVTwo addSubview:lb2];
        lb2.text = @"文玩艺术品直播竞拍电商购物平台";
        
        UILabel * lb3 = [[UILabel alloc] init];
        lb3.textAlignment = NSTextAlignmentCenter;
        lb3.textColor = WhiteColor;
        lb3.font = kFont(13);
        lb3.numberOfLines = 0;
        [imgVTwo addSubview:lb3];
        lb3.text = @"平台商品覆盖玉翠珠宝, 文玩杂项, 工艺作品, 紫砂陶瓷, 书画篆刻等多个分类, 应有尽有";
        [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgVTwo).offset(15);
            make.right.equalTo(imgVTwo).offset(-15);
            make.top.equalTo(lb2.mas_bottom).offset(15);
        }];
        
        self.backgroundColor = RGB(182, 142, 101);
        
        
    }
    
    return self;
}

@end

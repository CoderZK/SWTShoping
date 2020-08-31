//
//  SWTHomeCollectionOneCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/6/29.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHomeCollectionOneCell.h"
#import "SWTHomeReMenView.h"
@interface SWTHomeCollectionOneCell()<UIScrollViewDelegate>
@property(nonatomic , strong)UIScrollView *scrollView;

@end

@implementation SWTHomeCollectionOneCell


-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        
    }
    return _scrollView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
    
        self.scrollView.frame = CGRectMake(0, 0, ScreenW - 20, 160);
        
        CGFloat space = 10;
        CGFloat hh = 160 - 10;
        CGFloat ww = (ScreenW - 20 - 20)/3;
        for (int i = 0 ; i < 3; i++) {
            
            SWTHomeReMenView * renMenV = [[SWTHomeReMenView alloc] initWithFrame:CGRectMake( i*(space + ww), 0, ww, hh)];
            renMenV.Bt.tag = i+100;
            renMenV.tag = i+100;
            [renMenV.Bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:renMenV];
            
            
        }
        
    }
    
    return self;
}

- (void)setDataArray:(NSMutableArray<SWTModel *> *)dataArray {
    _dataArray = dataArray;
    for (int i = 0 ; i < 3; i++) {
        SWTHomeReMenView * vv = [self.scrollView viewWithTag:i+100];
        vv.hidden = YES;
        if (i<dataArray.count) {
            vv.hidden = NO;
            [vv.imgV sd_setImageWithURL:[dataArray[i].img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
      
            
               NSString * str = @"";
               if (dataArray[i].watchnum.intValue > 10000) {
                   str =  [NSString stringWithFormat:@"%0.1f万人在观看",dataArray[i].watchnum.floatValue/10000.0];
               }else {
                   str =  [NSString stringWithFormat:@"%@人在观看",dataArray[i].watchnum];
               }
      
            vv.heMaiLB.hidden = ![dataArray[i].type isEqualToString:@"share"];
            vv.rightLB.text = str;
            vv.bottomLB.text = dataArray[i].name;
            
            vv.headImgV.hidden = vv.centerLB.hidden = YES;
            
        }else {
            vv.hidden = YES;
        }
    }
    
    
}

- (void)clickAction:(UIButton *)button {
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag - 100)];
    }
}


@end

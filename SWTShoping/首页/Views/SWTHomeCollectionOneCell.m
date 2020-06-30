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
    
        self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        CGFloat space = 10;
        CGFloat hh = frame.size.height - 10;
        CGFloat ww = (frame.size.width - 20)/3;
        for (int i = 0 ; i < 3; i++) {
            
            SWTHomeReMenView * renMenV = [[SWTHomeReMenView alloc] initWithFrame:CGRectMake( i*(space + ww), 0, ww, hh)];
            [self.scrollView addSubview:renMenV];
            
            
        }
        
    }
    
    return self;
}




@end

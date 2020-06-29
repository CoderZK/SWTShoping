//
//  ALCSearchView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSearchView.h"

@interface ALCSearchView()

@end


@implementation ALCSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
           UIView * leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
           UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 14, 14)];
           imgView.image = [UIImage imageNamed:@"shop5"];
           [leftview addSubview:imgView];
           self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 5 , frame.size.width - 30, 34)];
           NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入拍品" attributes:
                                             @{NSForegroundColorAttributeName:WhiteColor,
                                               NSFontAttributeName:self.searchTF.font
                                             }];
           self.searchTF.attributedPlaceholder = attrString;
           self.searchTF.font = [UIFont systemFontOfSize:14];
           self.searchTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
           self.searchTF.textColor = WhiteColor;
           self.searchTF.leftView = leftview;
           self.searchTF.leftViewMode = UITextFieldViewModeAlways;
           self.searchTF.layer.cornerRadius = 17;
           self.searchTF.layer.masksToBounds = YES;
           //    self.searchTF.userInteractionEnabled = NO;
           self.searchTF.returnKeyType = UIReturnKeySearch;
            
           [self addSubview:self.searchTF];

           UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
           button.frame = CGRectMake(0, 0, self.searchTF.mj_w, self.searchTF.mj_h);
           self.clickBt = button;
           [self.searchTF addSubview:button];

    }
    return self;
}

- (void)setIsPush:(BOOL)isPush {
    _isPush = isPush;
    if (isPush) {
        self.clickBt.hidden = NO;
    }else {
        self.clickBt.hidden = YES;
    }
}

@end

//
//  ALCSearchView.m
//  AnLanCustomers
//
//  Created by zk on 2020/3/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "ALCSearchView.h"

@interface ALCSearchView()
@property(nonatomic , assign)CGRect frame;
@end


@implementation ALCSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UIView * leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 14, 14)];
        imgView.image = [UIImage imageNamed:@"searchw"];
        [leftview addSubview:imgView];
        self.imgView = imgView;
        self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, (frame.size.height - 34)/ 2, frame.size.width - 30, 34)];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入拍品" attributes:
                                          @{NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                            NSFontAttributeName:self.searchTF.font
                                          }];
        self.searchTF.attributedPlaceholder = attrString;
        self.searchTF.font = [UIFont systemFontOfSize:14];
        self.searchTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.searchTF.textColor = WhiteColor;
        self.searchTF.tintColor = WhiteColor;
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

- (void)setIsBlack:(BOOL)isBlack {
    _isBlack = isBlack;
    if (!isBlack ) {
        self.searchTF.tintColor = CharacterColor70;
        self.imgView.image = [UIImage imageNamed:@"searchw"];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入拍品" attributes:
                                          @{NSForegroundColorAttributeName:CharacterColor70,
      
                                            NSFontAttributeName:self.searchTF.font
                                          }];
        self.searchTF.attributedPlaceholder = attrString;
        self.searchTF.font = [UIFont systemFontOfSize:14];
        self.searchTF.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }else {
        self.searchTF.tintColor = CharacterColor183;
        self.imgView.image = [UIImage imageNamed:@"searchb"];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入拍品" attributes:
                                          @{NSForegroundColorAttributeName:CharacterColor183,
                                            NSFontAttributeName:self.searchTF.font
                                          }];
        self.searchTF.attributedPlaceholder = attrString;
        self.searchTF.font = [UIFont systemFontOfSize:14];
        self.searchTF.backgroundColor = BackgroundColor;
    }
    
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

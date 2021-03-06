//
//  SWTZhiBoBottomView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/12.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoBottomView.h"


@interface SWTZhiBoBottomView()<UITextFieldDelegate>



@property(nonatomic , strong)UIView *lineV;


@end

@implementation SWTZhiBoBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.gouWuBt = [[UIButton alloc] init];
        [self.gouWuBt setBackgroundImage:[UIImage imageNamed:@"dyx88"] forState:UIControlStateNormal];
        self.gouWuBt.tag = 100;
        [self.gouWuBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.gouWuBt];
        
        self.TF =[[UITextField alloc] init];
        self.TF.font = kFont(14);
        self.TF.returnKeyType = UIReturnKeySend;
        self.TF.delegate = self;
        self.TF.tintColor = WhiteColor;
        self.TF.textColor = WhiteColor;
        
        [self addSubview:self.TF];
        
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"和主播交流一下" attributes:
               @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont systemFontOfSize:14]
               }];
               self.TF.attributedPlaceholder = attrString;
        
        
        
        
        
        self.lineV = [[UIView alloc] init];
        self.lineV.backgroundColor = WhiteColor;
        [self addSubview:self.lineV];
        
        self.heMaibt =[[UIButton alloc] init];
        self.heMaibt.titleLabel.numberOfLines = 2;
        self.heMaibt.titleLabel.font = kFont(12);
//        self.heMaibt.backgroundColor = [UIColor redColor];
        [self.heMaibt setBackgroundImage:[UIImage imageNamed:@"dyx36"] forState:UIControlStateNormal];
        [self addSubview:self.heMaibt];
        self.heMaibt.tag = 101;
        [self.heMaibt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        self.shareBt =[[UIButton alloc] init];
//        self.shareBt.titleLabel.numberOfLines = 2;
//        self.shareBt.titleLabel.font = kFont(12);
//        self.shareBt.backgroundColor = [UIColor redColor];
//        [self.shareBt setBackgroundImage:[UIImage imageNamed:@"dyx35"] forState:UIControlStateNormal];
//        [self addSubview:self.shareBt];
//        self.shareBt.tag = 102;
//        [self.shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.collectBt =[[UIButton alloc] init];
        self.collectBt.titleLabel.numberOfLines = 2;
        self.collectBt.titleLabel.font = kFont(12);
//        self.collectBt.backgroundColor = [UIColor redColor];
        [self addSubview:self.collectBt];
        self.collectBt.tag = 103;
        [self.collectBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.collectBt setBackgroundImage:[UIImage imageNamed:@"collectN"] forState:UIControlStateNormal];
        
        self.numberLB = [[UILabel alloc] init];
        self.numberLB.layer.cornerRadius = 6;
        self.numberLB.clipsToBounds = YES;
        self.numberLB.font = kFont(8);
        self.numberLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.numberLB];
        self.numberLB.backgroundColor = RedColor;
        self.numberLB.textColor = WhiteColor;
        self.numberLB.text = @"";
        
        
        [self.gouWuBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.height.equalTo(@35);
            make.width.equalTo(@35);
            
        }];
        
        [self.collectBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.collectBt);
            make.height.equalTo(@12);
            make.bottom.equalTo(self.collectBt.mas_top);
        }];
        
//        [self.shareBt mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.collectBt.mas_left).offset(-15);
//            make.centerY.equalTo(self.gouWuBt);
//            make.height.width.equalTo(self.collectBt);
//        }];
        
        [self.heMaibt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.collectBt.mas_left).offset(-15);
            make.centerY.equalTo(self.gouWuBt);
            make.height.width.equalTo(@30);
        }];
        
        [self.TF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.heMaibt.mas_left).offset(-15);
            make.centerY.equalTo(self.gouWuBt);
            make.height.equalTo(@30);
            make.left.equalTo(self.gouWuBt.mas_right).offset(15);
            
        }];
        
        [self.lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.TF);
            make.top.equalTo(self.TF.mas_bottom);
            make.height.equalTo(@0.5);
        }];
        
        self.clipsToBounds = YES;
        
    }
    
    return self;
}


- (void)setIsShangHu:(BOOL)isShangHu {
    
    if (isShangHu) {
      
        [self.collectBt mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@0);
        }];
        
        if (!self.isHeMai) {
                //不是合买
        //        self.heMaibt.hidden = YES;
                [self.heMaibt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@0);
                    make.right.equalTo(self.collectBt.mas_left).offset(0);
                }];
                self.gouWuBt.hidden = NO;
                [self.gouWuBt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@45);
                }];
            }else {
                //合买
                self.heMaibt.hidden = YES;
                [self.gouWuBt mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.equalTo(@0);
                }];
                
            }
     
        [self.gouWuBt setBackgroundImage:[UIImage imageNamed:@"dyx87"] forState:UIControlStateNormal];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"和用户聊聊" attributes:
        @{NSForegroundColorAttributeName:[UIColor whiteColor],
        NSFontAttributeName:[UIFont systemFontOfSize:14]
        }];
        self.TF.attributedPlaceholder = attrString;
    }else {

        [self.gouWuBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];
        
        [self.collectBt mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.equalTo(@30);
        }];
        self.heMaibt.hidden = !self.isHeMai;
        
        
        
    }
    
    
    
}

- (void)setIsHeMai:(BOOL)isHeMai {
    _isHeMai = isHeMai;
    
         
   
}

- (void)clickAction:(UIButton *)button {
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@(button.tag - 100)];
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        
    }else {
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:@(100)];
        }
    }
    return YES;;
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    self.numberLB.text = model.merchfollownum;
    if ([model.merchisfollow isEqualToString:@"yes"]) {
        [self.collectBt setBackgroundImage:[UIImage imageNamed:@"collectY"] forState:UIControlStateNormal];
    }else {
        [self.collectBt setBackgroundImage:[UIImage imageNamed:@"collectN"] forState:UIControlStateNormal];
    }
    
}

@end

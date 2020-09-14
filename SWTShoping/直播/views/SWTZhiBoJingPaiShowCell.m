//
//  SWTZhiBoJingPaiShowCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/30.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTZhiBoJingPaiShowCell.h"

@implementation SWTZhiBoJingPaiShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SWTModel *)model {
    _model = model;
    [self.imgV sd_setImageWithURL:[model.img getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.name;
    if (model.isJiPai) {
        self.jiaJiaLB.text =  [NSString stringWithFormat:@"加价幅度:%@",model.stepprice.getPriceAllStr];
        self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.startprice.getPriceAllStr];
        self.jiaJiaLB.hidden = self.shuaXinAction.hidden = NO;
        
    }else {
        self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",model.productprice.getPriceAllStr];
        self.jiaJiaLB.hidden = self.shuaXinAction.hidden = YES;
    }
   
}

- (IBAction)shuaXin:(id)sender {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodid"] = self.model.ID;
    [zkRequestTool networkingPOST:liveNowgoodprice_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD dismiss];
//            self.model.startprice = responseObject[@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.moneyLB.text =  [NSString stringWithFormat:@"￥%@",self.model.startprice.getPriceAllStr];
            });
            
        }else {
            [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       
        
    }];

    
}


@end

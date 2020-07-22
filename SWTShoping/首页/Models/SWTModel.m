//
//  SWTModel.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTModel.h"

@implementation SWTModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id",@"des":@"description",@"merch_id":@"mer_id"};
}
- (void)setStorename:(NSString *)storename {
    _storename = storename;
    self.store_name = storename;
}

- (void)setLideshowlist:(NSMutableArray<SWTModel *> *)lideshowlist {
    _lideshowlist = [SWTModel mj_objectArrayWithKeyValuesArray:lideshowlist];
}

//MJCodingImplementation

- (void)setGoodlist:(NSString *)goodlist {
    _goodlist = goodlist;
    self.goodNeiList = [SWTModel mj_objectArrayWithKeyValuesArray:[goodlist mj_JSONObject]];
}

- (void)setLmCouponsList:(NSString *)lmCouponsList {
    _lmCouponsList = lmCouponsList;
    self.youHuiQuanList =  [SWTModel mj_objectArrayWithKeyValuesArray:[lmCouponsList mj_JSONObject]];
}

- (NSArray *)getTypeLBArr {
    NSMutableArray * titleArr = @[].mutableCopy;
    if (self.isauction) {
        [titleArr addObject:@"滴雨轩拍卖行"];
    }
    if (self.isdirect) {
       [titleArr addObject:@"直营店"];
    }
    if (self.isquality) {
        [titleArr addObject:@"优选好店"];
    }
    if (self.isoem) {
       [titleArr addObject:@"代工工作室"];
    }
    if (titleArr.count > 2) {
        return [titleArr subarrayWithRange:NSMakeRange(0, 2)];
    }else {
        return titleArr;
    }
}

@end

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
    return @{@"ID":@"id",@"des":@"description"};
}
//MJCodingImplementation

@end

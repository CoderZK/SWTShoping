//
//  WeiChatOtherDelegate.m
//  UnifyPayDemo
//
//  Created by MacW on 2020/3/11.
//  Copyright © 2020 LiuMengkai. All rights reserved.
//

#import "WeiChatOtherManager.h"

@implementation WeiChatOtherManager

static WeiChatOtherManager *_WXPayOtherManager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WXPayOtherManager = [[WeiChatOtherManager alloc] init];
    });
    return _WXPayOtherManager;
}

- (void)onResp:(BaseResp*)resp {
    //处理微信分享等功能
    
    
}
@end

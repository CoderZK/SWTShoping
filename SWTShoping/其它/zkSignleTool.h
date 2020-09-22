//
//  zkSignleTool.h
//  SWTShoping
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkSignleTool : NSObject

+ (zkSignleTool *)shareTool;

@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign)BOOL isHeMaiDianPu;
@property(nonatomic,strong)NSString * session_token;
//用户ID
@property(nonatomic,strong)NSString * session_uid;
@property(nonatomic,strong)NSString * nickname;
@property(nonatomic,strong)NSString * levelname;
@property(nonatomic,strong)NSString * avatar;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * phone;
@property(nonatomic,strong)NSString * deviceToken;
@property(nonatomic , strong)NSString *growth_value;
@property(nonatomic,assign)CGFloat h1;
@property(nonatomic,assign)CGFloat h2;
@property(nonatomic , strong)NSString *userSig;
@property(nonatomic , strong)NSString *selectShopID;
@property(nonatomic , strong)NSString *selectShopAvatar;
-(void)uploadDeviceToken;
@end

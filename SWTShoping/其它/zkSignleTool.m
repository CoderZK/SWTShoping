//
//  zkSignleTool.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSignleTool.h"
#import "zkRequestTool.h"
static zkSignleTool * tool = nil;


@implementation zkSignleTool

+ (zkSignleTool *)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[zkSignleTool alloc] init];
    });
    return tool;
}

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

- (void)setLevel:(NSString *)level {
    [[NSUserDefaults standardUserDefaults] setObject:level forKey:@"level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)level {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"level"];
}

- (void)setPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
          [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)phone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

- (void)setNickname:(NSString *)nickname {
      [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:@"nickname"];
       [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)nickname {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
}

-(void)setSession_token:(NSString *)session_token
{
    
    [[NSUserDefaults standardUserDefaults] setObject:session_token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
-(void)setSession_uid:(NSString *)session_uid
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",session_uid] forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_uid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
}

- (void)setUserSig:(NSString *)userSig {
    [[NSUserDefaults standardUserDefaults]setObject:userSig forKey:@"userSig"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userSig {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userSig"];
}

-(void)uploadDeviceToken
{
    if (self.isLogin&&self.session_token&&self.deviceToken)
    {
        NSDictionary * dic = @{
                               @"token":self.session_token,
                               @"type":@1,
                               @"deviceToken":self.deviceToken
                               };
//        [zkRequestTool networkingPOST:[zkFMURL GETapi_user_upTokenURL] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"上传友盟推送成功\n%@",responseObject);
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
    }
    
}



- (void)setDeviceToken:(NSString *)deviceToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *)deviceToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil) {
        return @"1";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
}

@end

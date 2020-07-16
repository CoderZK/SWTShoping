//
//  zkRequestTool.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkRequestTool.h"

@implementation zkRequestTool

//带请求头的
+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
       NSMutableDictionary *mDict = @{}.mutableCopy;
       if ([parameters isKindOfClass:[NSString class]]) {
           urlStr =  [NSString stringWithFormat:@"%@/%@",urlStr,parameters];
       }else {
          mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
       }
       NSString * versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
       AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
       NSMutableDictionary *headerFieldValueDictionary = @{}.mutableCopy;
       if ([zkSignleTool shareTool].session_token != nil) {
               if ([zkSignleTool shareTool].isLogin) {
                   
                   headerFieldValueDictionary[@"Authorization"] = [zkSignleTool shareTool].session_token;
                   headerFieldValueDictionary[@"version"] = versionStr;
                   
                  
               }else {
                   headerFieldValueDictionary[@"version"] = versionStr;
               }
           }else {
               headerFieldValueDictionary[@"version"] = versionStr;
           }
       headerFieldValueDictionary[@"Authorization"] =@"12345";
       if (headerFieldValueDictionary != nil) {
           for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
               NSString *value = headerFieldValueDictionary[httpHeaderField];
               [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
           }
       }
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
       [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];

       [manager POST:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if (success)
           {
               success(task,responseObject);
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

           [SVProgressHUD dismiss];
           if (failure)
           {
               failure(task,error);
           }
       }];

    
}

//正常请求
+(void)networkingHeadReaqestPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = @{}.mutableCopy;
    if ([parameters isKindOfClass:[NSString class]]) {
        urlStr =  [NSString stringWithFormat:@"%@/%@",urlStr,parameters];
    }else {
       mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];

    [manager POST:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SVProgressHUD dismiss];
        if (failure)
        {
            failure(task,error);
        }
    }];
    

    
    

}
+(void)networkingStringPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSLog(@"===\n%d",[parameters isKindOfClass:[NSString class]]);
    NSString * jsonStr = @"";
    if ([parameters isKindOfClass:[NSString class]]) {
         urlStr =  [NSString stringWithFormat:@"%@/%@",urlStr,parameters];
    }else {
        jsonStr = [NSString convertToJsonDataWithDict:parameters];
    }
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:parameters error:nil];
    NSString * versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            req.allHTTPHeaderFields = @{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token],@"version":versionStr};
        }else {
            req.allHTTPHeaderFields = @{@"Authorization":@"Bearer ",@"version":versionStr};
        }
    }else {
        req.allHTTPHeaderFields = @{@"Authorization":@"Bearer ",@"version":versionStr};
    }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(nil,responseObject);
        } else {
            failure(nil,error);
            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
        }
        
    }] resume];

}


+(void)networkingJsonPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString * jsonStr = [NSString convertToJsonDataWithDict:parameters];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
     NSString * versionStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
      if ([zkSignleTool shareTool].session_token != nil) {
          if ([zkSignleTool shareTool].isLogin) {
              req.allHTTPHeaderFields = @{@"Authorization":[NSString stringWithFormat:@"Bearer %@",[zkSignleTool shareTool].session_token],@"version":versionStr};
          }else {
              req.allHTTPHeaderFields = @{@"Authorization":@"Bearer ",@"version":versionStr};
          }
      }else {
          req.allHTTPHeaderFields = @{@"Authorization":@"Bearer ",@"version":versionStr};
      }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(nil,responseObject);
        } else {
            failure(nil,error);
            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
        }
        
    }] resume];
    
    //    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
    //        if (!error) {
    //            success(nil,responseObject);
    //        } else {
    //            failure(nil,error);
    //            [SVProgressHUD showErrorWithStatus:@"网络异常!!!!"];
    //        }
    //    }] resume];
    
    
}

+(void)networkingTwoPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript",@"text/x-chdr", nil];
    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //  [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
//    NSDictionary * dict = parameters;
//    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    NSURLSessionDataTask * task = [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
            return ;
        }
        
        if (failure)
        {
            failure(task,error);
        }
    }];
    
    
}





+(NSURLSessionDataTask *)networkingGET:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    NSURLSessionDataTask * task =  [manager GET:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
        }
    }];
 
    return task;
}
/**
 上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr image:(UIImage *)image andName:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSDictionary * dict = parameters;
    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:name  fileName:@"195926458462659.png" mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(task,error);
        }
    }];
}
/**
 多张上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images name:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    //    [mDict setValue:device forKey:@"deviceId"];
    //    [mDict setValue:@1 forKey:@"channel"];
    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //    [mDict setValue:version forKey:@"version"];
    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    NSDictionary * dict = parameters;
    //    //获取josnzi字符串
    //    NSString * josnStr = [NSString convertToJsonData:dict];
    //    //获取MD5字符串
    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
            
        }
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
        }
    }];
}

/**
 上传视频或者视频
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images imgName:(NSString *)name fileData:(NSData *)fileData andFileName:(NSString *)fileName parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    
//    NSDictionary * dict = parameters;
//    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
            
        }
        if (fileData) {
            [formData appendPartWithFileData:fileData name:fileName fileName:@"369369.mp4" mimeType:@"video/quicktime"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
        }
    }];
}


@end

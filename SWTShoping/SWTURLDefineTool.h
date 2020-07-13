//
//  SWTURLDefineTool.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#ifndef SWTURLDefineTool_h
#define SWTURLDefineTool_h

//正式
//#define URLOne @"http://mobile.qunyanzhujia.com:8098/qyzj/"
//测试
//#define URLOne @"http://192.168.0.38/jkgl/"
#define URLOne @"http://139.129.47.30:8080/admin/"

////图片地址
#define QiNiuImgURL @"http://web.qunyanzhujia.com/"
////视频地址地址
#define QiNiuVideoURL @"http://media.qunyanzhujia.com/"
//骑牛云的上传地址
#define QiNiuYunUploadURL @"http://upload.qiniup.com/"




//接口文档

/** 发送验证码 */
#define SMSSEND_SWT URLOne@"sms/send"

/** 注册 */
#define register_SWT URLOne@"register"

/** 登录 */
#define login_SWT URLOne@"login"



#endif /* SWTURLDefineTool_h */

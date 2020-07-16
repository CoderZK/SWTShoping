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
/** 获取用户协议 */
#define agreement_SWT URLOne@"agreement"
/** 隐私协议 */
#define privacypolicy_SWT URLOne@"privacypolicy"
/** 修改密码 */
#define editpassword_SWT URLOne@"user/editpassword"

/** 修改密码 */
#define forgetpassword_SWT URLOne@"editpassword"

/**轮播图 */
#define lideshow_SWT URLOne@"index/lideshow"
/** 一级分类接口 */
#define goodTopcategory_SWT URLOne@"good/topcategory"
/** 二级分类接口 */
#define goodChildcategory_SWT URLOne@"good/childcategory"
/** 商品详情 */
#define goodDetail_SWT URLOne@"good/detail"
/** 视频分裂接口 */
#define videoCategory_SWT URLOne@"video/category"
/**获取顶部视频信息 */
#define videoTop_SWT URLOne@"video/top"
/** 获取你喜欢的视频 */
#define videoFav_SWT URLOne@"video/fav"
/** 获取用户协议 */
#define videoDetail_SWT URLOne@"detail"
/** 获取用户协议 */
#define indexHot_SWT URLOne@"index/hot"
///** 获取用户协议 */
#define indexRecommend_SWT URLOne@"index/recommend"
///** 帮助模块 */
#define helpTop_SWT URLOne@"help/top"
///** 帮助模块的子列表 */
#define helpList_SWT URLOne@"help/list"
///**帮助模块详情 */
#define helpDetail_SWT URLOne@"help/detail"
///** 获取用信息 */
#define userDetail_SWT URLOne@"user/detail"
///** 获取用户协议 */
//#define agreement_SWT URLOne@"agreement"
///** 获取用户协议 */
//#define agreement_SWT URLOne@"agreement"
///** 获取用户协议 */
//#define agreement_SWT URLOne@"agreement"


#endif /* SWTURLDefineTool_h */

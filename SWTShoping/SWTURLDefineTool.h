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


#pragma mark ---- 会员成长值  -----
/** 获取 */
#define levelList_SWT URLOne@"level/list"

#pragma mark ---- 商品信息接口 -----
/** 根据顶级分类获取子分类 */
#define goodChildcategory_SWT URLOne@"good/childcategory"
/** 商品详情 */
#define goodDetail_SWT URLOne@"good/detail"
/** 根据分类id获取商品信息 */
#define goodList_SWT URLOne@"good/list"
/** 获取商品材质 */
#define goodMaterial_SWT URLOne@"good/material"
/** 获取商品的所有顶级分类 */
#define goodTopcategory_SWT URLOne@"good/topcategory"


#pragma mark ---- 商户信息接口  -----
/** 加入黑名单 */
#define merchAdd_black_merch_SWT URLOne@"merch/add_black_merch"
/** 获取经营主体 */
#define merchBusinessentity_SWT URLOne@"merch/businessentity"
/**获取所有顶级分类 */
#define merchCategory_SWT URLOne@"merchCategory"
/**
删除 黑名单  */
#define merchDel_black_merch_SWT URLOne@"merch/del_black_merch"
/** 获取黑名单列表type 1商户拉黑客户 2客户拉黑商户 */
#define merchGet_black_list_merch_SWT URLOne@"merch/get_black_list_merch"
/** 获取粉丝列表 */
#define merchGet_follow_list_SWT URLOne@"merch/get_follow_list"
/** 获取商户信息 */
#define merchGet_merchinfo_SWT URLOne@"merch/get_merchinfo"
/** 根据分类获取商铺信息和商品信息 */
#define merchList_SWT URLOne@"merch/list"
/** 获取主营类目 */
#define merchSellcate_SWT URLOne@"merch/sellcate"
/**
修改商户信息mobile手机 ，link联系人，deposit押金，出价条件，是否使用定金，保证金自动从余额扣除设置 */
#define merchUpdate_merchinfo_SWT URLOne@"merch/update_merchinfo"
/** 获取商品的所有顶级分类 */
#define goodTopcategory_SWT URLOne@"good/topcategory"

#pragma mark ---- 帮助信息模   -----
///** 帮助模块 */
#define helpTop_SWT URLOne@"help/top"
///** 帮助模块的子列表 */
#define helpList_SWT URLOne@"help/list"
///**帮助模块详情 */
#define helpDetail_SWT URLOne@"help/detail"


#pragma mark ---- 政策协议接口 -----
/** 获取用户协议 */
#define agreement_SWT URLOne@"agreement"
/** 隐私协议 */
#define privacypolicy_SWT URLOne@"privacypolicy"

#pragma mark ---- 用户信息接口  -----
/** 获取我的优惠券列表 */
#define userCoupon_SWT URLOne@"user/coupon"
///** 获取用信息 */
#define userDetail_SWT URLOne@"user/detail"
/** 修改密码 */
#define editpassword_SWT URLOne@"user/editpassword"
///** 获取我的收藏 */
#define userFav_SWT URLOne@"user/fav"
///** 用户关注的 */
#define userFollow_SWT URLOne@"user/follow"
/**设置支付密码接口 */
#define userPay_SWT URLOne@"user/pay"
/** 获取足迹列表 */
#define userTrace_SWT URLOne@"user/trace"

#pragma mark ---- 用户地址接口  -----
/**
新增收货地址  */
#define addressAdd_SWT URLOne@"address/add"
/** 编辑地址 */
#define addressEdit_SWT URLOne@"address/edit"
/** 获取收货地址列表接口 */
#define addressList_SWT URLOne@"address/list"

#pragma mark ---- 登录模块 -----
/** 忘记密码 */
#define forgotpassword_SWT URLOne@"forgotpassword"
/** 注册 */
#define register_SWT URLOne@"register"
/** 登录 */
#define login_SWT URLOne@"login"

#pragma mark ---- 直播功能 -----
/**获取所有顶级分类  */
#define liveTopcategory_SWT URLOne@"live/topcategory"

#pragma mark ---- 视频信息接口 -----

///**获取顶部视频信息 */
#define videoTop_SWT URLOne@"video/top"
///** 获取视频详情 */
#define videoDetail_SWT URLOne@"video/detail"
///** 根据视频分类获取视频列表 */
#define videoList_SWT URLOne@"video/list"
/** 视频分裂接口 */
#define videoCategory_SWT URLOne@"video/category"
/** 获取你喜欢的视频 */
#define videoFav_SWT URLOne@"video/fav"

#pragma mark ----订单信息接口 -----
/** 发表评论接口*/
#define orderComment_SWT URLOne@"order/comment"
/** 获取订单列表 */
#define orderList_SWT URLOne@"order/list"
/** 提交订单 */
#define orderSubmit_SWT URLOne@"order/submit"






#pragma mark ---- 商户信息接口  -----
#pragma mark ---- 商户信息接口  -----
#pragma mark ---- 商户信息接口  -----
#pragma mark ---- 商户信息接口  -----
#pragma mark ---- 商户信息接口  -----


//接口文档
#pragma mark ---- 短息 -----
/** 发送验证码 */
#define SMSSEND_SWT URLOne@"sms/send"

#pragma mark ---- 首页模块 -----
/**轮播图 */
#define lideshow_SWT URLOne@"index/lideshow"
/** 获取今日热门 */
#define indexHot_SWT URLOne@"index/hot"
///** 获取用户协议 */
#define indexRecommend_SWT URLOne@"index/recommend"











#endif /* SWTURLDefineTool_h */

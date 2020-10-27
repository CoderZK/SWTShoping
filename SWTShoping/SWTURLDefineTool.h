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
#define URLOne @"http://api.xunshun.net/api/"

//图片地址
#define QiNiuImgURL @"http://web.qunyanzhujia.com/"
//视频地址地址
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

/** 商户精选商品 */
#define goodMerchants_SWT URLOne@"good/merchants"
/**获取最新价格和出价单*/
#define goodNewprice_SWT URLOne@"good/newprice"
/**出价*/
#define goodOffer_SWT URLOne@"good/offer"
/**直播出价*/
#define liveoffer_SWT URLOne@"live/offer"


#pragma mark ---- 商户信息接口  -----
/** 加入黑名单 */
#define merchAdd_black_merch_SWT URLOne@"merch/add_black_merch"

/** 获取商户信息 */
#define merchDetail_SWT URLOne@"merch/detail"
/**
删除 黑名单  */
#define merchDel_black_merch_SWT URLOne@"merch/del_black_merch"
/** 获取黑名单列表type 1商户拉黑客户 2客户拉黑商户 */
#define merchGet_black_list_merch_SWT URLOne@"merch/get_black_list_merch"
/** 获取粉丝列表 */
#define merchGet_follow_list_SWT URLOne@"merch/get_follow_list"

/** 根据分类获取商铺信息和商品信息 */
#define merchList_SWT URLOne@"merch/list"

/** 获取注册界面展示信息 */
#define registerGet_info_SWT URLOne@"register/get_info"

/**
商户商品信息 */
#define merchMerchgood_SWT URLOne@"merch/merchgood"

/** 获取主营类目 */
#define merchSellcate_SWT URLOne@"merch/sellcate"
/**
修改商户信息mobile手机 ，link联系人，deposit押金，出价条件，是否使用定金，保证金自动从余额扣除设置 */
#define merchUpdate_merchinfo_SWT URLOne@"merch/update_merchinfo"
/** 获取商品的所有顶级分类 */
#define goodTopcategory_SWT URLOne@"good/topcategory"

#pragma mark ---- 商户信息接口  -----


/**注册第二部*/
#define registerStep1_SWT URLOne@"register/step1"
/**注册第二部*/
#define registerStep2_SWT URLOne@"register/step2"
/**店铺印象*/
#define merchImpression_SWT URLOne@"merch/impression"


#pragma mark ---- 帮助信息模   -----
/** 提交帮助 */
#define helpCommit_SWT URLOne@"help/commit"

/** 帮助模块 */
#define helpTop_SWT URLOne@"help/top"
/** 帮助模块的子列表 */
#define helpList_SWT URLOne@"help/list"
/**帮助模块详情 */
#define helpDetail_SWT URLOne@"help/detail"


#pragma mark ---- 政策协议接口 -----
/** 获取用户协议 */
#define agreement_SWT URLOne@"agreement"
/** 隐私协议 */
#define privacypolicy_SWT URLOne@"privacypolicy"

#pragma mark ---- 用户信息接口  -----

/** 获参拍记录 */
#define userAuctionlog_SWT URLOne@"user/auctionlog"
/** 咨询详情 */
#define userConsult_SWT URLOne@"user/consult"
/** 热门咨询列表 */
#define userConsultlist_SWT URLOne@"user/consultlist"



/** 修改基本信息 */
#define userEdit_SWT URLOne@"user/edit"

/** 获取我的优惠券列表 */
#define userCoupon_SWT URLOne@"user/coupon"
/** 获取用信息 */
#define userDetail_SWT URLOne@"user/detail"
/** 修改密码 */
#define editpassword_SWT URLOne@"user/editpassword"
/** 获取我的收藏 */
#define userFav_SWT URLOne@"user/fav"
/** 收藏 */
#define userFavOperate_SWT URLOne@"user/fav/operate"

/** 用户关注的 */
#define userFollow_SWT URLOne@"user/follow"
/** 关注操作 */
#define userFollowOperate_SWT URLOne@"user/follow/operate"

/** 猜你喜欢 */
#define userLike_SWT URLOne@"user/like"
/** 我的钱包 */
#define userMypackage_SWT URLOne@"user/mypackage"

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
/** 删除地址 */
#define addressDelete_SWT URLOne@"address/delete"


#pragma mark ---- 登录模块 -----
/** 忘记密码 */
#define forgotpassword_SWT URLOne@"forgotpassword"
/** 注册 */
#define register_SWT URLOne@"register"
/** 登录 */
#define login_SWT URLOne@"login"

#pragma mark ---- 直播功能 -----

/**获取直播间人数 */
#define livegetlivenum_SWT URLOne@"live/getlivenum"
/**直播间详细信息 */
#define liveDetail_SWT URLOne@"live/detail"
/**获取所有顶级分类  */
#define liveTopcategory_SWT URLOne@"live/topcategory"
/** 直播列表  */
#define liveList_SWT URLOne@"live/list"

/** 获取直播拍卖商品  */
#define liveLivegoodlist_SWT URLOne@"live/livegoodlist"
/** 获取最新价格  */
#define liveNowgoodprice_SWT URLOne@"live/nowgoodprice"
/** 检查商户直播间状态 */
#define merchliveCheck_room_SWT URLOne@"merchlive/check_room"

/** 获取直播商品列表 */
#define merchliveGet_live_goods_list_merch_SWT URLOne@"merchlive/get_live_goods_list_merch"
/** 删除直播商品 */
#define merchliveDel_live_goods_goods_list_merch_SWT URLOne@"merchlive/del_live_goods"

/** 添加商品 */
#define merchliveAdd_live_goods_SWT URLOne@"merchlive/add_live_goods"
/** 删除商品 */
#define merchliveDel_live_goods_SWT URLOne@"merchlive/del_live_goods"

/** 统计竞品数量 */
#define merchauctionCount_auction_goods_SWT URLOne@"merchauction/count_auction_goods"
/** 获取直播分类 */
#define merchliveGet_live_cate_SWT URLOne@"merchlive/get_live_cate"
/** 申请直播 */
#define merchliveAdd_room_apply_SWT URLOne@"merchlive/add_room_apply"

/** 直播开关 */
#define merchliveUpd_live_status_SWT URLOne@"merchlive/upd_live_status"
/** 商户合买订单列表 */
#define merchsharelist_SWT URLOne@"merch/sharelist"


#pragma mark ---- 视频信息接口 -----

/**获取顶部视频信息 */
#define videoTop_SWT URLOne@"video/top"
/** 获取视频详情 */
#define videoDetail_SWT URLOne@"video/detail"
/** 根据视频分类获取视频列表 */
#define videoList_SWT URLOne@"video/list"
/** 视频分裂接口 */
#define videoCategory_SWT URLOne@"video/category"
/** 获取你喜欢的视频 */
#define videoFav_SWT URLOne@"video/fav"

/** 获取视频分类 */
#define merchvideoGet_video_cate_SWT URLOne@"merchvideo/get_video_cate"
/** 添加视频 */
#define merchvideoAdd_video_SWT URLOne@"merchvideo/add_video"
/** 删除视频 */
#define merchvideoDel_video_SWT URLOne@"merchvideo/del_video"
/** 修改视频 */
#define merchvideoUpd_video_SWT URLOne@"merchvideo/upd_video"

/** 根据分类获取视频列表*/
#define merchvideoGet_video_list_SWT URLOne@"merchvideo/get_video_list"



#pragma mark ----订单信息接口 -----

/** 申请退款 */
#define orderBack_SWT URLOne@"order/back"
/** 退货地址 */
#define orderBackaddress_SWT URLOne@"order/backaddress"
/** 退货详情 */
#define orderBackdetail_SWT URLOne@"order/backdetail"
/** 物流信息填写 */
#define orderBackexpress_SWT URLOne@"order/backexpress"
/** 发表评论接口*/
#define orderComment_SWT URLOne@"order/comment"
/** 确认收货 */
#define orderDelivery_SWT URLOne@"order/delivery"
/** 修改订单地址接口 */
#define orderEditaddress_SWT URLOne@"order/editaddress"
/** 获取订单列表 */
#define orderList_SWT URLOne@"order/list"
/** 支付设置订单状态 */
#define orderPay_SWT URLOne@"order/pay"
/** 提交订单 */
#define orderSubmit_SWT URLOne@"order/submit"

/** 申请撤回 */
#define orderUndo_SWT URLOne@"order/undo"

/** 获取快递公司号 */
#define merchorderGet_express_list_SWT URLOne@"merchorder/get_express_list"

/** 提醒发货接口 */
#define pushmsgRemindsend_SWT URLOne@"pushmsg/remindsend"
/** 订单详情 */
#define orderDetail_SWT URLOne@"order/detail"


#pragma mark ---- 通用模块 -----
/** 顶部图片 */
#define topimg_SWT URLOne@"topimg"
/** 查询快递接口 */
#define expressg_SWT URLOne@"express"


/** 上传文件 */
#define uploadfile_SWT URLOne@"uploadfile"

/** 上传多文件 */
#define uploadfiles_SWT URLOne@"uploadfiles"


#pragma mark ---- 合买信息接口  -----



/** 合买商品列表 */
#define shareGoodlist_SWT URLOne@"share/goodlist"
/** 直播列表 */
#define shareList_SWT URLOne@"share/list"

/**  我的合买列表 */
#define sharesharelist_SWT URLOne@"share/sharelist"

/** 我的合买 */
#define shareMyshare_SWT URLOne@"share/myshare"
/** 订单详情 */
#define shareOrderdetail_SWT URLOne@"share/orderdetail"
/** 支付设置订单状态 */
#define sharePay_SWT URLOne@"share/pay"
/** 提交合买订单 */
#define shareSubmit_SWT URLOne@"share/submit"
/** 合买定制 */
#define shareSharelist_SWT URLOne@"share/sharelist"


/** 获取所有顶级分类 */
#define shareTopcategory_SWT URLOne@"share/topcategory"


#pragma mark ---- 消息接口  -----
/** 获取消息列表 */
#define pushmsgList_SWT URLOne@"pushmsg/list"
/** 消息详情 */
#define pushmsgDetail_SWT URLOne@"pushmsg/detail"

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
/** 获取用户协议 */
#define indexRecommend_SWT URLOne@"index/recommend"


#pragma mark ---- 支付模块 -----
/**下单请求模块 */
#define payOrder_SWT URLOne@"pay/order"
/**支付保障金 */
#define paypaymoney_SWT URLOne@"pay/paymoney"

/** 账单查询 */
#define payOrderQuery_SWT URLOne@"pay/orderQuery"
/**  */
#define payOrdersuccess_SWT URLOne@"pay/ordersuccess"

/** 订单查询支付状态 */
#define payOrderquery_SWT URLOne@"pay/orderquery"
/** 退款 */
#define payRefund_SWT URLOne@"pay/refund"

#pragma mark ---- 商户端注册模块 -----

/** 获取注册页面展示信息配置*/
#define registerGet_info_SWT URLOne@"register/get_info"

/** 获取经营主体 */
#define merchBusinessentity_SWT URLOne@"merch/businessentity"
/**获取所有顶级分类 */
#define merchCategory_SWT URLOne@"merch/category"
/** 获取商户主营类目*/
#define merchSellcate_SWT URLOne@"merch/sellcate"

#pragma mark ---- 商户端信息  -----
/** 获取商户信息*/
#define merchGet_merchinfo_SWT URLOne@"merch/get_merchinfo"
/** 商户设置*/
#define merchUpd_merchinfo_SWT URLOne@"merch/upd_merchinfo"
/** 检查是否开启商品库 */
#define merchCheck_open_SWT URLOne@"merch/check_open"
/** 开启商品库 */
#define merchDo_open_SWT URLOne@"merch/do_open"
/** 直播列表 */
#define merchGet_live_list_SWT URLOne@"merch/get_live_list"
/** 直播订单 */
#define merchGet_live_order_list_SWT URLOne@"merch/get_live_order_list"
/** 商品库页面信息 */
#define merchgoodsGet_warehouse_info_SWT URLOne@"merchgoods/get_warehouse_info"

#pragma mark ----- 商户端订单 -----

/** 获取商户订单*/
#define merchorderGet_order_list_merch_SWT URLOne@"merchorder/get_order_list_merch"
/** 获取子订单 */
#define merchorderGet_children_order_list_SWT URLOne@"merchorder/get_children_order_list"
/** 发货 */
#define merchorderSend_order_merch_SWT URLOne@"merchorder/send_order_merch"
/** 售后信息 */
#define merchorderGet_refund_info_SWT URLOne@"merchorder/get_refund_info"
/** 售后处理 */
#define merchorderAudit_order_merch_SWT URLOne@"merchorder/audit_order_merch"

#pragma mark ----- 商户端拍品 -----

/** 拍品列表*/
#define merchauctionGet_goods_list_SWT URLOne@"merchauction/get_goods_list"
/** 上下架拍品*/
#define merchauctionPull_goods_SWT URLOne@"merchauction/pull_goods"
/**统计竞拍中商品 */
#define merchauctionCount_auction_goods_SWT URLOne@"merchauction/count_auction_goods"

#pragma mark ----- 商户端商品 -----
/** 获取商品库信息 */
#define merchgoodsGet_warehouse_info_SWT URLOne@"merchgoods/get_warehouse_info"
/** 获取商品分类 */
#define merchgoodsGet_goods_cate_SWT URLOne@"merchgoods/get_goods_cate"
/** 获取商品库 */
#define merchgoodsGet_warehouse_list_SWT URLOne@"merchgoods/get_warehouse_list"
/** 获取商品材质*/
#define merchgoodsGet_material_list_SWT URLOne@"merchgoods/get_material_list"
/** 添加商品*/
#define merchgoodsAdd_goods_SWT URLOne@"merchgoods/add_goods"
/** 修改商品 */
#define merchgoodsUpd_goods_SWT URLOne@"merchgoods/upd_goods"
/** 获取商品列表 */
#define merchgoodsGet_goods_list_merch_SWT URLOne@"merchgoods/get_goods_list_merch"

/** 搜索商品 */
#define merchgoodsSer_goods_SWT URLOne@"merchgoods/ser_goods"

/** 删除商品*/
#define merchgoodsDel_goods_SWT URLOne@"merchgoods/del_goods"
/** 搜索商品*/
#define merchgoodsSer_goods_SWT URLOne@"merchgoods/ser_goods"
/** 获取商品详情*/
#define merchgoodsGet_goods_detail_SWT URLOne@"merchgoods/get_goods_detail"

#pragma mark ----- 商户端优惠券 -----
/**添加优惠券 */
#define mmerchcouponAdd_coupon_SWT URLOne@"merchcoupon/add_coupon"
/** 获取优惠券列表 */
#define merchcouponGet_coupon_list_SWT URLOne@"merchcoupon/get_coupon_list"



/**获取商家接收消息*/
#define merchmsgGet_msg_list_SWT URLOne@"merchmsg/get_msg_list"
/** 获取优惠券列表 */
#define merchcouponGet_coupon_list_SWT URLOne@"merchcoupon/get_coupon_list"

#pragma mark ----- 商户端报表 -----
/**资金报表 */
#define merchreportGet_finance_report_SWT URLOne@"merchreport/get_finance_report"
/** 成拍列表*/
#define merchreportGet_ok_list_SWT URLOne@"merchreport/get_ok_list"
/**支付列表 */
#define merchreportGet_pay_list_SWT URLOne@"merchreport/get_pay_list"
/** 退款列表*/
#define merchreportGet_refund_list_SWT URLOne@"merchreport/get_refund_list"
/**收款列表*/
#define merchreportGet_earn_list_SWT URLOne@"merchreport/get_earn_list"
/** 店铺报表*/
#define merchreportGet_merch_report_SWT URLOne@"merchreport/get_merch_report"
/** 直播订单列表*/
#define merchGet_ok_list_SWT URLOne@"merch/get_ok_list"

#pragma mark ----- 商户端合买 -----
/**合买抽签*/
#define merchlotsDraw_lots_SWT URLOne@"merchlots/draw_lots"
/** 获取抽签订单信息*/
#define merchlotsGet_lots_result_SWT URLOne@"merchlots/get_lots_result"
/**发料*/
#define merchlotsSend_lots_SWT URLOne@"merchlots/send_lots"
/** 获取合买总订单*/
#define merchcouponGet_coupon_list_SWT URLOne@"merchcoupon/get_coupon_list"
/**获取合买分订单*/
#define merchlotsGet_main_order_SWT URLOne@"merchlots/get_main_order"
/** 获取合买分订单*/
#define merchlotsGet_chipped_order_SWT URLOne@"merchlots/get_chipped_order"
/**合买商品资料上传*/
#define merchlotsAdd_lots_info_SWT URLOne@"merchlots/add_lots_info"
/** 获取上传资料记录*/
#define merchlotsGet_lots_info_SWT URLOne@"merchlots/get_lots_info"
/**获取客服IM*/
#define getimid_SWT URLOne@"getimid"
///** 首页搜索*/
#define search_SWT URLOne@"search"
/**删除系统消息*/
#define pushmsgDeletethis_SWT URLOne@"pushmsg/deletethis"
/** 管理员列表*/
#define merchadmin_list_SWT URLOne@"merch/admin_list"
/** 删除列表*/
#define merchdelete_admin_SWT URLOne@"merch/delete_admin"
/** 添加管理员*/
#define merchset_admin_SWT URLOne@"merch/set_admin"
/** 发布合买商品*/
#define merchpublicshare_SWT URLOne@"merch/publicshare"
/** 合买抽签*/
#define merchlotsdraw_lots_SWT URLOne@"merchlots/draw_lots"

/** 合买详情,商户*/
#define merchsharedetail_SWT URLOne@"merch/sharedetail"

/** 合买订单信息*/
#define orderdict_SWT URLOne@"order/dict"

/** 获取实时商品 */
#define livegetlivegood_SWT URLOne@"live/getlivegood"

/** 发布实时商品 */
#define merchpubliclivedgood_SWT URLOne@"merch/publiclivedgood"
/** 禁言 */
#define livesetlivesend_SWT URLOne@"live/setlivesend"
/** 直播一竞拍订单 */
#define livegenerorder1_SWT URLOne@"live/generorder"
/** 直播一口价和私加订单 */
#define livegenerorder2_SWT URLOne@"live/generorder2"

/** 直微信支付 */
#define paywxorder_SWT URLOne@"pay/wxorder"


#endif /* SWTURLDefineTool_h */

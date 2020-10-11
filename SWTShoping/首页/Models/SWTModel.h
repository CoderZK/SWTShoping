//
//  SWTModel.h
//  SWTShoping
//
//  Created by kunzhang on 2020/7/14.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWTModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *pic;
@property(nonatomic,strong)NSString *category_id;
@property(nonatomic,strong)NSString *storename;
@property(nonatomic,strong)NSString *keyword;
@property(nonatomic,strong)NSString *goodid;
@property(nonatomic,strong)NSString *merch_id;
@property(nonatomic,strong)NSString *merchid;
@property(nonatomic,strong)NSString *buyway;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subtitle;
@property(nonatomic,strong)NSString *goodssn;
@property(nonatomic,strong)NSString *content; //
@property(nonatomic,strong)NSString *comment; //
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *lots_status;
@property(nonatomic,strong)NSString *productprice;
@property(nonatomic,strong)NSString *marketprice;
@property(nonatomic,strong)NSString *cost_price;
@property(nonatomic,strong)NSString *buy_limit;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *expressprice;
@property(nonatomic,strong)NSString *sort;
@property(nonatomic,strong)NSString *browse_num;
@property(nonatomic,strong)NSString *sale_num;
@property(nonatomic,strong)NSString *ficti_num;
@property(nonatomic,strong)NSString *des;
@property(nonatomic,strong)NSString *stock;
@property(nonatomic,strong)NSString *video;
@property(nonatomic,strong)NSString *videos;
@property(nonatomic,strong)NSString *thumb;
@property(nonatomic,strong)NSString *thumbs;
@property(nonatomic,strong)NSString *hasoption;
@property(nonatomic,strong)NSString *is_free_freight;
@property(nonatomic,strong)NSString *create_at;
@property(nonatomic,strong)NSString *update_at;
@property(nonatomic,strong)NSString *delete_at;
@property(nonatomic,strong)NSString *startprice;
@property(nonatomic,strong)NSString *stepprice;
@property(nonatomic,strong)NSString *auction_start_time;
@property(nonatomic,strong)NSString *auction_end_time;
@property(nonatomic,strong)NSString *chippedtime;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *bidsnum;
@property(nonatomic,strong)NSString *material;
@property(nonatomic,strong)NSString *isrecommend;
@property(nonatomic,strong)NSString *freeshipping;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *playnum;
@property(nonatomic,strong)NSString *publishTime;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *tag;
@property(nonatomic,strong)NSString *good_id;
@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *spec;
@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *isfollow; // no or yes
@property(nonatomic,strong)NSString *isfav;// no or yes
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *realname;
@property(nonatomic,strong)NSString *address_info;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *goodlist;
@property(nonatomic,strong)NSString *goodimg;
@property(nonatomic,strong)NSString *goodname;
@property(nonatomic,strong)NSString *goodprice;
@property(nonatomic,strong)NSString *store_name;

@property(nonatomic,strong)NSString *categoryid;
@property(nonatomic,strong)NSString *readurl;
@property(nonatomic,strong)NSString *watchnum;
@property(nonatomic,strong)NSString *delaytime;


@property(nonatomic,strong)NSString *showtype;// 类型 live 直播 good 商品
@property(nonatomic,strong)NSString *lmCouponsList;
@property(nonatomic,strong)NSString *rate;//折扣
@property(nonatomic,strong)NSString *useprice;//折扣总金额

@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *paystatus; // 0 微信, 1支付宝 2 云闪付


@property(nonatomic,strong)NSString *merchscore;
@property(nonatomic,strong)NSString *goodper;
@property(nonatomic,strong)NSString *successper;
@property(nonatomic,strong)NSString *backper;
@property(nonatomic,strong)NSString *focusnum;
@property(nonatomic,strong)NSString *margin;
@property(nonatomic,strong)NSString *followid;
@property(nonatomic,strong)NSString *favid;
@property(nonatomic,strong)NSString *newprice;
@property(nonatomic,strong)NSString *growth_value;//分数
@property(nonatomic,strong)NSString *liveimg;
@property(nonatomic,strong)NSString *livename;
@property(nonatomic,strong)NSString *goodnum;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *express;
@property(nonatomic,strong)NSString *backstatus;// 退款状态
@property(nonatomic,strong)NSString *isshowexpress;
@property(nonatomic,strong)NSString *imgs;
@property(nonatomic,strong)NSString *reason;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *sendid;
@property(nonatomic,strong)NSString *site_name;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *refund_address;
@property(nonatomic,strong)NSString *imid;
@property(nonatomic,strong)NSString *headimg;
@property(nonatomic,strong)NSString *finishtime;
@property(nonatomic,strong)NSString *starttime;
@property(nonatomic,strong)NSString *endtime;
@property(nonatomic,strong)NSString *lot_no;
@property(nonatomic,strong)NSString *liveid;
@property(nonatomic,strong)NSString *liveisfollow;
@property(nonatomic,strong)NSString *merchisfollow;
@property(nonatomic,strong)NSString *isbuynum;
@property(nonatomic,strong)NSString *chipped_num;
@property(nonatomic,strong)NSString *chipped_price;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *levelcode;
@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSString *resttimes;
@property(nonatomic,strong)NSString *realprice;
@property(nonatomic,strong)NSString *coupons;
@property(nonatomic,strong)NSString *expressinfo;
@property(nonatomic,strong)NSString *bg_image;
@property(nonatomic,strong)NSString *idcard_front;
@property(nonatomic,strong)NSString *idcard_back;
@property(nonatomic,strong)NSString *idcard_hold;
@property(nonatomic,strong)NSString *credit;
@property(nonatomic,strong)NSString *curr_price;
@property(nonatomic,strong)NSString *idcard;
@property(nonatomic,strong)NSString *orderprice_curr;
@property(nonatomic,strong)NSString *orderprice_last;
@property(nonatomic,strong)NSString *orderpay;
@property(nonatomic,strong)NSString *orderrefund;
@property(nonatomic,strong)NSString *goodsnum;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *warehouse_str;
@property(nonatomic,strong)NSString *warehouse;
@property(nonatomic,strong)NSString *sn;
@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *link;
@property(nonatomic,strong)NSString *refund_mobile;
@property(nonatomic,strong)NSString *refund_link;
@property(nonatomic,strong)NSString *merchfollownum;
@property(nonatomic,strong)NSString *hlsurl; //播流地址
@property(nonatomic,strong)NSString *hdlurl; //播流地址
@property(nonatomic,strong)NSString *rtmpurl; //播流地址
@property(nonatomic,strong)NSString *livegroupid;//聊天室room id
@property(nonatomic,strong)NSString *pushurl;//推流地址
@property(nonatomic,strong)NSString *commentstatus;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *refundtype;
@property(nonatomic,strong)NSString *allnum;
@property(nonatomic,strong)NSString *imgnum;
@property(nonatomic,strong)NSArray *refundImgs;

@property(nonatomic,strong)NSString *memberid;
@property(nonatomic,strong)NSString *member_id;
@property(nonatomic,strong)NSString *shareorders;
@property(nonatomic,strong)NSString *lotsno;
@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *orderstatus;
@property(nonatomic,strong)NSString *value;
@property(nonatomic,strong)NSString *nowprice;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;
//@property(nonatomic,strong)NSString *o;


//@property(nonatomic,strong)NSArray *delaytime;
//@property(nonatomic,strong)NSString *commentstatus;
//@property(nonatomic,strong)NSString *gender;
//@property(nonatomic,strong)NSString *refundtype;
//@property(nonatomic,strong)NSString *allnum;
//@property(nonatomic,strong)NSString *imgnum;
//@property(nonatomic,strong)NSArray *refundImgs;
//@property(nonatomic,strong)NSArray *delaytime;
//@property(nonatomic,strong)NSString *commentstatus;
//@property(nonatomic,strong)NSString *gender;
//@property(nonatomic,strong)NSString *refundtype;
//@property(nonatomic,strong)NSString *allnum;
//@property(nonatomic,strong)NSString *imgnum;
//@property(nonatomic,strong)NSArray *refundImgs;
//@property(nonatomic,strong)NSArray *delaytime;

////转化成模型
@property(nonatomic,strong)SWTModel *merchinfo;
//@property(nonatomic,strong)SWTModel *rate;
//@property(nonatomic,strong)SWTModel *projectDetail;
//@property(nonatomic,strong)SWTModel *heartrate;
//@property(nonatomic,strong)SWTModel *weightData;
//@property(nonatomic,strong)SWTModel *bloodpressure;
//@property(nonatomic,strong)SWTModel *stepnumberData;
//@property(nonatomic,strong)SWTModel *menstrual;
//@property(nonatomic,strong)SWTModel *userInfo;
//@property(nonatomic,strong)SWTModel *healthdata;
////@property(nonatomic,strong)SWTModel *stepnumberData;
////@property(nonatomic,strong)SWTModel *menstrual;
//
//

@property(nonatomic,strong)NSMutableArray<SWTModel *> *goodNeiList;

@property(nonatomic,strong)NSMutableArray<SWTModel *> *youHuiQuanList;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *lideshowlist;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *auctionlist;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *commentlist;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *merchlist;

@property(nonatomic,strong)NSMutableArray<SWTModel *> *children;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *lotinfo;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *childorderinfo;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *sharedict;
@property(nonatomic,strong)NSMutableArray<SWTModel *> *livegoodlist;
//@property(nonatomic,strong)NSMutableArray<SWTModel *> *weightNub;
//@property(nonatomic,strong)NSMutableArray<SWTModel *> *bloodpressureNub;
//@property(nonatomic,strong)NSMutableArray<SWTModel *> *heartrateNub;
//@property(nonatomic,strong)NSMutableArray<SWTModel *> *stepNub;
//
//@property(nonatomic,strong)NSArray *times;
//
//
@property(nonatomic,assign)BOOL is_default;
@property(nonatomic,assign)BOOL isauction;//滴雨轩拍卖行
@property(nonatomic,assign)BOOL isdirect;//直营店
@property(nonatomic,assign)BOOL isoem;//代工工作室
@property(nonatomic,assign)BOOL refund ;//包退
@property(nonatomic,assign)BOOL postage ;//包邮
@property(nonatomic,assign)BOOL isquality ;//优选好点
@property(nonatomic,assign)BOOL isstep;
@property(nonatomic,assign)BOOL isopen;
@property(nonatomic,assign)BOOL islive;
@property(nonatomic,assign)BOOL ischipped;
@property(nonatomic,assign)BOOL level_open;
@property(nonatomic,assign)BOOL refund_open;

@property(nonatomic,assign)BOOL defaults_open;
@property(nonatomic,assign)BOOL autodeduct;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)BOOL isJiPai;
//@property(nonatomic,assign)BOOL refund_open;

////
////
////@property(nonatomic,assign)NSInteger type;//1图片2视频3音频4其它文件
//@property(nonatomic,assign)NSInteger payWay; //支付渠道1在线支付2到店支付
//
// // 状态1支付未回调确认(线下未支付)2支付已确认未消费（线下已支付未消费）3已消费4取消预约进行退款中5退款成功',
@property(nonatomic,assign)NSInteger auctiongoodnum;
@property(nonatomic,assign)NSInteger pricegoodnum;  // 问诊数量
@property(nonatomic,assign)NSInteger auction_status;//竞拍状态
//@property(nonatomic,assign)NSInteger doctorConsultationCnt;
//@property(nonatomic,assign)NSInteger appointment_cnt;
//@property(nonatomic,assign)NSInteger restCnt;
//@property(nonatomic,assign)NSInteger consult;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
////@property(nonatomic,assign)NSInteger appoint_num;
//
//
//@property(nonatomic,assign)CGFloat price;
//@property(nonatomic,assign)CGFloat distance;
//@property(nonatomic,assign)CGFloat latitude;
//@property(nonatomic,assign)CGFloat longitude;
//
////@property(nonatomic,assign)CGFloat price;
////@property(nonatomic,assign)CGFloat distance;
////@property(nonatomic,assign)CGFloat latitude;
////@property(nonatomic,assign)CGFloat longitude;
//
@property(nonatomic,assign)CGFloat  HHHHHH;
//获取标签
- (NSArray *)getTypeLBArr;

@end

NS_ASSUME_NONNULL_END

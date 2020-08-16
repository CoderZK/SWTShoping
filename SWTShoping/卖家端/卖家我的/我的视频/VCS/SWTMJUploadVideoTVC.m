//
//  SWTMJUploadVideoTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/16.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJUploadVideoTVC.h"
#import "SWTDianPuInfoView.h"
#import "SWTMJAddVideoTypeShowView.h"
@interface SWTMJUploadVideoTVC ()
@property(nonatomic , strong)SWTDianPuInfoView *videoNameV,*videoChooseV,*videoDesV,*videoLableV,*videoTypeV,*videoGoodV;
@property(nonatomic , strong)UIView *shopHeadPicV;
@property(nonatomic , strong)UIView *headView;
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)UIButton *headPicBt;
@property(nonatomic , strong)UIView *lableChooseV;
@property(nonatomic , strong)UIScrollView *scrollview;
@end

@implementation SWTMJUploadVideoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"上传视频";
    
    self.tableView.backgroundColor = WhiteColor;
    [self initSubV];
    
    
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
       button.titleLabel.font = kFont(13);
       [button setTitle:@"提交" forState:UIControlStateNormal];
       button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
       [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
       @weakify(self);
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           @strongify(self);
           
           
           SWTMJUploadVideoTVC * vc =[[SWTMJUploadVideoTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
           
           
       }];
       
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)initSubV {
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor =[UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    
    self.shopHeadPicV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    [self.headView addSubview:self.shopHeadPicV];
    
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(10, 30, 120, 20)];
    lb.text = @"预览图";
    lb.font = kFont(14);
    lb.textColor = CharacterColor50;
    [self.shopHeadPicV addSubview:lb];
    self.headPicBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 70, 10, 60, 60)];
    [self.headPicBt setBackgroundImage:[UIImage imageNamed:@"dyx9"] forState:UIControlStateNormal];
    //    self.headPicBt.backgroundColor =[UIColor redColor];
    
    
    [self.shopHeadPicV addSubview:self.headPicBt];
    
//    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenW, 0.5)];
//    backV.backgroundColor = lineBackColor;
//    [self.shopHeadPicV addSubview:backV];
    
    CGFloat hh = 50;
    
    self.videoChooseV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shopHeadPicV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoChooseV.leftLB.text = @"上传视频";
    self.videoChooseV.rightTF.placeholder = @"点击选择";
    self.videoChooseV.rightBt.tag = 101;
    [self.videoChooseV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoChooseV];
    
    
    
    self.videoNameV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoChooseV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:15];
    self.videoNameV.leftLB.text = @"视频名称";
    self.videoNameV.rightTF.placeholder = @"请填写视频名称";
    self.videoNameV.rightTF.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:self.videoNameV];
    
    self.videoDesV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoNameV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.videoDesV.leftLB.text = @"视频介绍";
    self.videoDesV.rightTF.placeholder = @"请填写视频介绍";
    self.videoDesV.rightTF.textAlignment = NSTextAlignmentLeft;
    [self.headView addSubview:self.videoDesV];
    
    self.videoLableV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoDesV.frame), ScreenW, hh) withIsJianTou:NO withMaxNumber:40];
    self.videoLableV.leftLB.text = @"视频标签";
    self.videoLableV.rightTF.placeholder = @"请填写";
    self.videoLableV.lineV.hidden = YES;
    [self.headView addSubview:self.videoLableV];
    
    self.lableChooseV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoLableV.frame), ScreenW, 40)];
    [self.headView addSubview:self.lableChooseV];
    UILabel * ccLB = [[UILabel alloc] init];
    ccLB =[[UILabel alloc] init];
    ccLB.font = kFont(14);
    ccLB.textColor = CharacterColor50;
    ccLB.text = @"可选标签";
    [self.lableChooseV addSubview:ccLB];
    
    
    [ccLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableChooseV).offset(10);
        make.centerY.equalTo(self.lableChooseV);
    }];
    
    UIView * backVTwo =[[UIView alloc] initWithFrame:CGRectMake(0, 39.5, ScreenW, 0.5)];
    backVTwo.backgroundColor = lineBackColor;
    [self.lableChooseV addSubview:backVTwo];
    
    self.scrollview = [[UIScrollView alloc] init];
    [self.lableChooseV addSubview:self.scrollview];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ccLB.mas_right).offset(10);
        make.right.equalTo(self.lableChooseV).offset(-5);
        make.top.equalTo(self.lableChooseV).offset(0.5);
        make.height.equalTo(@29);
    }];
    
    
    self.videoTypeV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lableChooseV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoTypeV.leftLB.text = @"视频分类";
    self.videoTypeV.rightTF.placeholder = @"点击选择";
    self.videoTypeV.rightBt.tag = 102;
    [self.videoTypeV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoTypeV];
    
    
   
    
    self.videoGoodV = [[SWTDianPuInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.videoTypeV.frame), ScreenW, hh) withIsJianTou:YES withMaxNumber:40];
    self.videoGoodV.leftLB.text = @"关联商品";
    self.videoGoodV.rightTF.placeholder = @"点击选择";
    self.videoGoodV.lineV.hidden = YES;
    self.videoGoodV.rightBt.tag = 103;
    [self.videoGoodV.rightBt  addTarget:self action:@selector(viewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:self.videoGoodV];
    
//
//    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.videoGoodV.frame), ScreenW - 20, 150)];
//    self.imgV.backgroundColor = WhiteColor;
//    self.imgV.layer.cornerRadius = 5;
//    self.imgV.clipsToBounds = YES;
//    [self.headView addSubview:self.imgV];
    
    
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.videoGoodV.frame) + 40, ScreenW - 80, 40)];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [self.headView addSubview:button];
    
    @weakify(self);
    [[self.headPicBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
    }];
    
    [[self.videoGoodV.rightBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
       
    }];
    
   
    self.nextBt = button;
    
    self.headView.mj_h = CGRectGetMaxY(self.nextBt.frame) + 40;
    
}


- (void)viewClick:(UIButton *)button {
    if (button.tag == 101) {
        //选择视频
    }else if (button.tag == 102) {
        //视频分类
        
        SWTMJAddVideoTypeShowView * showV  =[[SWTMJAddVideoTypeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        showV.type = 0;
        [showV show];
        
    }else if (button.tag == 103) {
        //关联商品
        SWTMJAddVideoTypeShowView * showV  =[[SWTMJAddVideoTypeShowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        showV.type = 1;
        [showV show];
    }
    
    
}



@end

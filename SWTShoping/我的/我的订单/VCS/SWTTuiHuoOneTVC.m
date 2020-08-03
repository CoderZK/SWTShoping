//
//  SWTTuiHuoOneTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/24.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTTuiHuoOneTVC.h"
#import "SWTTuiHuiOneCell.h"
#import "SWTMineZiLiaoCell.h"
#import "SWTFanKuiSelectView.h"
#import "SWTTiJiaoTuiHuoTwoTVC.h"
#import "SWTTuiHuoTypeCell.h"
@interface SWTTuiHuoOneTVC ()<zkPickViewDelelgate>

@property(nonatomic , strong)UIView *whiteViewOne,*whiteViewTwo,*whiteViewThree;
@property(nonatomic , strong)UIButton *tijiaoBt;
@property(nonatomic , strong)UIView *whiteThreeNeiV;
@property(nonatomic , strong)UILabel *numberLB;
@property(nonatomic , strong)UILabel *numberTwoLB;
@property(nonatomic , strong)IQTextView *TV;;
@property(nonatomic , strong)UIView *headV;
@property(nonatomic , strong)NSMutableArray *picArr;
@property(nonatomic , strong)NSString *yuanYin;
@property(nonatomic , strong)NSString *type; // 1 退款 , 2 退货退款
@property(nonatomic , strong)UIButton *nextBt;
@property(nonatomic , strong)NSArray *picStrArr;

@end

@implementation SWTTuiHuoOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = @"1";
    self.navigationItem.title = @"申请售后";
    [self.tableView registerClass:[SWTTuiHuiOneCell class] forCellReuseIdentifier:@"SWTTuiHuiOneCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineZiLiaoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTTuiHuoTypeCell" bundle:nil] forCellReuseIdentifier:@"SWTTuiHuoTypeCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.picArr = @[].mutableCopy;
    
    [self setFootV];
    
    
    
}

- (void)setFootV {
    
    self.headV.backgroundColor = BackgroundColor;
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableFooterView = self.headV;
    
    
    
    self.whiteViewTwo = [[UIView alloc] init];
    self.whiteViewTwo.backgroundColor = WhiteColor;
    //       self.whiteViewTwo.layer.cornerRadius = 5;
    //       self.whiteViewTwo.clipsToBounds = YES;
    [self.headV addSubview:self.whiteViewTwo];
    [self.whiteViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headV).offset(0);
        make.right.equalTo(self.headV).offset(0);
        make.top.equalTo(self.headV).offset(10);
        make.height.equalTo(@200);
        
    }];
    
    UILabel * lb2 = [[UILabel alloc] init];
    lb2.text = @"问题描述";
    lb2.font = kFont(14);
    [self.whiteViewTwo addSubview:lb2];
    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewTwo).offset(5);
        make.left.equalTo(self.whiteViewTwo).offset(15);
        make.height.equalTo(@20);
    }];
    
    UIView * gbackV = [[UIView alloc] init];
    gbackV.layer.cornerRadius = 3;
    gbackV.clipsToBounds = YES;
    gbackV.backgroundColor = RGB(250, 250, 250);
    [self.whiteViewTwo addSubview:gbackV];
    [gbackV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteViewTwo).offset(10);
        make.right.equalTo(self.whiteViewTwo).offset(-10);
        make.top.equalTo(lb2.mas_bottom).offset(5);
        make.bottom.equalTo(self.whiteViewTwo).offset(-10);
    }];
    
    self.TV = [[IQTextView alloc] init];
    self.TV.placeholder = @"填写退款或退货问题";
    self.TV.backgroundColor = [UIColor clearColor];
    self.TV.font = kFont(14);
    @weakify(self);
    [[[self.TV rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        
        return YES;
    }] subscribeNext:^(NSString * x) {
        @strongify(self);
        if (x.length <= 200) {
            self.numberLB.text =  [NSString stringWithFormat:@"%lu/200",(unsigned long)x.length];
        }else {
            self.numberLB.text = @"200/200";
            self.TV.text = [x substringToIndex:200];
        }
        
    }];
    
    [gbackV addSubview:self.TV];
    [self.TV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(gbackV);
        make.bottom.equalTo(gbackV).offset(-20);
    }];
    
    
    
    self.numberLB  = [[UILabel alloc] init];
    self.numberLB.font = kFont(12);
    self.numberLB.text = @"0/200";
    [gbackV addSubview:self.numberLB];
    [self.numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(gbackV);
        make.right.equalTo(gbackV).offset(-5);
        make.height.equalTo(@20);
    }];
    
    
    self.whiteViewThree = [[UIView alloc] init];
    self.whiteViewThree.backgroundColor = WhiteColor;
    //       self.whiteViewThree.layer.cornerRadius = 5;
    //       self.whiteViewThree.clipsToBounds = YES;
    [self.headV addSubview:self.whiteViewThree];
    CGFloat hh = 30 + (ScreenW - 30 - 20)/4 + 30;
    [self.whiteViewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headV).offset(0);
        make.right.equalTo(self.headV).offset(0);
        make.top.equalTo(self.whiteViewTwo.mas_bottom).offset(10);
        make.height.equalTo(@(hh + 20));
    }];
    
    UILabel * lb3 = [[UILabel alloc] init];
    lb3.text = @"添加图片 (问题图片)";
    lb3.font = kFont(14);
    [self.whiteViewThree addSubview:lb3];
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteViewThree).offset(5);
        make.left.equalTo(self.whiteViewThree).offset(15);
        make.height.equalTo(@20);
    }];
    
    self.whiteThreeNeiV =[[UIView alloc] init];
    self.whiteThreeNeiV.backgroundColor = WhiteColor;
    [self.whiteViewThree addSubview:self.whiteThreeNeiV];
    [self.whiteThreeNeiV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteViewThree).offset(10);
        make.right.equalTo(self.whiteViewThree).offset(-10);
        make.top.equalTo(lb3.mas_bottom).offset(5);
        make.bottom.equalTo(self.whiteViewThree).offset(-20);
    }];
    
    
    self.numberTwoLB  = [[UILabel alloc] init];
    self.numberTwoLB.font = kFont(12);
    [self.whiteViewThree addSubview:self.numberTwoLB];
    self.numberTwoLB.text = @"1/4";
    [self.numberTwoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.whiteViewThree).offset(-10);
        make.right.equalTo(self.whiteViewThree).offset(-15);
        make.height.equalTo(@20);
    }];
    
    
    UIButton * button  =[[UIButton alloc] init];
    [button setTitle:@"退款" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    self.nextBt = button;
    [self.headV addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW - 80));
        make.height.equalTo(@(40));
        make.centerX.equalTo(self.headV);
        make.top.equalTo(self.whiteViewThree.mas_bottom).offset(30);
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self tuihuoActionOne];
    }];
    
    [self setPics];
    
    
}

- (void)tuihuoActionOne {
    if (self.picArr.count > 0) {
        [self updateImage];
    }else {
        [self tuihuoActionTwo];
    }
}

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"comment";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfiles_SWT images:self.picArr name:@"files" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            self.picStrArr = responseObject[@"data"];
            [self tuihuoActionTwo];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)tuihuoActionTwo {
    [SVProgressHUD show];
    
    if (self.yuanYin.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择原因"];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入退款或者退货描述"];
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"context"] = self.TV.text;
    dict[@"id"] = self.model.ID;
    dict[@"imgs"] = [self.picStrArr componentsJoinedByString:@","];
    dict[@"reason"] = self.yuanYin;
    dict[@"type"] = self.type;
    [zkRequestTool networkingPOST:orderBack_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
       
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"申请退货退款成功"];
            [LTSCEventBus sendEvent:@"sucess" data:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });

        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 115;
    }
    return 45;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        SWTTuiHuiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuiOneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model= self.model;
        return cell;
    }else if (indexPath.row == 1) {
        SWTTuiHuoTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTTuiHuoTypeCell" forIndexPath:indexPath];
        cell.delegateSignal = [[RACSubject alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        [cell.delegateSignal subscribeNext:^(NSString * x) {
            @strongify(self);
            self.type = x;
            if (x.intValue == 1) {
                [self.nextBt setTitle:@"退款" forState:UIControlStateNormal];
            }else {
                [self.nextBt setTitle:@"退款退货" forState:UIControlStateNormal];
            }
        }];
        return cell;
    } else {
        SWTMineZiLiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = @"退款或退货原因";
        cell.rightLB.text = self.yuanYin;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = @[@"买错",@"发错货"].mutableCopy;
        [pickV show];
        pickV.delegate = self;
    }
    
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picArr addObject:image];
                self.numberTwoLB.text =  [NSString stringWithFormat:@"%ld/4",self.picArr.count];
                [self setPics];
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:4-self.picArr.count completion:^(NSArray *assets) {
                
                for (ALAsset *asset in assets) {
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef
                                                                scale:assetRep.scale
                                                          orientation:(UIImageOrientation)assetRep.orientation];
                    
                    if (!image) {
                        image = [[UIImage alloc] initWithCGImage:[[asset defaultRepresentation] fullScreenImage]
                                                           scale:assetRep.scale
                                                     orientation:(UIImageOrientation)assetRep.orientation];
                        
                    }
                    if (!image) {
                        CGImageRef thum = [asset aspectRatioThumbnail];
                        image = [UIImage imageWithCGImage:thum];
                    }
                    [self.picArr addObject:image];
                    self.numberTwoLB.text =  [NSString stringWithFormat:@"%ld/4",self.picArr.count];
                    [self setPics];
                }
                
                
                
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}


- (void)setPics {
    
    [self.whiteThreeNeiV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger allNu = self.picArr.count < 4 ? self.picArr.count + 1:4;
    
    CGFloat space = 10;
    CGFloat leftM = 0;
    CGFloat ww = (ScreenW - 30 - 20)/4; 
    for (int i = 0 ; i< allNu; i++) {
        
        
        
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake(leftM + (space+ ww) * i, 0, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        anNiuBt.backgroundColor = RGB(250, 250, 250);
        
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.whiteThreeNeiV addSubview:anNiuBt];
        
        UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(ww - 25 , 0, 25, 25)];
        
        deleteBt.tag = 200+i;
        [deleteBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i<self.picArr.count) {
            [anNiuBt setBackgroundImage:self.picArr[i] forState:UIControlStateNormal];
            
            [deleteBt setImage:[UIImage imageNamed:@"48"] forState:UIControlStateNormal];
            [anNiuBt addSubview:deleteBt];
        }else {
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"feedback_addpic"] forState:UIControlStateNormal];
            
            
        }
        
        
        
    }
    
}

- (void)hitAction:(UIButton *)anNiuBt {
    
    if (anNiuBt.tag >=200) {
        //删除
        [self.picArr removeObjectAtIndex:anNiuBt.tag - 200];
        [self setPics];
    }else {
        if (anNiuBt.tag - 100  == self.picArr.count) {
            //添加图片
            [self addPict];
            
        }
    }
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex
{
    self.yuanYin = @[@"买错",@"发错货"][leftIndex];
    [self.tableView reloadData];
}

@end

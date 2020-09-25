//
//  MJPublicHeMaiGoodsTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJPublicHeMaiGoodsTVC.h"
#import "SWTMineShopSettingCell.h"
#import "SWTMJAddCHanPinKuSHowView.h"
#import "SWTMineZiLiaoCell.h"
@interface MJPublicHeMaiGoodsTVC ()<UITextFieldDelegate,zkPickViewDelelgate>
@property(nonatomic,strong)NSString *nameStr,*caiLiaoStr,*fenShuStr,*pingjunMoney,*allMoneyStr,*twoID;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UIButton  *timeSBt,*timeEBt,*queRenBt;
@property(nonatomic,strong)NSIndexPath *selctIndexPath;
@property(nonatomic,strong)NSString *timeStr,*endTimeStr;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *pingMingArr;
@property(nonatomic,strong)NSString  *liveID,*imgStr;
@property(nonatomic,strong)UIImage *image;

@end

@implementation MJPublicHeMaiGoodsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布合买商品";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"SWTMineShopSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineZiLiaoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    self.footView.backgroundColor = WhiteColor;
    self.tableView.tableFooterView = self.footView;
    
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    lb.font = kFont(14);
    lb.text = @"合买时间";
    [self.footView addSubview:lb];
    
    self.timeEBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 120, 10, 110, 30)];
    self.timeEBt.titleLabel.font = kFont(10);
    [self.timeEBt setTitle:@"合买结束时间" forState:UIControlStateNormal];
    [self.timeEBt setTitleColor:CharacterColor102 forState:UIControlStateNormal];
    [self.footView addSubview:self.timeEBt];
    self.timeEBt.tag = 100;
    [self.timeEBt addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.timeSBt = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 110 - 120 - 20, 10, 110, 30)];
    self.timeSBt.titleLabel.font = kFont(10);
    [self.timeSBt setTitle:@"合买开始时间" forState:UIControlStateNormal];
    [self.timeSBt setTitleColor:CharacterColor102 forState:UIControlStateNormal];
    [self.footView addSubview:self.timeSBt];
    self.timeSBt.tag = 101;
    [self.timeSBt addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * lineV = [[UIView alloc] initWithFrame:CGRectMake(ScreenW - 140, 24.5, 20, 1)];
    lineV.backgroundColor = CharacterColor102;
    [self.footView addSubview:lineV];
    
    
    self.queRenBt = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, ScreenW - 60, 45)];
       [self.queRenBt setTitle:@"发布合买商品" forState:UIControlStateNormal];
       self.queRenBt.titleLabel.font = kFont(14);
       self.queRenBt.layer.cornerRadius = 22.5;
       self.queRenBt.clipsToBounds = YES;
       self.queRenBt.backgroundColor = RedColor;
       [self.footView  addSubview:self.queRenBt];
    self.pingMingArr = @[].mutableCopy;
    [self.queRenBt addTarget:self action:@selector(faBuAction) forControlEvents:UIControlEventTouchUpInside];
    [self getPingMingData];
    [self checkRoom];
}


- (void)getPingMingData  {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchgoodsGet_goods_cate_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.pingMingArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 60;
    }
    if (indexPath.row == 1) {
        return 80;
    }
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 1) {
        SWTMineZiLiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = @"商品图片";
        cell.rightLB.hidden = NO;
        cell.rightImgV.hidden = YES;
        cell.rightLB.hidden = YES;
        cell.rightImgV.hidden = NO;
        cell.rightImgV.image = self.image;
        return cell;
    }
    
   SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
    cell.rightTF.userInteractionEnabled = YES;
    cell.rightImgV.hidden = YES;
    cell.leftwoLB.hidden = YES;
    cell.swithBt.hidden = YES;
    cell.rightTF.placeholder = @"请填写";
    cell.rightTF.delegate = self;
    if (indexPath.row == 0) {
        cell.leftLB.text = @"合买物品";
        cell.rightTF.text = self.nameStr;
    }else if (indexPath.row == 2){
        cell.rightTF.text = self.caiLiaoStr;
        cell.leftLB.text = @"物品品种";
        cell.rightTF.placeholder = @"请选择";
        cell.rightTF.userInteractionEnabled = NO;
    }else if (indexPath.row == 3){
        cell.rightTF.text = self.fenShuStr;
        cell.leftLB.text = @"合买分数";
        cell.rightTF.placeholder = @"请选择";
        cell.rightTF.userInteractionEnabled = NO;
    }else if (indexPath.row == 4){
        cell.rightTF.text = self.allMoneyStr;
        cell.desLB.hidden = NO;
        cell.desLB.text = @"一人合买总价乘以1.05 (定制费)";
        cell.leftLB.text = @"合买总价";
    }else if (indexPath.row == 5){
        if ( self.fenShuStr.length > 0) {
            if (self.fenShuStr.intValue == 0) {
                cell.rightTF.text = [NSString stringWithFormat:@"%.02f",self.allMoneyStr.floatValue  * 1.05];
            }else {
                cell.rightTF.text = [NSString stringWithFormat:@"%.02f",self.allMoneyStr.floatValue  /self.fenShuStr.floatValue];
            }
            
        }
        
        cell.rightTF.placeholder = @"";
        cell.rightTF.userInteractionEnabled = NO;
        cell.leftLB.text = @"平均价格";
    }
    cell.rightTF.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selctIndexPath = indexPath;
    if (indexPath.row == 1) {
        
        [self addPict];
        
    }else  if (indexPath.row == 2) {
        //点击品名
        SWTMJAddCHanPinKuSHowView * pinMingV  = [[SWTMJAddCHanPinKuSHowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];;
        pinMingV.dataArray = self.pingMingArr;
        pinMingV.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [pinMingV.delegateSignal subscribeNext:^(NSDictionary *x) {
            @strongify(self);
            self.twoID = x[@"idtwo"];
            self.caiLiaoStr = x[@"name"];
            [self.tableView reloadData];
            
        }];
        [pinMingV show];
    }else if (indexPath.row == 3) {
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        NSMutableArray * arr = @[].mutableCopy;
        for (int i  = 1 ; i <= 20; i++) {
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        pickV.array = arr;
        [pickV show];
        pickV.delegate = self;
    }
    
}

- (void)timeAction:(UIButton *)button {
    if (button.tag == 101) {
        [self.tableView endEditing:YES];
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = NO;
        selectTimeV.isBaoHanHHmm = YES;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            
            if (weakSelf.endTimeStr.length != 0) {
                NSTimeInterval number = [NSString pleaseInsertStarTime:[NSString stringWithFormat:@"%@:00",timeStr] andInsertEndTime:[NSString stringWithFormat:@"%@ 00:00:00",weakSelf.endTimeStr]];
                if (number < 0) {
                    [SVProgressHUD showErrorWithStatus:@"结束时间要大于等于开时间"];
                    return;
                }else {
                    weakSelf.timeStr = timeStr;
                    [weakSelf.timeSBt setTitle:timeStr forState:UIControlStateNormal];
                    [weakSelf.tableView reloadData];
                }
                
            }else {
                weakSelf.timeStr = timeStr;
                [weakSelf.timeSBt setTitle:timeStr forState:UIControlStateNormal];
                [weakSelf.tableView reloadData];
            }
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }else  {
        [self.tableView endEditing:YES];
        SelectTimeV *selectTimeV = [[SelectTimeV alloc] init];
        selectTimeV.isCanSelectOld = NO;
        selectTimeV.isBaoHanHHmm = YES;
        selectTimeV.isCanSelectToday = YES;
        Weak(weakSelf);
        selectTimeV.block = ^(NSString *timeStr) {
            if (weakSelf.timeStr.length != 0) {
                NSTimeInterval number = [NSString pleaseInsertStarTime: [NSString stringWithFormat:@"%@:00",weakSelf.timeStr] andInsertEndTime:[NSString stringWithFormat:@"%@ 00:00:00",timeStr]];
                if (number < 0) {
                    [SVProgressHUD showErrorWithStatus:@"结束时间要大于等于开时间"];
                    return;
                }else {
                    weakSelf.endTimeStr = timeStr;
                    [weakSelf.timeEBt setTitle:timeStr forState:UIControlStateNormal];
//                    [weakSelf.tableView reloadData];
                }
                
            }else {
                weakSelf.endTimeStr = timeStr;
                [weakSelf.timeEBt setTitle:timeStr forState:UIControlStateNormal];
                [weakSelf.tableView reloadData];
            }
            
            
        };
        [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
    }
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex{
    if (self.selctIndexPath.row == 3) {
        self.fenShuStr = [NSString stringWithFormat:@"%ld",leftIndex+1];
        [self.tableView reloadData];
    }
}

- (void)checkRoom  {

    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool networkingPOST:merchliveCheck_room_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] intValue]== 200) {
            NSString * status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            if (status.intValue == 3) {
                self.liveID = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"liveid"]];
            }else if (status.intValue == 4) {
                [SVProgressHUD showErrorWithStatus:@"直播间被禁用"];
            }
            
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.image = image;
                [self updateImage];

            }];
       
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                
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
                    
                    self.image = image;
                    [self updateImage];
                  
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

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            
            [self.tableView reloadData];
            self.imgStr = responseObject[@"data"];
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineShopSettingCell * cell = (SWTMineShopSettingCell *)textField.superview.superview;
    NSIndexPath * indexPth = [self.tableView indexPathForCell:cell];
    if (indexPth.row == 4) {
        self.allMoneyStr = textField.text;
        
    }else if (indexPth.row == 0) {
        self.nameStr = textField.text;
    }
    [self.tableView reloadData];
}

//点击发布商品
- (void)faBuAction{
    [self.tableView endEditing:YES];
    if (self.nameStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名"];
        return;
    }
    if (self.imgStr.length ==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品图片"];
        return;
    }
    if (self.caiLiaoStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择品种"];
        return;
    }
    if (self.fenShuStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择合买分数"];
        return;
    }
    if (self.allMoneyStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入总价格"];
        return;
    }
    if (self.timeStr.length  == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
        return;
    }
    if (self.endTimeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"auction_end_time"] = self.endTimeStr;
    dict[@"auction_start_time"] = self.timeStr;
    dict[@"chipped_num"] = self.fenShuStr;
    if(self.fenShuStr.intValue == 1) {
        dict[@"chipped_price"] = @(self.allMoneyStr.floatValue * 1.05);
    }else {
        dict[@"chipped_price"] =  @(self.allMoneyStr.floatValue / self.fenShuStr.floatValue);
    }
    dict[@"material"] = self.caiLiaoStr;
    dict[@"img"] = self.imgStr;
    dict[@"name"] = self.nameStr;
    dict[@"price"] = self.allMoneyStr;
    dict[@"liveid"] = self.liveID;
     [zkRequestTool networkingPOST:merchpublicshare_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"添加合买商品成功"];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

@end

//
//  SWTAddMineChanPinKuTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/17.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTAddMineChanPinKuTVC.h"
#import "SWTMineShopSettingCell.h"
#import "SWTAddChanPinOneCellCell.h"
#import "SWTAddChanPinHeadView.h"
#import "SWTMJAddCHanPinKuSHowView.h"
#import "SWTMJCangKuSelectView.h"
@interface SWTAddMineChanPinKuTVC ()<UITextFieldDelegate,zkPickViewDelelgate>
@property(nonatomic , strong)NSString *bianHaoStr,*kuCunStr,*diJiaStr,*jiaJiaStr,*timeStr,*endTimeStr,*youFeiStr,*yanShiTime,*shangJiaStatus;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *pingMingArr;
@property(nonatomic , strong)NSMutableArray<SWTModel *>*caiZhiArr,*chanPinKuArr;
@property(nonatomic , assign)NSInteger  selectIndex;
@property(nonatomic , strong)NSString *typeStr,*OneID,*twoID,*caiZHiID,*thumbStr;
@property(nonatomic , strong)SWTAddChanPinHeadView *headV;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *selectCangKuArr;
@property(nonatomic , strong)NSMutableArray *picArr,*picStrArr;
@property(nonatomic,assign)BOOL isBaoYou,isPinMingSelectAll,isAddThumbPic,isHeMai;
@property(nonatomic,strong)UIImage *thumbImge;

@property(nonatomic , strong)SWTModel *dataModel;

@end

@implementation SWTAddMineChanPinKuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增产品";
    if (self.isEdit) {
        self.navigationItem.title = @"修改产品";
    }
    self.isBaoYou = YES;
    self.picArr = @[].mutableCopy;
    self.picStrArr = @[].mutableCopy;
    self.shangJiaStatus = @"0";
    UIButton * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    button.titleLabel.font = kFont(13);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //点击提交
        [self tiJiaoAction];
        
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"SWTMineShopSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTAddChanPinOneCellCell" bundle:nil] forCellReuseIdentifier:@"SWTAddChanPinOneCellCell"];
    
    [self addHeadV];
    
    self.pingMingArr = @[].mutableCopy;
    [self getPingMingData];
    self.caiZhiArr = @[].mutableCopy;
    [self getCaiZHiData];
    self.chanPinKuArr = @[].mutableCopy;
    [self getChanPinKuData];
    self.selectCangKuArr = @[].mutableCopy;
    
    if (self.isEdit) {
        [self getGetGoodDetail];
    }
    
    self.yanShiTime = @"10";
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
            if (self.isEdit) {
                for (SWTModel * pp in self.pingMingArr) {
                    if ([pp.ID isEqualToString:self.twoID]) {
                        self.headV.nameV.TF.text = pp.name;
                        return;
                    } else {
                        for (SWTModel * pNei in pp.children) {
                            if ([pNei.ID isEqualToString:self.twoID]) {
                                self.headV.nameV.TF.text = pNei.name;
                                return;
                            }
                        }
                    }
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)getCaiZHiData  {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchgoodsGet_material_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.caiZhiArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


- (void)getChanPinKuData  {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:merchgoodsGet_warehouse_list_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.chanPinKuArr = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            NSArray * chanPinKuArr = [self.dataModel.warehouse componentsSeparatedByString:@","];
            [self.selectCangKuArr removeAllObjects];
            for (SWTModel * cm in self.chanPinKuArr) {
                if ([chanPinKuArr containsObject:cm.ID]) {
                    [self.selectCangKuArr addObject:cm];
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}


//点击提交
- (void)tiJiaoAction {
    if (self.typeStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择类别"];
        return;
    }
    if (self.twoID.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择品名"];
        return;
    }
    if (self.headV.addressV.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产地"];
        return;
    }
    if (self.headV.guiGeV.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入规格"];
        return;
    }
    if (self.headV.caizhiV.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择材质"];
        return;
    }
    if (self.headV.weightV.TF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品重量"];
        return;
    }
    if (self.headV.chanPinNameTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品标题"];
        return;
    }
    if (self.headV.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品描述"];
        return;
    }
    if (self.thumbStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品主图"];
        return;
    }
    if (self.headV.picArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请至少选择一张图片"];
        return;;
    }
    
    if (self.bianHaoStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入产品编号"];
        return;;
    }
    if (self.kuCunStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入库存数量"];
        return;;
    }
    
    if (self.selectCangKuArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请至少选择添加一个产品库"];
        return;
    }
    if (self.diJiaStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入底价"];
        return;;
    }
    if (self.jiaJiaStr.length == 0 && self.typeStr.intValue == 1) {
        [SVProgressHUD showErrorWithStatus:@"请输入每次加价"];
        return;;
    }
    
    if (self.typeStr.intValue == 1) {
        if (self.jiaJiaStr.length ==0) {
            [SVProgressHUD showErrorWithStatus:@"每次加价幅度"];
        }
        if (self.timeStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
            return;
        }
        if (self.endTimeStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选结束时间"];
            return;
        }
    }
    
    if (self.isBaoYou == NO) {
        if (self.youFeiStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入邮费"];
            return;
        }
    }
    
    self.isAddThumbPic = NO;
    [self updateImage];
}

- (void)tijaoTwoAction {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"mer_id"] = [zkSignleTool shareTool].selectShopID;
    dict[@"type"] = self.typeStr;
    dict[@"category_id"] = self.twoID;
    dict[@"place"] = self.headV.addressV.TF.text;
    dict[@"spec"] = self.headV.guiGeV.TF.text;
    dict[@"material"] = self.headV.caizhiV.TF.text;
    dict[@"title"] = self.headV.chanPinNameTF.text;
    dict[@"description"] = self.headV.TV.text;
    dict[@"sn"] = self.bianHaoStr;
    dict[@"stock"] = self.kuCunStr;
    
    if (self.typeStr.intValue == 1) {
        
        if (self.endTimeStr.length == 16) {
            dict[@"auction_end_time"] = [NSString stringWithFormat:@"%@:00",self.endTimeStr];;
        }else {
             dict[@"auction_end_time"] = [NSString stringWithFormat:@"%@",self.endTimeStr];;
        }
        if (self.timeStr.length == 16) {
            dict[@"auction_start_time"] = [NSString stringWithFormat:@"%@:00",self.timeStr];;
        }else {
            dict[@"auction_start_time"] = [NSString stringWithFormat:@"%@",self.timeStr];;
        }
        dict[@"stepprice"] = self.jiaJiaStr;
    }
    NSMutableArray * arrOne = @[].mutableCopy;
    for (int i = 0 ; i < self.selectCangKuArr.count; i++) {
        [arrOne addObject:self.selectCangKuArr[i].ID];
    }
    dict[@"warehouse"] = [arrOne componentsJoinedByString:@","];
    dict[@"productprice"] = self.diJiaStr;
    dict[@"startprice"] = self.diJiaStr;
    dict[@"freeshipping"] = self.isBaoYou?@"1":@"0";
    dict[@"thumbs"] = [self.picStrArr componentsJoinedByString:@","];
    dict[@"thumb"] = self.thumbStr;
    dict[@"weight"] = self.headV.weightV.TF.text;
    dict[@"stepprice"] = self.jiaJiaStr;
    dict[@"ischipped"] = self.isHeMai?@"1":@"0";
    dict[@"delaytime"] = self.yanShiTime;
    if (self.isBaoYou == NO) {
        dict[@"expressprice"] = self.youFeiStr;
    }
    
    NSString * urlstr  = merchgoodsAdd_goods_SWT;
    if (self.isEdit) {
        urlstr =  merchgoodsUpd_goods_SWT;
        dict[@"id"] = self.ID;
        dict[@"state"] = self.shangJiaStatus;
    }
    [zkRequestTool networkingPOST:urlstr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.isEdit) {
                [SVProgressHUD showSuccessWithStatus:@"商品编辑成功成功"];
            }else {
                [SVProgressHUD showSuccessWithStatus:@"添加商品成功"];
            }
            
            
            SWTModel * wmodel = [[SWTModel alloc] init];
            wmodel.place = self.headV.addressV.TF.text;
            wmodel.spec = self.headV.guiGeV.TF.text;
            wmodel.material = self.headV.caizhiV.TF.text;
            wmodel.stock = self.kuCunStr;
            wmodel.warehouse_str = self.selectCangKuArr[0].name;
            
            if (self.addOrEditGoodSucessBlock != nil) {
                self.addOrEditGoodSucessBlock(wmodel);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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


- (void)addHeadV  {
    SWTAddChanPinHeadView * headV  = [[SWTAddChanPinHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.headV = headV;
    headV.mj_h = headV.HHHH;
    headV.picArr = @[].mutableCopy;
    headV.delegateSignal = [[RACSubject alloc] init];
    
    @weakify(self);
    [headV.delegateSignal subscribeNext:^(NSNumber * x) {
        @strongify(self);
        [self.tableView endEditing:YES];
        if (x.intValue < 150) {
            self.selectIndex = x.integerValue;
            if (x.intValue == 100) {
                //产品类别
                zkPickView * pickV = [[zkPickView alloc] init];
                pickV.arrayType = titleArray;
                pickV.array = @[@"一口价",@"竞拍"].mutableCopy;
                [pickV show];
                pickV.delegate = self;
                
            }else if (x.intValue == 101) {
                //品名
                
                SWTMJAddCHanPinKuSHowView * pinMingV  = [[SWTMJAddCHanPinKuSHowView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];;
                pinMingV.dataArray = self.pingMingArr;
                pinMingV.delegateSignal = [[RACSubject alloc] init];
                @weakify(self);
                [pinMingV.delegateSignal subscribeNext:^(NSDictionary *x) {
                    @strongify(self);
                    self.OneID = x[@"idone"];
                    self.twoID = x[@"idtwo"];
                    headV.nameV.TF.text = x[@"name"];
                    
                    
                }];
                [pinMingV show];
                
            }else if (x.integerValue == 102) {
                
                NSMutableArray * arr  =@[].mutableCopy;
                for (SWTModel * mNei in self.caiZhiArr) {
                    [arr addObject:mNei.name];
                }
                zkPickView * pickV = [[zkPickView alloc] init];
                pickV.arrayType = titleArray;
                pickV.array = arr;
                [pickV show];
                pickV.delegate = self;
                
            }else if (x.intValue == 104) {
                //上架状态
                zkPickView * pickV = [[zkPickView alloc] init];
                pickV.arrayType = titleArray;
                pickV.array = @[@"下架",@"上架"].mutableCopy;
                [pickV show];
                pickV.delegate = self;
            }
        }else {
            if (x.intValue == 197) {
                //添加主图片图片
                
                self.isAddThumbPic = YES;
                [self addPict];
                
            } else if (x.intValue == 198) {
                //添加视频
            }else if (x.intValue == 199) {
                //添加图片
                self.isAddThumbPic = NO;
                [self addPict];
            }else {
                //删除图片
                [self.picArr removeObjectAtIndex:x.intValue - 200];
                self.headV.picArr = self.picArr;
            }
        }
        
    }];
    if (self.isEdit) {
        self.headV.shangjiaStatusV.hidden = NO;
    }else {
        self.headV.shangjiaStatusV.hidden = YES;
    }
    self.tableView.tableHeaderView = headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;;
    }else if (section == 1) {
        return 2 + self.selectCangKuArr.count;
    }else {
        return 8;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == self.selectCangKuArr.count + 1) {
            return 70;
        }
        return 40;
    }
    if (indexPath.section == 2 && (indexPath.row == 1 || indexPath.row == 2  || indexPath.row == 3 || indexPath.row == 4)) {
        if (self.typeStr.intValue == 0) {
            return 0;
        }else {
            return 50;
        }
    }
    if (indexPath.section == 2 && indexPath.row == 7) {
        if (self.isBaoYou) {
            return 0;
        }else {
            return 50;
        }
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
        cell.rightTF.userInteractionEnabled = YES;
        cell.rightImgV.hidden = YES;
        cell.leftwoLB.hidden = YES;
        cell.swithBt.hidden = YES;
        cell.rightTF.placeholder = @"请填写";
        cell.rightTF.delegate = self;
        if (indexPath.row == 0) {
            cell.leftLB.text = @"编号";
            cell.rightTF.text = self.bianHaoStr;
        }else {
            cell.rightTF.text = self.kuCunStr;
            cell.leftLB.text = @"库存";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }else if (indexPath.section == 1) {
        SWTAddChanPinOneCellCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTAddChanPinOneCellCell" forIndexPath:indexPath];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (indexPath.row == 0) {
            cell.type = 0;
            cell.leftLB.text = @"产品库";
        }else if (indexPath.row == self.selectCangKuArr.count + 1) {
            cell.type = 2;
        }else {
            cell.type = 1;
            cell.leftLB.text = self.selectCangKuArr[indexPath.row - 1].name;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
        cell.rightTF.userInteractionEnabled = YES;
        cell.rightImgV.hidden = YES;
        cell.rightTF.placeholder = @"请填写";
        cell.rightTF.delegate = self;
        cell.swithBt.hidden = YES;
        cell.leftwoLB.hidden = YES;
        
        if (indexPath.row == 0) {
            
            if (self.typeStr.intValue == 0) {
                cell.leftLB.text = @"价格";
            }else {
                cell.leftLB.text = @"底价";
            }
            cell.rightTF.text = self.diJiaStr;
        }else if (indexPath.row == 1){
            cell.leftLB.text = @"加价幅度";
            cell.rightTF.text = self.jiaJiaStr;
        }else if (indexPath.row == 2){
            cell.leftLB.text = @"开始时间";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = self.timeStr;
        }else if (indexPath.row == 3){
            cell.leftLB.text = @"结束时间";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = self.endTimeStr;
        }else if  (indexPath.row == 4){
            cell.leftLB.text = @"延时拍";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = [NSString stringWithFormat:@"%@秒",self.yanShiTime];;
        } else if (indexPath.row == 5){
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.placeholder = @"";
            cell.leftLB.text = @"合买";
            cell.swithBt.hidden = NO;
            cell.swithBt.on = self.isHeMai;
            cell.swithBt.userInteractionEnabled = NO;
        }else if (indexPath.row == 6) {
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.placeholder = @"";
            cell.leftLB.text = @"包邮";
            cell.swithBt.hidden = NO;
            cell.swithBt.userInteractionEnabled = NO;
            cell.swithBt.on = self.isBaoYou;
            cell.swithBt.userInteractionEnabled = NO;
        }else if (indexPath.row == 7) {
            
            cell.leftLB.text = @"邮费";
            cell.rightTF.text = self.youFeiStr;
        }
        cell.rightTF.delegate = self;
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return cell;
    }
    
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                if (self.isAddThumbPic) {
                    self.thumbImge = image;
                    [self updateImage];
                }else {
                    [self.picArr addObject:image];
                    self.headV.picArr = self.picArr;
                }
                
                
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            NSInteger num = 4-self.picArr.count;
            if (self.isAddThumbPic ) {
                num = 1;
            }
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.maxImagesCount = num;
            imagePickerVc.videoMaximumDuration = 3;
            
            imagePickerVc.allowTakeVideo = NO;
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingImage = YES;
            imagePickerVc.allowTakePicture = NO;
            
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                
                if (self.isAddThumbPic) {
                    self.thumbImge = photos.firstObject;
                    [self updateImage];
                }else {
                    [self.picArr addObjectsFromArray:photos];
                    self.headV.picArr = self.picArr;
                }
                
                
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
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


- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineShopSettingCell * cell  = (SWTMineShopSettingCell *)textField.superview.superview;
    NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.bianHaoStr = textField.text;
        }else if (indexPath.row == 1) {
            self.kuCunStr = textField.text;
        }
    }else if (indexPath.section == 1) {
        
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.diJiaStr = textField.text;
        }else if (indexPath.row == 1) {
            self.jiaJiaStr = textField.text;
        }else if (indexPath.row == 7) {
            self.youFeiStr = textField.text;
        }
        
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && self.selectCangKuArr.count + 1 == indexPath.row) {
        [self.tableView endEditing:YES];
        SWTMJCangKuSelectView * v = [[SWTMJCangKuSelectView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        v.dataArray = self.chanPinKuArr;
        [v show];
        v.delegateSignal = [[RACSubject alloc] init];
        @weakify(self);
        [v.delegateSignal subscribeNext:^(NSMutableArray<SWTModel *> *x) {
            @strongify(self);
            self.selectCangKuArr = x;
            [self.tableView reloadData];
            
            
        }];
    }
    if (indexPath.section == 2 && indexPath.row == 6) {
        [self.tableView endEditing:YES];
        self.isBaoYou = !self.isBaoYou;
        [self.tableView reloadData];
    }
    
    if (indexPath.section == 2 && indexPath.row == 5) {
        [self.tableView endEditing:YES];
        self.isHeMai = !self.isHeMai;
        [self.tableView reloadData];
    }
    
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 2) {
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
                        [weakSelf.tableView reloadData];
                    }
                    
                }else {
                    weakSelf.timeStr = timeStr;
                    [weakSelf.tableView reloadData];
                }
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        }else if (indexPath.row == 3) {
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
                        [weakSelf.tableView reloadData];
                    }
                    
                }else {
                    weakSelf.endTimeStr = timeStr;
                    [weakSelf.tableView reloadData];
                }
                
                
            };
            [[UIApplication sharedApplication].keyWindow addSubview:selectTimeV];
        }else if (indexPath.row == 4) {
            self.selectIndex = 103;
            zkPickView * pickV = [[zkPickView alloc] init];
            pickV.arrayType = titleArray;
            pickV.array = @[@"10",@"30"].mutableCopy;
            [pickV show];
            pickV.delegate = self;
        }
    }
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    if (self.selectIndex == 100) {
        self.headV.leiBieV.TF.text = @[@"一口价",@"竞拍"][leftIndex];
        self.typeStr =  [NSString stringWithFormat:@"%ld",(long)leftIndex];
        [self.tableView reloadData];
    }else if (self.selectIndex == 102) {
        self.caiZHiID = self.caiZhiArr[leftIndex].ID;
        self.headV.caizhiV.TF.text = self.caiZhiArr[leftIndex].name;
    }else if (self.selectIndex == 103) {
        self.yanShiTime = @[@"10",@"30"][leftIndex];
    }else if (self.selectIndex == 104) {
        self.shangJiaStatus = [NSString stringWithFormat:@"%ld",(long)leftIndex];
        if (leftIndex == 0) {
            self.headV.shangjiaStatusV.TF.text = @"下架";
        }else {
            self.headV.shangjiaStatusV.TF.text = @"上架";
        }
    }
}


- (void)updateImage {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"comment";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    
    
    NSMutableArray * arrTwo = @[].mutableCopy;
    NSMutableArray * arrOne = @[].mutableCopy;
    
    if (self.isAddThumbPic) {
        [arrOne addObject:self.thumbImge];
    }else {
        for (int i = 0 ; i < self.picArr.count; i++) {
            if ([self.picArr[i] isKindOfClass:[UIImage class]]) {
                [arrOne addObject:self.picArr[i]];
            }else {
                [arrTwo addObject:self.picArr[i]];
            }
        }
    }
    
    [zkRequestTool NetWorkingUpLoad:uploadfiles_SWT images:arrOne name:@"files" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            NSArray * arr  = responseObject[@"data"];
            if (self.isAddThumbPic) {
                [SVProgressHUD dismiss];
                self.thumbStr = arr.count > 0? arr[0]:@"";
                self.headV.thumbStr = self.thumbStr;
            }else {
                self.picStrArr = @[].mutableCopy;
                [self.picStrArr addObjectsFromArray:arrTwo];
                [self.picStrArr addObjectsFromArray:arr];
                [self tijaoTwoAction];
            }
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (void)getGetGoodDetail {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.ID;
    [zkRequestTool networkingPOST:merchgoodsGet_goods_detail_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            self.dataModel = [SWTModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.tableView reloadData];
            self.headV.leiBieV.TF.text =  @[@"一口价",@"竞拍"][self.dataModel.type.intValue];
            self.typeStr = self.dataModel.type;
            
            self.headV.nameV.TF.text = @"123";
            self.twoID = self.dataModel.category_id;
            
            for (SWTModel * pp in self.pingMingArr) {
                if ([pp.ID isEqualToString:self.twoID]) {
                    self.headV.nameV.TF.text = pp.name;
                    break;
                } else {
                    for (SWTModel * pNei in pp.children) {
                        if ([pNei.ID isEqualToString:self.twoID]) {
                            self.headV.nameV.TF.text = pNei.name;
                            break;
                        }
                    }
                }
            }
            
            self.headV.addressV.TF.text = self.dataModel.place;
            self.headV.guiGeV.TF.text = self.dataModel.spec;
            self.headV.caizhiV.TF.text = self.dataModel.material;
            self.headV.chanPinNameTF.text = self.dataModel.title;
            self.headV.TV.text = self.dataModel.des;
            self.bianHaoStr = self.dataModel.sn;
            self.kuCunStr = self.dataModel.stock;
            self.diJiaStr = self.dataModel.productprice;
            self.jiaJiaStr = self.dataModel.stepprice;
            self.isBaoYou = [self.dataModel.freeshipping intValue];
            self.headV.weightV.TF.text = self.dataModel.weight;
            self.picArr = [self.dataModel.thumbs componentsSeparatedByString:@","].mutableCopy;
            self.headV.picArr = self.picArr;
            self.thumbStr = self.dataModel.thumb;
            self.headV.thumbStr = self.thumbStr;
            self.headV.shangjiaStatusV.TF.text = self.dataModel.state.intValue == 1?@"上架":@"下架";
            if (self.dataModel.state.intValue == 1) {
                self.shangJiaStatus = @"1";
            }else {
                self.shangJiaStatus = @"0";
            }
            self.timeStr = self.dataModel.auction_start_time;
            self.endTimeStr = self.dataModel.auction_end_time;
            self.youFeiStr = self.dataModel.expressprice;
            self.isHeMai = self.dataModel.ischipped;
            self.yanShiTime = self.dataModel.delaytime;
            NSArray * chanPinKuArr = [self.dataModel.warehouse componentsSeparatedByString:@","];
            [self.selectCangKuArr removeAllObjects];
            for (SWTModel * cm in self.chanPinKuArr) {
                if ([chanPinKuArr containsObject:cm.ID]) {
                    [self.selectCangKuArr addObject:cm];
                }
            }
            
            [self.tableView reloadData];
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

@end

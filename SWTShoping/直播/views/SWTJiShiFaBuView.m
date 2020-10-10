//
//  SWTJiShiFaBuView.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/28.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTJiShiFaBuView.h"
#import "SWTMineShopSettingCell.h"

@interface SWTJiShiFaBuView()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,zkPickViewDelelgate>
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIButton *leftBtBt,*rightBt,*centerBt,*imgBt,*confirmBt;
@property(nonatomic , assign)NSInteger  type;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)NSString *nameStr,*timeStr,*diJiaStr,*jiaJiaStr,*endTimeStr,*yanShiTime,*imgStr;
@property(nonatomic,strong)UIImage *image;

@end

@implementation SWTJiShiFaBuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.yanShiTime = @"10";
        self.type = 100;
        
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, ScreenH * 2 / 3)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:self.whiteV];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.whiteV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)].CGPath;
        self.whiteV.layer.mask = shapeLayer;
        
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 130)];
        [self.whiteV addSubview:self.headView];
        UIButton * chaBt  = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - 40, 0 , 40, 40)];
        
        [chaBt addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:chaBt];
        [chaBt setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, ScreenW - 80, 20)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = kFont(14);
        lb.text = @"即时创建";
        [self.headView addSubview:lb];
        self.titleLB = lb;
        
        self.imgBt = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 55)/2, 40, 55, 55)];
        self.imgBt.layer.cornerRadius = 5;
        [self.imgBt setBackgroundImage:[UIImage imageNamed:@"bbdyx72"] forState:UIControlStateNormal];
        self.imgBt.clipsToBounds = YES;
        [self.imgBt addTarget:self action:@selector(imageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:self.imgBt];
        
        
        
        
        
        self.leftBtBt = [[UIButton alloc] init];
        [self.leftBtBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.leftBtBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.leftBtBt.selected = YES;
        self.leftBtBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.leftBtBt];
        [self.leftBtBt setTitle:@"竞拍" forState:UIControlStateNormal];
        self.leftBtBt.tag = 100;
        [self.leftBtBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.centerBt = [[UIButton alloc] init];
        [self.centerBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.centerBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.centerBt.selected = NO;
        self.centerBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.centerBt];
        [self.centerBt setTitle:@"一口价" forState:UIControlStateNormal];
        self.centerBt.tag = 101;
        [self.centerBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.rightBt = [[UIButton alloc] init];
        [self.rightBt setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        [self.rightBt setTitleColor:RedColor forState:UIControlStateSelected];
        self.rightBt.selected = NO;
        self.rightBt.titleLabel.font = kFont(15);
        [self.whiteV addSubview:self.rightBt];
        [self.rightBt setTitle:@"私价" forState:UIControlStateNormal];
        self.rightBt.tag = 102;
        [self.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView   = [[UITableView alloc] init];
        self.tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        [self.whiteV addSubview:_tableView];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineShopSettingCell" bundle:nil] forCellReuseIdentifier:@"SWTMineShopSettingCell"];
        
        
        [self.leftBtBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView);
            make.top.equalTo(self.headView).offset(105);
            make.height.equalTo(@25);
            make.width.equalTo(@(ScreenW /3));
        }];
        
        [self.centerBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headView);
            make.top.equalTo(self.leftBtBt);
            make.height.equalTo(@25);
            make.width.equalTo(@(ScreenW /3));
        }];
        
        [self.rightBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headView);
            make.top.equalTo(self.leftBtBt);
            make.height.equalTo(@25);
            make.width.equalTo(@(ScreenW /3));
        }];
        
        
        
        
        self.confirmBt = [[UIButton alloc] init];
        [self.confirmBt setTitle:@"快速发布" forState:UIControlStateNormal];
        self.confirmBt.titleLabel.font = kFont(14);
        [self.confirmBt setBackgroundImage:[UIImage imageNamed:@"rbg"] forState:UIControlStateNormal];
        [self.whiteV addSubview:self.confirmBt];
        [self.confirmBt addTarget:self action:@selector(comfirmaction:) forControlEvents:UIControlEventTouchUpInside];
        [self.confirmBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteV).offset(15);
            make.right.equalTo(self.whiteV).offset(-15);
            make.height.equalTo(@40);
            if (sstatusHeight > 20) {
                make.bottom.equalTo(self.whiteV).offset(-(34+10));
            }else {
                make.bottom.equalTo(self.whiteV).offset(-10);
            }
        }];
        
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.top.equalTo(self.headView.mas_bottom);
            
            make.bottom.equalTo(self.confirmBt.mas_top).offset(-(10));
            
            
        }];
        
        
    }
    
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 100) {
        return 50;
    }else if (self.type == 101) {
        if (indexPath.row >1) {
            return 0;
        }
        return 50;
    }else {
        if (indexPath.row >2) {
            return 0;
        }
        return 50;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWTMineShopSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTMineShopSettingCell" forIndexPath:indexPath];
    cell.rightTF.userInteractionEnabled = YES;
    cell.rightImgV.hidden = YES;
    cell.rightTF.placeholder = @"请填写";
    cell.rightTF.delegate = self;
    cell.swithBt.hidden = YES;
    cell.leftwoLB.hidden = YES;
    cell.rightTF.textColor = CharacterColor50;
    if (self.type == 100) {
        if (indexPath.row == 0) {
            cell.leftLB.text = @"商品名";
            cell.rightTF.text = self.nameStr;
        }else if (indexPath.row == 1){
            cell.leftLB.text = @"价格";
            cell.rightTF.text = self.diJiaStr;
            cell.rightTF.textColor = RedColor;
        }else if (indexPath.row == 2){
            cell.leftLB.text = @"加价幅度";
            cell.rightTF.text = self.jiaJiaStr;
            cell.rightTF.textColor = RedColor;
        }else if (indexPath.row == 3){
            cell.leftLB.text = @"开始时间";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = self.timeStr;
        }else if (indexPath.row == 4){
            cell.leftLB.text = @"结束时间";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = self.endTimeStr;
        }else if  (indexPath.row == 5){
            cell.leftLB.text = @"延时拍";
            cell.rightTF.placeholder = @"请选择";
            cell.rightTF.userInteractionEnabled = NO;
            cell.rightTF.text = [NSString stringWithFormat:@"%@秒",self.yanShiTime];;
        }
    }else if (self.type == 101){
        if (indexPath.row == 0) {
            
            
            cell.leftLB.text = @"商品名";
            
            cell.rightTF.text = self.nameStr;
        }else if (indexPath.row == 1){
            cell.leftLB.text = @"价格";
            cell.rightTF.text = self.diJiaStr;
            cell.rightTF.textColor = RedColor;
        }
    }else {
        cell.rightTF.userInteractionEnabled = YES;
        if (indexPath.row == 0) {
            cell.leftLB.text = @"商品名";
            cell.rightTF.text = self.nameStr;
        }else if (indexPath.row == 1){
            cell.leftLB.text = @"价格";
            cell.rightTF.text = self.diJiaStr;
            cell.rightTF.textColor = RedColor;
        }else if (indexPath.row == 2){
            cell.leftLB.text = @"买家";
            cell.rightTF.text = self.maiJiaName;
            cell.rightTF.userInteractionEnabled = NO;
        }
    }
    
    
    
    cell.rightTF.delegate = self;
    cell.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (indexPath.row == 3) {
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
    }else if (indexPath.row == 4) {
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
    }else if (indexPath.row == 5) {
        
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = @[@"10",@"30"].mutableCopy;
        [pickV show];
        pickV.delegate = self;
    }
    
    
    
}

- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger)rightIndex {
    self.yanShiTime = @[@"10",@"30"][leftIndex];
}

- (void)comfirmaction:(UIButton *)button {
    if (self.imgStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择商品图片"];
        return;
    }
    if (self.nameStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入商品名"];
        return;
    }
    if (self.diJiaStr.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入价格"];
        return;
    }
    if (self.type == 100 ) {
        if (self.jiaJiaStr.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入每次加价幅度"];
            return;
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
    NSMutableDictionary  * dict = @{}.mutableCopy;
    dict[@"name"] = self.nameStr;
    dict[@"price"] = self.diJiaStr;
    dict[@"stepprice"] = self.jiaJiaStr;
    dict[@"starttime"] = self.timeStr;
    dict[@"endtime"] = self.endTimeStr;
    dict[@"img"] = self.imgStr;
    dict[@"type"] = @(self.type-100);
    dict[@"yanshi"] = self.yanShiTime;
    dict[@"liveid"] = self.liveid;
    dict[@"tomemberid"] = self.tomemberid;
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:merchpubliclivedgood_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"发布成功"];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
       
    }];
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMineShopSettingCell * cell  = (SWTMineShopSettingCell *)textField.superview.superview;
    NSIndexPath * indexPath  = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 0) {
        self.nameStr = textField.text;
    }else if (indexPath.row == 1) {
        self.diJiaStr = textField.text;
    }else if (indexPath.row == 2) {
        self.jiaJiaStr = textField.text;
    }
    [self.tableView reloadData];
}


- (void)setIsSiJia:(BOOL)isSiJia {
    if (isSiJia) {
        self.leftBtBt.hidden = self.centerBt.hidden = YES;
        [self.rightBt mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.headView);
        }];
        self.type = 102;
        self.rightBt.selected = YES;
    }else {
        self.rightBt.hidden = YES;
        [self.centerBt mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.headView).offset((ScreenW   / 3));
        }];
        self.leftBtBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.centerBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.type = 100;
        [self.tableView reloadData];
    }
}

- (void)clickAction:(UIButton *)button {
    button.selected = YES;
    self.type = button.tag;
    if (button.tag == 100) {
        self.centerBt.selected = self.rightBt.selected = NO;
    }else if (button.tag == 101) {
        self.leftBtBt.selected = self.rightBt.selected = NO;
    }else if (button.tag == 102) {
        self.leftBtBt.selected = self.centerBt.selected = YES;
    }
    [self.tableView reloadData];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH/3;
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0.6];
    }];
}


- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)imageAction:(UIButton *)button {
    if ([self isCanUsePicture]) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        imagePickerVc.maxImagesCount = 1;
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
            
            if (photos.count > 0) {
                self.image = photos.firstObject;
                [self updateImage];
            }
            
            
        }];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerVc animated:YES completion:nil];
        
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
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
            [[UIApplication sharedApplication].keyWindow.rootViewController showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (BOOL)isCanUsePicture{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}

@end

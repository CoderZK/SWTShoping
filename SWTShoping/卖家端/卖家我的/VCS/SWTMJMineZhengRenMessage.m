//
//  SWTMJMineZhengRenMessage.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJMineZhengRenMessage.h"
#import "SWTMJRenZhengCell.h"
#import "SWTMineShopSettingSectionV.h"
#import "SWTMJDainPuLoGoCell.h"
@interface SWTMJMineZhengRenMessage ()<UITextFieldDelegate>
@property(nonatomic , strong)NSArray *leftTitleArr;
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)UIImage *image;
@property(nonatomic , strong)NSString *headImgStr;
@property(nonatomic , strong)UIImageView *imgV;
@end

@implementation SWTMJMineZhengRenMessage

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺认证信息";
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJRenZhengCell" bundle:nil] forCellReuseIdentifier:@"cell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTMJDainPuLoGoCell" bundle:nil] forCellReuseIdentifier:@"SWTMJDainPuLoGoCell"];
       [self.tableView registerClass:[SWTMineShopSettingSectionV class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.leftTitleArr = @[@[@"实名认证"],@[@"姓名",@"电话",@"身份证",@"身份证照认证"],@[@"店铺名称",@"店铺简介",@"店铺LOGO"]];
    
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW,  150+  80)];
    
    self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, ScreenW - 40, 130)];
    self.imgV.contentMode =  UIViewContentModeScaleAspectFill;
    self.imgV.clipsToBounds = YES;
    [self.imgV sd_setImageWithURL:self.dataModel.avatar.getPicURL placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    [self.footV addSubview:self.imgV];
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(40, 170, ScreenW - 80, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"bbdyx27"] forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setTitleColor:WhiteColor forState:UIControlStateNormal];
    [button setTitle:@"确认修改" forState:UIControlStateNormal];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self editShopSetting];
    }];
    [self.footV addSubview:button];
    self.tableView.tableFooterView = self.footV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.leftTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.leftTitleArr[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3 && indexPath.section == 2) {
        return 120;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTMineShopSettingSectionV * headV  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
   if (section == 0) {
        headV.titelLB.text = @"基本信息";
    }else if (section == 1) {
        headV.titelLB.text = @"个人信息";
    }else {
        headV.titelLB.text = @"店铺信息";
    }
    return headV;;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMJRenZhengCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftTitleArr[indexPath.section][indexPath.row];
    cell.rightImgV.hidden = YES;
    if ((indexPath.section == 1 && indexPath.row == 3)|| (indexPath.section == 2 && indexPath.row == 2)) {
        cell.rightImgV.hidden = NO;
    }
    if (indexPath.section == 0) {
        cell.TF.userInteractionEnabled = NO;
        if (indexPath.row == 0) {
            cell.TF.text = @"已认证";
        }else {
           
        }
    }else if (indexPath.section == 1){
        cell.TF.userInteractionEnabled = NO;
        if (indexPath.row == 0) {
            cell.TF.text = self.dataModel.realname;
            
        }else if (indexPath.row == 1) {
            cell.TF.text = self.dataModel.mobile;
        }else if (indexPath.row == 2){
            cell.TF.text = self.dataModel.idcard;
        }else {
            cell.TF.text = @"";
        }
    }else {
        cell.TF.userInteractionEnabled = YES;
        cell.TF.delegate = self;
        if (indexPath.row == 0) {
            cell.TF.text = self.dataModel.store_name;
        }else if (indexPath.row == 1) {
            cell.TF.text = self.dataModel.des;
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (indexPath.section == 1 && indexPath.row == 3){
        [self.tableView endEditing:YES];
        NSArray * arr = @[self.dataModel.idcard_front,self.dataModel.idcard_back,self.dataModel.idcard_hold];
        [[zkPhotoShowVC alloc] initWithArray:arr index:0];
        
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
         [self.tableView endEditing:YES];
        [self addPict];
    }
    
}

- (void)addPict {
    [self.tableView endEditing:YES];
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
    dict[@"userid"] = [zkSignleTool shareTool].selectShopID;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
          
            self.headImgStr = responseObject[@"data"];
            self.imgV.image = self.image;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    SWTMJRenZhengCell * cell  =(SWTMJRenZhengCell *)textField.superview.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.dataModel.store_name = textField.text;
        }else if (indexPath.row == 1){
            self.dataModel.des = textField.text;
        }
        [self.tableView reloadData];
    }
}

- (void)editShopSetting {
    [self.tableView endEditing:YES];
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = [zkSignleTool shareTool].selectShopID;
    dict[@"avatar"] = self.headImgStr;
    dict[@"store_name"] = self.dataModel.store_name;
    dict[@"description"] = self.dataModel.des;
    [zkRequestTool networkingPOST:merchUpd_merchinfo_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            self.dataModel.avatar = self.headImgStr;
            if (self.upshopMessageBlock != nil) {
                self.upshopMessageBlock(self.dataModel);
            }
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
    
}


@end

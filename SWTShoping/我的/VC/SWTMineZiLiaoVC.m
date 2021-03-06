//
//  SWTMineZiLiaoVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMineZiLiaoVC.h"
#import "SWTMineZiLiaoCell.h"
#import "SWTMineAddressTVC.h"
#import "SWTEditPasswordVC.h"
#import "SWTMinePaySettingVC.h"
@interface SWTMineZiLiaoVC ()<zkPickViewDelelgate>
@property(nonatomic , strong)NSArray *leftArr;
@property(nonatomic , strong)UIView *footV;
@property(nonatomic , strong)UIImage *image;
@property(nonatomic , strong)NSString *nickName;
@property(nonatomic , strong)NSString *headImgStr;

@end

@implementation SWTMineZiLiaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTMineZiLiaoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.leftArr = @[@"头像",@"昵称",@"性别",@"收货地址",@"支付安全",@"修改密码"];
    [self initFV];
}

- (void)initFV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    UIButton * loginOutBt  =[[UIButton alloc] initWithFrame:CGRectMake(40, 40, ScreenW - 80, 45)];
    [loginOutBt setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    loginOutBt.layer.cornerRadius = 22.5;
    loginOutBt.clipsToBounds = YES;
    [self.footV addSubview:loginOutBt];
    [loginOutBt setTitle:@"退出登录" forState:UIControlStateNormal];
    loginOutBt.titleLabel.font = kFont(14);
    [[loginOutBt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
       [zkSignleTool shareTool].isLogin = NO;
       [zkSignleTool shareTool].session_uid = nil;
       self.tabBarController.selectedIndex = 0;
       [LTSCEventBus sendEvent:@"diss" data:nil];
       [self.navigationController popToRootViewControllerAnimated:YES];
        
//        [[V2TIMManager sharedInstance] logout:^{
//            [zkSignleTool shareTool].isLogin = NO;
//            [zkSignleTool shareTool].session_uid = nil;
//            self.tabBarController.selectedIndex = 0;
//            [LTSCEventBus sendEvent:@"diss" data:nil];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            
//        } fail:^(int code, NSString *desc) {
//            [SVProgressHUD showErrorWithStatus:@"退出登录失败,请稍后再试"];
//        }];
        
        
    }];
    self.tableView.tableFooterView = self.footV;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 50;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTMineZiLiaoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.leftArr[indexPath.row];
    cell.rightLB.hidden = NO;
    cell.rightImgV.hidden = YES;
    cell.rightLB.hidden = YES;
    if (indexPath.row == 0) {
        cell.rightImgV.hidden = NO;
        if(self.image) {
            cell.rightImgV.image = self.image;
        }else {
            [cell.rightImgV sd_setImageWithURL:[[zkSignleTool shareTool].avatar getPicURL] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        }
    }else if (indexPath.row == 1){
        cell.rightLB.hidden = NO;
        cell.rightLB.text = [zkSignleTool shareTool].nickname;
    }else if (indexPath.row == 2){
        cell.rightLB.hidden = NO;
        if (self.genderStr.length == 0 ) {
            cell.rightLB.text = @"去设置";
        }else if (self.genderStr.intValue == 1) {
            cell.rightLB.text = @"男";
        }else {
            cell.rightLB.text = @"女";
        }
    }
    cell.clipsToBounds = YES;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self addPict];
    }else if (indexPath.row == 1) {
        
        [self editNickName];
    }else if (indexPath.row == 2) {
        zkPickView * pickV = [[zkPickView alloc] init];
        pickV.arrayType = titleArray;
        pickV.array = @[@"男",@"女"].mutableCopy;
        [pickV show];
        pickV.delegate = self;
    }else if (indexPath.row == 3) {
        SWTMineAddressTVC * vc =[[SWTMineAddressTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4) {
        SWTMinePaySettingVC * vc =[[SWTMinePaySettingVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5) {
        SWTEditPasswordVC * vc =[[SWTEditPasswordVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex {
    
    [self.tableView reloadData];
    self.genderStr = @(leftIndex+1).stringValue;
    [self getEditData];
    
}


- (void)editNickName  {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField*userNameTF = alertController.textFields.firstObject;
        
        self.nickName = userNameTF.text;
        if (self.nickName.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
            return;
        }
        
        
        [self getEditData];
        
    }]];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
        
        textField.placeholder=@"请输入昵称";
        
        
        
    }];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
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
                }
                [self updateImage];
                
                
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

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            
            [self.tableView reloadData];
            self.headImgStr = responseObject[@"data"];
            [self getEditData];
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)getEditData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    if (self.headImgStr.length > 0) {
        dict[@"avatar"] = self.headImgStr;
    }
    if (self.genderStr.length > 0) {
        dict[@"gender"] = self.genderStr;
    }
    if (self.nickName.length > 0) {
        dict[@"nickname"] = self.nickName;
    }
    
    dict[@"id"] = [zkSignleTool shareTool].session_uid;
    
    [zkRequestTool networkingPOST:userEdit_SWT  parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            if (self.nickName.length > 0) {
                [zkSignleTool shareTool].nickname = self.nickName;
                
                //                   V2TIMUserFullInfo * info = [[V2TIMUserFullInfo alloc] init];
                //                   NSMutableDictionary * dict  = @{}.mutableCopy;
                //                   dict[@"nickname"] = [zkSignleTool shareTool].nickname;
                //                   dict[@"levelname"] = [zkSignleTool shareTool].levelname;
                //                   dict[@"levelcode"] = [zkSignleTool shareTool].level;
                //                   info.nickName = [dict mj_JSONString];
                //
                //                   [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
                //
                //                   } fail:^(int code, NSString *desc) {
                //
                //                   }];
                
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

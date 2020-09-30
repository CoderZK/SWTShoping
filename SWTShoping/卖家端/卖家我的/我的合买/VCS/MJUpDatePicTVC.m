//
//  MJUpDatePicTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJUpDatePicTVC.h"
#import "MJHeMaiPicCell.h"
#import <AVKit/AVKit.h>
@interface MJUpDatePicTVC ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate>
@property(nonatomic,strong)UIView *headV,*footV;
@property(nonatomic,strong)UIButton *queRenBt;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)NSMutableArray *picArr;
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic , strong)AVPlayer *avPlayer;
@property(nonatomic , strong)AVPlayerViewController *playVC;

@end

@implementation MJUpDatePicTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str1 = @"";
    NSString * str2 = @"";
    if (self.type == 1) {
        self.navigationItem.title = @"上传抽签";
        str1 = @"请上传抽签结果图片或视频";
        str2 = @"确认发布抽签结果";
    }else if (self.type == 2) {
        self.navigationItem.title = @"发布开料结果";
        str1 = @"请上传开料结果图片或视频";
        str2 = @"确认发布开料结果";
    }else if (self.type == 3) {
        self.navigationItem.title = @"发布毛坯结果";
        str1 = @"请上传毛坯结果图片或视频";
        str2 = @"确认发布毛坯结果";
    }else  {
        self.navigationItem.title = @"发布成品结果";
        str1 = @"请上传成品结果图片或视频";
        str2 = @"确认发布成品结果";
    }
    
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 80)];
    self.tableView.tableHeaderView = self.headV;
    self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, ScreenW - 30, 20)];
    self.headV.backgroundColor = WhiteColor;
    self.titleLB.text = str1;
    [self.headV addSubview:self.titleLB];
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    self.tableView.tableFooterView = self.footV;
    self.queRenBt = [[UIButton alloc] initWithFrame:CGRectMake(30, 120, ScreenW - 60, 45)];
    [self.queRenBt setTitle:str2 forState:UIControlStateNormal];
    self.queRenBt.titleLabel.font = kFont(14);
    self.queRenBt.layer.cornerRadius = 22.5;
    self.queRenBt.clipsToBounds = YES;
    self.queRenBt.backgroundColor = RedColor;
    [self.footV  addSubview:self.queRenBt];
    [self.queRenBt addTarget:self action:@selector(queRenAction ) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
    button.titleLabel.font = kFont(14);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:@"注意事项" forState:UIControlStateNormal];
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    [self.footV addSubview:button];
    [button setImage:[UIImage imageNamed:@"kkzhuyi"] forState:UIControlStateNormal];
    UILabel  * lb = [[UILabel alloc] initWithFrame:CGRectMake(25,  40 , ScreenW - 40, 16)];
    lb.font = kFont(12);
    lb.textColor = CharacterColor153;
    lb.text = @"合买原石时, 必须先拍摄原料图片后发布抽签";
    [self.footV  addSubview:lb];
    
    [self.tableView registerClass:[MJHeMaiPicCell class] forCellReuseIdentifier:@"MJHeMaiPicCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.picArr = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""].mutableCopy;
    
    if (self.type != 1) {
        NSString * videoStr = @"";
        NSArray * arr = @[];
        for (SWTModel * model  in self.dataModel.lotinfo) {
            if (model.type.intValue == self.type+1) {
                if (model.videos.length > 0) {
                    videoStr = model.videos;
                    arr = [model.imgs componentsSeparatedByString:@","];
                }else {
                    arr = [model.imgs componentsSeparatedByString:@","];
                }
            }
        }
        self.picArr[0] = videoStr;
        for (int i = 1 ; i <= arr.count; i++) {
            self.picArr[i] = arr[i-1];
        }
    }
    
}

- (void)queRenAction {
    NSMutableArray * temArr = @[].mutableCopy;
    for (int i = 1 ; i < 12; i++) {
        if ([self.picArr[i] length] > 0) {
            [temArr addObject:self.picArr[i]];
        }
    }
    
    if ([self.picArr[0] length] + temArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请至少上传一个视频或一张图片"];
        return;
    }
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"goodsid"]  = self.goodsID;
    dict[@"merchid"] = [zkSignleTool shareTool].selectShopID;
    dict[@"imgs"] = [temArr componentsJoinedByString:@","];
    dict[@"videos"] = self.picArr[0];
    dict[@"type"] = @(self.type);
    if (self.type == 4) {
        dict[@"type"] = @"5";
    }
    NSString * url = merchlotsAdd_lots_info_SWT;
    if (self.type == 3) {
        url = merchlotsdraw_lots_SWT;
    }
    
    [zkRequestTool networkingPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
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
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (ScreenW - 60)/4 * 3 + 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MJHeMaiPicCell * cell =[tableView dequeueReusableCellWithIdentifier:@"MJHeMaiPicCell" forIndexPath:indexPath];
    cell.backgroundColor = cell.contentView.backgroundColor = WhiteColor;
    cell.picArr = self.picArr;
    Weak(weakSelf);
    cell.delectBlock = ^(NSInteger index) {
        weakSelf.picArr[index] = @"";
    };
    cell.addPicBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakSelf addVideo];
        }else {
            [weakSelf addPicWithIndex:index];
        }
    };
    
    cell.clickPlayActionBlock = ^(NSInteger index) {
        NSString * video = weakSelf.picArr[0];;
        NSURL * url = [NSURL URLWithString:video];
        
        AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:url];
        weakSelf.avPlayer = avPlayer;
        weakSelf.playVC = [[AVPlayerViewController alloc] init];
        //    [self addChildViewController:self.playVC];
        weakSelf.playVC.view.frame = CGRectMake(0, 0, ScreenW, 0);
        weakSelf.playVC.player = avPlayer;
        [weakSelf.avPlayer play];
        
        [weakSelf presentViewController:weakSelf.playVC animated:YES completion:nil];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


//天机图片或者视频
- (void)addPicWithIndex:(NSInteger)index {
    
    self.selectIndex = index;
    
    [self addPict];
    
    
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
                    [self updateImage];
                }
                
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
            
            
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[zkPhotoShowVC alloc] initWithArray:@[self.picArr[self.selectIndex]] index:0];
        
    }];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    if ([self.picArr[self.selectIndex] length] > 0) {
        [ac addAction:action1];
        [ac addAction:action2];
        [ac addAction:action4];
        [ac addAction:action3];
    }else {
        [ac addAction:action1];
        [ac addAction:action2];
        [ac addAction:action3];
    }
    
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}

- (void)updateImage {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"type"] = @"head";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:@[self.image] name:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] intValue] == 200) {
            
            [self.tableView reloadData];
            self.picArr[self.selectIndex] = responseObject[@"data"];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:responseObject[@"code"] message:responseObject[@"msg"] ];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


- (void)addVideo {
    
    [self showAlertV];
    
    
}

- (void)showAlertV {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"相机录像" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            
            [self captureVideoButtonClick];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"相册视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
            [self choosePicOrVideo];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action4];
    [ac addAction:action5];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}


//相册选视频
- (void)choosePicOrVideo {
    
    if ([self isCanUsePicture]) {
        
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
        
        imagePickerVc.allowTakeVideo = YES;
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowTakePicture = NO;
        
        
        imagePickerVc.showSelectBtn = NO;
        imagePickerVc.allowCrop = YES;
        imagePickerVc.needCircleCrop = NO;
        imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
        imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
        imagePickerVc.circleCropRadius = ScreenW/2;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)captureVideoButtonClick{
    [PublicFuntionTool showCameraVideoWithViewController:self];
    Weak(weakSelf);
    [PublicFuntionTool shareTool].videoBlock = ^(NSData *data) {
        [weakSelf updateImgsToQiNiuYunWithImageArr:nil andData:data withType:2];
    };
    
}


#pragma mark ------ 如下是图片和视频的处理上传过程 ------
//视频选择结束
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    [SVProgressHUD show];
    
    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
        [self updateImgsToQiNiuYunWithImageArr:nil andData:data withType:2];
    }];
}

- (void)updateImgsToQiNiuYunWithImageArr:(NSArray *)imageArr andData:(NSData *)data withType:(NSInteger)type{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    [SVProgressHUD show];
    dict[@"type"] = @"video";
    dict[@"userid"] = [zkSignleTool shareTool].session_uid;
    [zkRequestTool NetWorkingUpLoad:uploadfile_SWT images:nil imgName:nil fileData:data andFileName:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"视频上传服务器成功"];
            self.picArr[0] =  [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            [self.tableView reloadData];
        }else {
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}

@end

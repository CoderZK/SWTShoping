//
//  SWTSendMinePingLunTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/10.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTSendMinePingLunTVC.h"
#import "SWTPingJiaHeadV.h"
@interface SWTSendMinePingLunTVC ()
@property(nonatomic , strong)SWTPingJiaHeadV *headV;
@property(nonatomic , strong)NSMutableArray<UIImage *> *picArr;
@end

@implementation SWTSendMinePingLunTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发表评价";
    self.headV  =[[SWTPingJiaHeadV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.tableView.tableHeaderView = self.headV;
    self.headV.delegateSignal = [[RACSubject alloc] init];
    @weakify(self);
    [self.headV.delegateSignal subscribeNext:^(NSString * x) {
        @strongify(self);
        if ([x isEqualToString:@"123"]) {
            //添加图片
            [self addPict];
        }else {
            //删除图片
            [self.picArr removeObjectAtIndex:x.intValue];
        }
        
        
    }];
    self.headV.model = self.model;
    
    
    UIButton  * button  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fabuAction) forControlEvents:UIControlEventTouchUpInside];
    

}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            
         
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                [self.picArr addObject:image];
                self.headV.picArr = self.picArr;

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
                   
                    self.headV.picArr = self.picArr;
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



- (void)fabuAction {
   
    
    
}


@end

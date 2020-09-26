//
//  PublicFuntionTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@class KKKKFootView;
@interface PublicFuntionTool : NSObject

+ (PublicFuntionTool *)shareTool;

#pragma mark ---- 获取图片第一帧
@property(nonatomic,copy)void(^findPlayBlock)(void);
@property(nonatomic,copy)void(^finshClickBlock)(UIButton *button);
@property(nonatomic,copy)void(^videoBlock)(NSData * data);

+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;
- (void)presentVideoVCWithNSString:(NSString *)videoStr isBenDiPath:(BOOL)isBenDi;
- (void)palyMp3WithNSSting:(NSString *)meidaStr isLocality:(BOOL )isLocality;
- (KKKKFootView *) createFootvWithTitle:(NSString *)title andImgaeName:(NSString *)imgName;
- (KKKKFootView *) createFootvTwoWithLeftTitle:(NSString *)title letfTietelColor:(UIColor *)leftColor rightTitle:(NSString *)rightTitle rightColor:(UIColor *)rightColor;
+ (void)getImageFromPHAsset:(PHAsset *)asset Complete:(void(^)(NSData * data,NSString * str))result;

+ (void)showCameraVideoWithViewController:(UIViewController *)vc;

+ (CAShapeLayer *)getBezierWithFrome:(UIView * )view andTopLeftRadi:(CGFloat)topLeftRadi BottomLeft:(CGFloat)bottomLftRadi TopRightRadi:(CGFloat)topRightRadi BottomRightRadi:(CGFloat)bottomRight ;

+ (UIImage *)imageWithColor:(UIColor *)color;



@end


@interface KKKKFootView : UIView
@property(nonatomic,copy)void(^footViewClickBlock)(UIButton *button);
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)BOOL leftCanOp,rightCanOp;

@property(nonatomic,strong)UIButton *leftBt,*rightBt;
@end


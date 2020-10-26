//
//  SWTMJTabbarVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/8/13.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTMJTabbarVC.h"
#import "SWTMJHomeVC.h"
#import "SWTMJPubulicTVC.h"
#import "SWTMJMeessageVC.h"
#import "SWTMJMineVC.h"
@interface SWTMJTabbarVC ()
{
     BaseNavigationController * _mineNavi;
}
@end

@implementation SWTMJTabbarVC

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    Weak(weakSelf);
//    [LTSCEventBus registerEvent:@"showmessage" block:^(NSNumber * data) {
//        if (data.intValue == 1) {
//            [weakSelf.tabBar showBadgeIndex:2];
//        }else {
//            [weakSelf.tabBar hideBadgeIndex:2];
//        }
//    }];
//    
//    [LTSCEventBus registerEvent:@"hiddenmessage" block:^(NSNumber * data) {
//          [weakSelf.tabBar hideBadgeIndex:2];
//       }];
    
    NSArray *imgArr=@[@"bbdyx18",@"bbdyx20",@"bbdyx22",@"bbdyx24"];
    NSArray *selectedImgArr=@[@"bbdyx19",@"bbdyx21",@"bbdyx23",@"bbdyx25"];
    NSArray *barTitleArr=@[@"首页",@"发布",@"消息",@"我的"];
    NSArray *className=@[@"SWTMJHomeVC",@"SWTMJPubulicTVC",@"SWTMJMeessageVC",@"SWTMJMineVC"];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    for (int i=0; i<className.count; i++)
    {
        NSString *str=[className objectAtIndex:i];
        BaseViewController *vc = nil;
        
        //此处创建控制器要根据自己的情况确定是否带tableView
        
        if (i== 2)
        {
           vc=[[NSClassFromString(str) alloc] init];
        }
        else
        {
            vc=[[NSClassFromString(str) alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        }
        

        NSString *str1=[imgArr objectAtIndex:i];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attrs[NSForegroundColorAttributeName] = CharacterColor70;
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = RedColor;
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        //让图片保持原来的模样，未选中的图片
        vc.tabBarItem.image=[[UIImage imageNamed:str1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //图片选中时的图片
        NSString *str2=[selectedImgArr objectAtIndex:i];
        vc.tabBarItem.selectedImage=[[UIImage imageNamed:str2] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //页面的bar上面的title值
        NSString *str3=[barTitleArr objectAtIndex:i];
        vc.tabBarItem.title=str3;
        self.tabBar.tintColor=[UIColor blackColor];
        
        //给每个页面添加导航栏
        BaseNavigationController *nav=[[BaseNavigationController alloc] initWithRootViewController:vc];
        [arr addObject:nav];
    }
 
 
    self.viewControllers=arr;
    _mineNavi = arr.lastObject;
    self.tabBar.barTintColor = [UIColor whiteColor];
}

@end

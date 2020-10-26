//
//  UITabBar+RedTabBar.m
//  54school
//
//  Created by 宋乃银 on 2018/9/10.
//  Copyright © 2018年 李晓满. All rights reserved.
//

#import "UITabBar+RedTabBar.h"

static NSInteger const badgeTag = 600; //红点起始tag值
static NSInteger const pointWidth = 6; //小红点的宽高
static NSInteger const rightRange = 9; //距离tabBar右边的距离

@implementation UITabBar (RedTabBar)

#pragma mark -- public methods

//显示小红点
- (void)showBadgeIndex:(NSInteger)index
{
    [self hideBadgeIndex:index];
    UIView *badgeView = [[UIView alloc] init];
    //设置tag值，可以通过tag值去找到对应的tabBar上面的小红点
    badgeView.tag = badgeTag + index;
    badgeView.layer.cornerRadius = pointWidth / 2;
    badgeView.backgroundColor = [UIColor redColor];
    [self addSubview:badgeView];
    
    // 设置小红点的位置
    int i = 0;
    for (UIView *subView in self.subviews){
        
       
        
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            //找到需要加小红点的view，根据frame设置小红点的位置
  
             NSLog(@"frme ==== %d ==== %@",i,subView);
            
            if (i == index) {
                //向右边的偏移量，可以根据具体情况调整
                CGFloat x = subView.frame.origin.x + subView.frame.size.width / 2 + rightRange;
                CGFloat y = pointWidth / 2;
                badgeView.frame = CGRectMake(x, y, pointWidth, pointWidth);
                
                NSLog(@"==== 展示的 %d ----%@",i,subView);
                
            }
            i++;
        }
    }
}

// 隐藏小红点
- (void)hideBadgeIndex:(NSInteger)index
{
    for (UIView *subView in self.subviews) {
        if (subView.tag == badgeTag + index) {
            [subView removeFromSuperview];
        }
    }
}


@end

//
//  GuanZhuVC.m
//  SWTShoping
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "GuanZhuVC.h"
#import "SWTMineAttentionZhiBoVC.h"
#import "SWTMineAttentionShopTVC.h"
@interface GuanZhuVC ()<UIScrollViewDelegate>
/** 三个按钮的View buttonView */
@property(nonatomic , strong)UIView *buttonView;
/** 下面的红色指示剂 */
@property(nonatomic , strong)UIView *alertView;
/** 滚动视图 */
@property(nonatomic , strong)UIScrollView *scrollview;
/** 选中的button */
@property(nonatomic , strong)UIButton *selectBt;
@property(nonatomic,strong)UIButton *editBt;



@end

@implementation GuanZhuVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关注";
    self.view.backgroundColor = BackgroundColor;
    
    
        //设置下面的三个按钮
         [self setupHeaderView];
            //添加字控制器
         [self addChildsVC];
            //添加滚动视图
         [self addScrollview];
    
}


//添加滚动视图
- (void)addScrollview {
    //不需要调整inset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollview =[[UIScrollView alloc] init];
    self.scrollview.frame = CGRectMake(0, 40 , ScreenW, ScreenH  - 40 - 49);
    if (sstatusHeight > 20) {
        self.scrollview.frame = CGRectMake(0, 40 , ScreenW, ScreenH  - 40 - 49 - 34);
    }
    
    self.scrollview.backgroundColor =[UIColor whiteColor];
    
    self.scrollview.contentSize = CGSizeMake(self.childViewControllers.count * ScreenW, 0);
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    [self.view insertSubview:_scrollview atIndex:1];
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.scrollEnabled = YES;
    
    //调用动画结束时,使第一个界面有数据.
    [self scrollViewDidEndScrollingAnimation:_scrollview];
    

    
    
}




//设置三个按钮
- (void)setupHeaderView {
    NSArray *array = @[@"直播",@"店铺"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    
    self.buttonView = view;
//    self.buttonView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1"]];
    self.buttonView.backgroundColor = BackgroundColor;
    [self.view addSubview:self.buttonView];
    
    self.alertView =[[UIView alloc] init];
    self.alertView.backgroundColor = RedColor;
    self.alertView.height = 2;
    self.alertView.y = 35 - 3;
    
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * button =[UIButton new];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        //不可以点击时时红色
        [button setTitleColor:RedColor forState:UIControlStateDisabled];
        button.tag =i;
        CGFloat ww = 100;
        button.width = ww;
        button.height = 35;
        button.x = (ScreenW - 200)/2 + i * ww;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.buttonView addSubview:button];
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0 ) {
            [button layoutIfNeeded];
            [button.titleLabel sizeToFit];
            button.enabled = NO;
            
            self.selectBt = button;
            self.alertView.width = button.titleLabel.width;
            self.alertView.centerX = button.centerX;
        }
        
    }
    [self.buttonView addSubview:self.alertView];
    
}

//点击上面分类按钮
- (void)clickbutton:(UIButton *)button {
    //设置当前的button 的选中状态
    self.selectBt.enabled = YES;
    button.enabled = NO;
    self.selectBt = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.alertView.width = button.titleLabel.width;
        self.alertView.centerX = button.centerX;
        
    }];
    
    CGPoint Offset = self.scrollview.contentOffset;
    Offset.x = button.tag * self.scrollview.width;
    //设置偏移量,可以移动
    [self.scrollview setContentOffset:Offset animated:YES];
   
    
    
}

//添加子控制器
- (void)addChildsVC {
   
    
    SWTMineAttentionZhiBoVC * vc1 = [[SWTMineAttentionZhiBoVC alloc] init];
    [self addChildViewController:vc1];
    SWTMineAttentionShopTVC * vc2 = [[SWTMineAttentionShopTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
    [self addChildViewController:vc2];
    
    
    
}
//滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //调用动画结束时的方法.
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self clickbutton:self.buttonView.subviews[index]];
    
    
    
    
    
}

//动画结束时的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    BaseViewController * vc = self.childViewControllers[index];
    //要设置fram 不然系统会自动去掉状态栏高度
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, _scrollview.width, _scrollview.height);
    // vc.view.x = scrollView.contentOffset.x;
    // vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
//    vc.tableView.scrollIndicatorInsets = vc.collectionView.contentInset;
    [scrollView addSubview:vc.view];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

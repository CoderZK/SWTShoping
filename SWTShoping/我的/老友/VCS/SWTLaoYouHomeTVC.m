//
//  SWTLaoYouHomeTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/5.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouHomeTVC.h"
#import "SWTLaoYouHomeHeadView.h"
#import "SWTLaoYouTwoCell.h"
#import "SWTLaoYouThreeCell.h"
#import "SWTLaoYouPinLeiCell.h"
#import "SWTLaoYouKaiDianLiuChengCell.h"
#import "SWTLaoYouSectionHeadView.h"
#import "SWTLaoYouDianPuInfoOneTVC.h"
@interface SWTLaoYouHomeTVC ()
@property(nonatomic , strong)SWTLaoYouHomeHeadView *headV;
@property(nonatomic , strong)UIView*footV;
@property(nonatomic , strong)NSMutableDictionary *dataDict;
@property(nonatomic , strong)NSMutableArray<SWTModel *> *dataArrayTwo;


@end

@implementation SWTLaoYouHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我要开店";
    [self initAddHeadV];
    self.dataDict = @{}.mutableCopy;
    
    [self.tableView registerClass:[SWTLaoYouTwoCell class] forCellReuseIdentifier:@"SWTLaoYouTwoCell"];
    [self.tableView registerClass:[SWTLaoYouThreeCell class] forCellReuseIdentifier:@"SWTLaoYouThreeCell"];
    [self.tableView registerClass:[SWTLaoYouPinLeiCell class] forCellReuseIdentifier:@"SWTLaoYouPinLeiCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouKaiDianLiuChengCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouKaiDianLiuChengCell"];
    
    [self.tableView registerClass:[SWTLaoYouSectionHeadView class] forHeaderFooterViewReuseIdentifier:@"head"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(182, 142, 101);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 40;
    [self initFootV];
    self.dataArrayTwo = @[].mutableCopy;
    [self getDataTwo];
    
    [self getData];
    
}

- (void)getData {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:registerGet_info_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            NSDictionary * dict  = responseObject[@"data"];
            self.dataDict = [dict mutableCopy];
            self.headV.dataDict = self.dataDict;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)initFootV {
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    self.footV.backgroundColor = WhiteColor;
    
    UIButton * button  =[[UIButton alloc] initWithFrame:CGRectMake(30, 50, ScreenW - 60, 40)];
    [button setTitle:@"立即开店" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [button setBackgroundImage:[UIImage imageNamed:@"bg_href"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 20;
    button.clipsToBounds = YES;
    [self.footV addSubview:button];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        SWTLaoYouDianPuInfoOneTVC * vc =[[SWTLaoYouDianPuInfoOneTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    self.tableView.tableFooterView = self.footV;
    
}

- (void)initAddHeadV{
    self.headV =[[SWTLaoYouHomeHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    
    self.tableView.tableHeaderView = self.headV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataDict== nil) {
        return 0;
    }
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }else if (indexPath.row == 1) {
            
            if (self.dataDict == nil) {
                return 0;
            }else {
                
                
                NSString *htmlStr = [NSString stringWithFormat:@"%@",self.dataDict[@"modelcontent1"]];
            
                if (htmlStr.length == 0 || [htmlStr isEqualToString:@"(null)"]) {
                    return 0;
                }
                
                //富文本，两种都可以
                NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
                NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
                //或者
                //    NSDictionary *option = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType};
                //    NSData *data = [htmlStr dataUsingEncoding:NSUnicodeStringEncoding];
                //设置富文本
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
                //设置段落格式
                NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
                para.lineSpacing = 4;
                para.paragraphSpacing = 10;
                [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
                
                
                //设置文本的Font没有效果，默认12字号，这个只能服务器端控制吗？ 暂时没有找到方法修改字号
//                [attStr addAttribute:NSFontAttributeName value:para range:NSMakeRange(0, attStr.length)];
                //计算加载完成之后Label的frame
                //              CGFloat hh =  [attStr boundingRectWithSize:CGSizeMake(ScreenW - 20 - 30 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
                
                CGFloat  hh  = [attStr boundingRectWithSize:CGSizeMake(ScreenW - 50, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
                return hh+70;
            }
            
        }else {
            CGFloat hh1 = [self.dataDict[@"modelsublabel1"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel1"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            CGFloat hh2 = [self.dataDict[@"modelsublabel2"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel2"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            CGFloat hh3 = [self.dataDict[@"modelsublabel3"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel3"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            return 70 + hh1+hh2+hh3;
        }
    }else if (indexPath.section == 1){
        if (self.dataArrayTwo.count <4) {
            return 90;
        }else {
            return 180;
        }
        
        
    }else {
        return 52+(ScreenW - 20)/5.0;
    }
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SWTLaoYouTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouTwoCell" forIndexPath:indexPath];
            cell.dataDict = self.dataDict;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            SWTLaoYouThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouThreeCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.type = indexPath.row;
            if (indexPath.row == 1) {
                cell.htmlStr = self.dataDict[@"modelcontent1"];
                cell.titleStr = self.dataDict[@"modeltitle1"];
            }else {
                cell.dataDict = self.dataDict;
                cell.titleStr = self.dataDict[@"modeltitle2"];
            }
            
            cell.clipsToBounds = YES;
            return cell;
        }
    }else if (indexPath.section == 1) {
        
        SWTLaoYouPinLeiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouPinLeiCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataArray = self.dataArrayTwo;
        return cell;
    }else {
        SWTLaoYouKaiDianLiuChengCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouKaiDianLiuChengCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else if (section == 1) {
        return 50;
    }else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SWTLaoYouSectionHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (section == 1) {
        view.titleLB.text = @"品类招聘";
    }else if (section == 2){
        view.titleLB.text = @"快速开店";
    }
    view.backgroundColor = WhiteColor;
    view.clipsToBounds = YES;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


//分类
- (void)getDataTwo {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:goodTopcategory_SWT parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        if ([responseObject[@"code"] intValue]== 200) {
            
            
            self.dataArrayTwo = [SWTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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


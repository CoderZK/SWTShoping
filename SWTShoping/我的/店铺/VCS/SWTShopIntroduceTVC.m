//
//  SWTShopIntroduceTVC.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/19.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTShopIntroduceTVC.h"
#import "SWTShopIntorduceHeadView.h"
#import "SWTShopIntroduceCell.h"
#import "SWTShopIntroduceThreeCell.h"
#import "SWTShopIntroduceTwoCell.h"
@interface SWTShopIntroduceTVC ()
@property(nonatomic , strong)SWTShopIntorduceHeadView *headV;
@property(nonatomic , assign)NSInteger  type;
@end

@implementation SWTShopIntroduceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺印象";
    
    [self initHedV];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceCell"];

     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceTwoCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SWTShopIntroduceThreeCell" bundle:nil] forCellReuseIdentifier:@"SWTShopIntroduceThreeCell"];
    
    self.tableView.estimatedRowHeight = 40;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type == 0) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 34+40;
    }
    return UITableViewAutomaticDimension;
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SWTShopIntroduceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1) {
        SWTShopIntroduceTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceTwoCell" forIndexPath:indexPath];
        return cell;
    }else {
        SWTShopIntroduceThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTShopIntroduceThreeCell" forIndexPath:indexPath];
        return cell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}



- (void)initHedV  {
    self.headV = [[SWTShopIntorduceHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 165)];
    self.tableView.tableHeaderView = self.headV;
}


@end

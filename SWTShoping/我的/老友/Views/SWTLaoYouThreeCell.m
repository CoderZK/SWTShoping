//
//  SWTLaoYouThreeCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/7/6.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTLaoYouThreeCell.h"
#import "SWTLaoYouDesNeiOneCell.h"
#import "SWTLaoYouDesNeiTwoCell.h"
@interface SWTLaoYouThreeCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)UIView *whiteV;
@property(nonatomic , strong)UIView *titleWhiteV;


@end

@implementation SWTLaoYouThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.whiteV = [[UIView alloc] init];
        self.whiteV.backgroundColor = WhiteColor;
        self.whiteV.layer.cornerRadius = 5;
        self.whiteV.clipsToBounds = YES;
        [self addSubview:self.whiteV];
        
        [self.whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(20);
            make.height.equalTo(@1);
            
        }];
        
        self.titleWhiteV = [[UIView alloc] init];
        [self addSubview:self.titleWhiteV];
        [self.titleWhiteV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@25);
            make.top.equalTo(self).offset(7.5);
        }];
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.whiteV addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.whiteV);
            make.top.equalTo(self.whiteV).offset(20);
            make.bottom.equalTo(self.whiteV).offset(0);
//            make.height.equalTo(@1);
        }];
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouDesNeiOneCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouDesNeiOneCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"SWTLaoYouDesNeiTwoCell" bundle:nil] forCellReuseIdentifier:@"SWTLaoYouDesNeiTwoCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 40;
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    
        
        
        
        
        
    }
    return self;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    
    [self.titleWhiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat ww = 25;
    CGFloat allww = titleStr.length * 25;
    for (int i = 0 ; i < titleStr.length; i++) {
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake((ScreenW - allww) / 2 + i * ww, 0, ww, ww)];
        lb.layer.cornerRadius =  12.5;
        lb.clipsToBounds = YES;
        lb.layer.borderColor = RedColor.CGColor;
        lb.layer.borderWidth = 0.5;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = WhiteColor;
        lb.backgroundColor = RGB(182, 142, 101);
        [self.titleWhiteV addSubview:lb];
        lb.text = [titleStr substringWithRange:NSMakeRange(i, 1)];
        
    }
    
    
    
}


- (void)setHtmlStr:(NSString *)htmlStr {
    _htmlStr = htmlStr;
    
     [self.tableView reloadData];
     [self.tableView layoutIfNeeded];
    //    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.equalTo(@(self.tableView.contentSize.height+10));
    //    }];
        
        NSLog(@"%f",self.tableView.contentSize.height);

        [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.tableView.contentSize.height + 20));
        }];
    
}

- (void)setDataDict:(NSMutableDictionary *)dataDict {
    _dataDict = dataDict;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
       //    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
       //        make.height.equalTo(@(self.tableView.contentSize.height+10));
       //    }];
           
           NSLog(@"%f",self.tableView.contentSize.height);

           [self.whiteV mas_updateConstraints:^(MASConstraintMaker *make) {
               make.height.equalTo(@(self.tableView.contentSize.height + 20));
           }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        
        if (self.htmlStr.length == 0) {
            return 0;
        }
            NSString *htmlStr = [NSString stringWithFormat:@"<div style=\"font-size:14px\">%@</div>",self.htmlStr];
            
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
              [attStr addAttribute:NSFontAttributeName value:para range:NSMakeRange(0, attStr.length)];
              //计算加载完成之后Label的frame
//              CGFloat hh =  [attStr boundingRectWithSize:CGSizeMake(ScreenW - 20 - 30 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size.height;
        
        CGFloat  hh  = [htmlStr getHeigtWithFontSize:14 lineSpace:4 width:ScreenW - 50];
        
        return hh;
        
    }else {
        
        if (indexPath.row == 0) {
            CGFloat hh = [self.dataDict[@"modelsublabel1"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel1"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            return hh;
        }else if (indexPath.row == 1) {
            CGFloat hh = [self.dataDict[@"modelsublabel2"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel2"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            return hh;
        }else {
           CGFloat hh = [self.dataDict[@"modelsublabel3"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] > 23 ?  [self.dataDict[@"modelsublabel3"] getHeigtWithFontSize:12 lineSpace:0 width:ScreenW - 105] + 47:70;
            return hh;
        }
        
        
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.type ==1) {
        return 1;
    }else {
        return 3;
    }

}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 1) {
        SWTLaoYouDesNeiOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouDesNeiOneCell" forIndexPath:indexPath];
//        cell.titleLB.backgroundColor = [UIColor redColor];
        NSString *htmlStr = [NSString stringWithFormat:@"<div style=\"font-size:14px\">%@</div>",self.htmlStr];
            
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
            cell.titleLB.attributedText = attStr;

        return cell;
    }else {
        SWTLaoYouDesNeiTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SWTLaoYouDesNeiTwoCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell.imgV sd_setImageWithURL:self.dataDict[@"modellabelpic1"] placeholderImage:[UIImage imageNamed:@"369"]];
            cell.titleLB.text = self.dataDict[@"modellabel1"];
            cell.contentLB.text = self.dataDict[@"modelsublabel1"];
        }else if (indexPath.row == 1) {
            [cell.imgV sd_setImageWithURL:self.dataDict[@"modellabelpic2"] placeholderImage:[UIImage imageNamed:@"369"]];
            cell.titleLB.text = self.dataDict[@"modellabel2"];
            cell.contentLB.text = self.dataDict[@"modelsublabel2"];
        }else {
           [cell.imgV sd_setImageWithURL:self.dataDict[@"modellabelpic3"] placeholderImage:[UIImage imageNamed:@"369"]];
            cell.titleLB.text = self.dataDict[@"modellabel3"];
            cell.contentLB.text = self.dataDict[@"modelsublabel3"];
        }
        cell.imgV.layer.cornerRadius = 25;
        cell.imgV.clipsToBounds = YES;

        return cell;
    }

}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SWTHeMaidetailCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/23.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "SWTHeMaidetailCell.h"

@implementation SWTHeMaidetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titelLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 20)];
        self.titelLB.font = kFont(14);
        self.titelLB.textColor= CharacterColor50;
        [self addSubview:self.titelLB];
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 165, 15, 150, 20)];
        self.timeLB.font = kFont(13);
        self.timeLB.textAlignment = NSTextAlignmentRight;
        self.timeLB.textColor= CharacterColor102;
        [self addSubview:self.timeLB];
        
        CGFloat ww = (ScreenW - 30 -30)/4;
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 50, ScreenW - 30, ww)];
        [self addSubview:self.scrollView];
        
    }
    return self;
}





@end

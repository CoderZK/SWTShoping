//
//  MJHeMaiPicCell.m
//  SWTShoping
//
//  Created by kunzhang on 2020/9/22.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import "MJHeMaiPicCell.h"
#import "MJPicCollectNeiCell.h"
@interface MJHeMaiPicCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectV;

@end


@implementation MJHeMaiPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((ScreenW - 60)/4, (ScreenW - 60)/4);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        self.collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 100) collectionViewLayout:layout];
        [self addSubview:self.collectV];
        self.collectV.delegate = self;
        self.collectV.dataSource = self;
        [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
            make.bottom.right.equalTo(self).offset(-15);
        }];
  
        self.collectV.backgroundColor = WhiteColor;
        [self.collectV registerNib:[UINib nibWithNibName:@"MJPicCollectNeiCell" bundle:nil] forCellWithReuseIdentifier:@"MJPicCollectNeiCell"];
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MJPicCollectNeiCell * cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"MJPicCollectNeiCell" forIndexPath:indexPath];
    
    return cell;
    
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

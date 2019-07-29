//
//  SQType1Cell.m
//  SQMagnet
//
//  Created by 朱双泉 on 2019/7/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQType1Cell.h"
#import "SQType1SubCell.h"
#import "SQType1Model.h"
#import <YYWebImage.h>

@interface SQType1Cell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SQType1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(SQType1SubCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(SQType1SubCell.class)];
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SQType1SubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SQType1SubCell.class) forIndexPath:indexPath];
    SQType1Model *model = self.datas[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.rateLabel.text = [NSString stringWithFormat:@"%@分", model.rate];
    cell.imageView.yy_imageURL = [NSURL URLWithString:model.img];
    return cell;
}

- (IBAction)viewAllAction:(id)sender {
    if (self.viewAll) {
        self.viewAll();
    }
}

@end

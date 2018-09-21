//
//  SQDiscoveryViewController.m
//  UI
//
//  Created by 朱双泉 on 2018/9/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQDiscoveryViewController.h"

@interface SQDiscoveryViewController ()

@end

@implementation SQDiscoveryViewController

- (instancetype)init {
    UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Discovery";
    self.collectionView.backgroundColor = [UIColor blueColor];
}

@end

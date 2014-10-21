//
//  FullyHorizontalCollectionViewController.m
//  FullyHorizontalCollectionView
//
//  Created by Philippe Auriach on 16/10/2014.
//  Copyright (c) 2014 Philippe Auriach. All rights reserved.
//

#import "FullyHorizontalCollectionViewController.h"
#import "FullyHorizontalFlowLayout.h"

@interface FullyHorizontalCollectionViewController ()

@end

@implementation FullyHorizontalCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *mutableContents = [NSMutableArray new];
    for (int i = 0; i < 47; i++) {
        [mutableContents addObject:[NSString stringWithFormat:@"%d", i]];
    }
    contents = mutableContents;
    
    FullyHorizontalFlowLayout *collectionViewLayout = [FullyHorizontalFlowLayout new];
    
    collectionViewLayout.itemSize = CGSizeMake(195., 200.);
    //collectionViewLayout.nbColumns = 5;
    //collectionViewLayout.nbLines = 3;
    
    [self.collectionView setCollectionViewLayout:collectionViewLayout];
    
    self.collectionView.pagingEnabled = YES;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.collectionView reloadData];
    [self.collectionViewLayout invalidateLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [contents count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UILabel *lbl = (UILabel*)[cell.contentView viewWithTag:101];
    if(lbl == nil){
        lbl = [UILabel new];
        lbl.frame = CGRectMake(0, 0, 183., 200.);
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.tag = 101;
        lbl.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:lbl];
        cell.contentView.backgroundColor = [UIColor grayColor];
    }
    lbl.text = [contents objectAtIndex:indexPath.row];
    
    return cell;
}


@end

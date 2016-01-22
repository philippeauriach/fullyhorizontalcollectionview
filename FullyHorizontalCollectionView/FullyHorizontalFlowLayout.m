//
//  FullyHorizontalFlowLayout.m
//  FullyHorizontalCollectionView
//
//  Created by Philippe Auriach on 16/10/2014.
//  Copyright (c) 2014 Philippe Auriach. All rights reserved.
//

#import "FullyHorizontalFlowLayout.h"

@implementation FullyHorizontalFlowLayout

- (instancetype)init{
    self = [super init];
    if(self){
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.nbColumns = -1;
        self.nbLines = -1;
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger nbColumns = self.nbColumns != -1 ? self.nbColumns : (int)(self.collectionView.frame.size.width / self.itemSize.width);
    NSInteger nbLines = self.nbLines != -1 ? self.nbLines : (int)(self.collectionView.frame.size.height / self.itemSize.height);
    
    NSInteger idxPage = (int)indexPath.row/(nbColumns * nbLines);
    
    NSInteger O = indexPath.row - (idxPage * nbColumns * nbLines);
    
    NSInteger xD = (int)(O / nbColumns);
    NSInteger yD = O % nbColumns;
    
    NSInteger D = xD + yD * nbLines + idxPage * nbColumns * nbLines;
    
    NSIndexPath *fakeIndexPath = [NSIndexPath indexPathForItem:D inSection:indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:fakeIndexPath];

    // return them to collection view
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat newX = MIN(0, rect.origin.x - rect.size.width/2);
    CGFloat newWidth = rect.size.width*2 + (rect.origin.x - newX);
    
    CGRect newRect = CGRectMake(newX, rect.origin.y, newWidth, rect.size.height);
    
    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:newRect] copyItems:YES];
    
    for (UICollectionViewLayoutAttributes *attr in allAttributesInRect) {
        UICollectionViewLayoutAttributes *newAttr = [self layoutAttributesForItemAtIndexPath:attr.indexPath];
        
        attr.frame = newAttr.frame;
        attr.center = newAttr.center;
        attr.bounds = newAttr.bounds;
        attr.hidden = newAttr.hidden;
        attr.size = newAttr.size;
    }
    
    return allAttributesInRect;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (CGSize)collectionViewContentSize{
    CGSize size = [super collectionViewContentSize];
    
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    NSInteger nbOfScreens = (int)ceil((size.width / collectionViewWidth));
    
    CGSize newSize = CGSizeMake((nbOfScreens) * collectionViewWidth, size.height);
    
    return newSize;
}

@end

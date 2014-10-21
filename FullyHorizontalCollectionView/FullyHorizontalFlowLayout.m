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
        self.itemSize = CGSizeMake(195., 200.);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger idxPage = (int)indexPath.row/(_nbColumns * _nbLines);
    
    NSInteger O = indexPath.row - (idxPage * _nbColumns * _nbLines);
    
    NSInteger xD = (int)(O / _nbColumns);
    NSInteger yD = O % _nbColumns;
    
    NSInteger D = xD + yD * _nbLines + idxPage * _nbColumns * _nbLines;
    
    NSIndexPath *fakeIndexPath = [NSIndexPath indexPathForItem:D inSection:indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:fakeIndexPath];

    // return them to collection view
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat newX = MIN(0, rect.origin.x - rect.size.width/2);
    CGFloat newWidth = rect.size.width*2 + (rect.origin.x - newX);
    
    CGRect newRect = CGRectMake(newX, rect.origin.y, newWidth, rect.size.height);
    
    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [super layoutAttributesForElementsInRect:newRect];
    
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
    NSInteger nbOfScreens = (int)(size.width / collectionViewWidth);
    
    CGSize newSize = CGSizeMake((nbOfScreens+1) * collectionViewWidth, size.height);
    
    return newSize;
}

@end

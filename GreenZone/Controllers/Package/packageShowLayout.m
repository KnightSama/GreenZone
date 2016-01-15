//
//  packageShowLayout.m
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#define mainWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height

#define W(x) (mainWidth*x/320)
#define H(y) (mainHeight*y/528)

#import "packageShowLayout.h"

@implementation packageShowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribues = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger row = indexPath.row/4;
    NSInteger col = indexPath.row%4;
    
    CGFloat paddingX = W(10);
    CGFloat paddingY = H(10);
    CGFloat paddingbetween = (mainWidth - 2*W(10))/3;
    
    attribues.frame = CGRectMake(((W(70)+paddingbetween)*col)+paddingX,(H(70)+paddingY)*row, W(70), H(100));
    
    return attribues;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *attr = [NSMutableArray array];
    for (NSInteger i =0; i < self.cellCount; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        [attr addObject:[self layoutAttributesForItemAtIndexPath:path]];
    }
    return attr;
}

@end

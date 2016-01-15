//
//  PakageCollectionViewCell.m
//  GreenZone
//
//  Created by student on 15/7/6.
//  Copyright (c) 2015年 student. All rights reserved.
//

#import "PakageCollectionViewCell.h"

@implementation PakageCollectionViewCell

- (void)setPackageThing:(packageThingsShowModel *)packageThing
{
    _packageThing = packageThing;
    self.thingsIcon.image = [UIImage imageNamed:packageThing.thing.image];
    self.thingsCount.text = [NSString stringWithFormat:@"%d",packageThing.thingsCount];
    self.thingsCount.textColor = [UIColor colorWithWhite:1 alpha:0.8];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        
    }
    return self;
}

@end

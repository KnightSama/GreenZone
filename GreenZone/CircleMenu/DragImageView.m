//
//  DragImageView.m
//  CircleProject
//
//  Created by zbq on 13-10-30.
//  Copyright (c) 2013年 zbq. All rights reserved.
//

#import "DragImageView.h"

@implementation DragImageView

@synthesize current_radian;
@synthesize current_animation_radian;
@synthesize animation_radian;
@synthesize radian;
@synthesize view_point;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        tapGesture.numberOfTouchesRequired = 1;
        tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)click:(UITapGestureRecognizer *)tapGesture{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(DragImageViewClick:)]) {
        CGPoint clickPoint = [tapGesture locationInView:self.superview];
        [self.delegate DragImageViewClick:self];
    }
}



@end

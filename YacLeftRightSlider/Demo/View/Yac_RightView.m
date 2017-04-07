//
//  Yac_RightView.m
//  YacLeftRightSlider
//
//  Created by ChangWingchit on 2017/4/6.
//  Copyright © 2017年 chit. All rights reserved.
//

#import "Yac_RightView.h"

@implementation Yac_RightView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        
        UILabel *showLab = [[UILabel alloc]initWithFrame:CGRectMake(160, 60, 160, 60)];
        showLab.text = @"这是右视图";
        showLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:showLab];
    }
    return self;
}

@end

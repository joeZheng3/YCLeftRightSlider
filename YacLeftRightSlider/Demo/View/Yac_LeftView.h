//
//  Yac_LeftView.h
//  YacLeftRightSlider
//
//  Created by ChangWingchit on 2017/4/6.
//  Copyright © 2017年 chit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Yac_LeftViewDelegate <NSObject>

@optional
- (void)leftViewClickedIndex:(int)index;

@end

@interface Yac_LeftView : UIView

@property (nonatomic,weak) id<Yac_LeftViewDelegate> delegate;

@end

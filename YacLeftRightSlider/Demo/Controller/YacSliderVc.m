//
//  YacSliderVc.m
//  YacLeftRightSlider
//
//  Created by ChangWingchit on 2017/4/7.
//  Copyright © 2017年 chit. All rights reserved.
//

#import "YacSliderVc.h"
#import "Yac_LeftView.h"
#import "Yac_RightView.h"
#import "MyVc.h"
#import "MyVc2.h"
#import "MyVc3.h"

#define MY_LAZY(object,asignment) object = object ?:asignment

//设置最大，最小内容偏移量
#define MaxContentOffsetX 230
#define MinContentOffsetX 60

//滑动方向
typedef enum{
    SliderNone,
    SliderFromLeft,
    SliderFromRight
}SliderDirection;


@interface YacSliderVc ()<Yac_LeftViewDelegate>
{
    CGFloat curContentOffsetX; //当前内容偏移量
    BOOL boundsSlider; //是否从边界开始滑动
    UIPanGestureRecognizer *panGesture; //添加到内容视图contentView上的平移手势
    UITapGestureRecognizer *tapGesture; //添加到内容视图contentView上的单点手势
}

@property (nonatomic,strong) UILabel *showLab;
@property (nonatomic,strong) Yac_LeftView *leftView; //左菜单视图
@property (nonatomic,strong) Yac_RightView *rightView; //右菜单视图
@property (nonatomic,strong) UIView *contentView; //内容视图
@property (nonatomic,strong) UIView *navBakView; //左右菜单导航视图

@end

@implementation YacSliderVc

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self initSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Method
- (void)setNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent = NO;
    self.title = @"首页";
}

- (void)initSubViews
{
    [self showLab];
    
    self.contentView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.contentView.backgroundColor = [UIColor yellowColor];
    self.navBakView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.navBakView];
    [self.view addSubview:self.contentView];
    
    self.leftView = [[Yac_LeftView alloc]initWithFrame:self.navBakView.bounds];
    self.leftView.delegate = self;
    self.rightView = [[Yac_RightView alloc]initWithFrame:self.navBakView.bounds];
    [self.navBakView addSubview:self.leftView];
    [self.navBakView addSubview:self.rightView];
    
    //在内容视图添加手势
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sliderGesgure:)];
    [self.contentView addGestureRecognizer:panGesture];
    
    boundsSlider = YES;//内容视图在边界
    
}

#pragma mark - Lazy Load
- (UILabel*)showLab
{
    return MY_LAZY(_showLab, ({
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2,(self.view.bounds.size.height-50)/2, 100, 50)];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"这是第一页";
        lab.font = [UIFont systemFontOfSize:20];
        lab.textColor = [UIColor orangeColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.numberOfLines = 1;
        lab.lineBreakMode = NSLineBreakByWordWrapping;
        lab;
    }));
}

#pragma mark - UIPanGestureRecognizer
- (void)sliderGesgure:(UIPanGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat transX = [gesture translationInView:self.contentView].x;
        self.contentView.transform = CGAffineTransformMakeTranslation(curContentOffsetX+transX, 0);
        
        if (self.contentView.transform.tx > 0)
            [self.navBakView bringSubviewToFront:self.leftView];
        else
            [self.navBakView bringSubviewToFront:self.rightView];
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        curContentOffsetX = self.contentView.transform.tx; //获取当前偏移量
        
        if (boundsSlider) {
            if (fabs(curContentOffsetX)<=MinContentOffsetX )
            {
                [self setContentViewTransForm:SliderNone];
            }
            else if(curContentOffsetX >MinContentOffsetX)
            {
                [self setContentViewTransForm:SliderFromLeft];
            }
            else
            {
                [self setContentViewTransForm:SliderFromRight];
            }
        }
        else
        {
            if (fabs(curContentOffsetX) <= (MaxContentOffsetX-MinContentOffsetX))
            {
                [self setContentViewTransForm:SliderNone];
            }
            else if (curContentOffsetX > (MaxContentOffsetX-MinContentOffsetX))
            {
                [self setContentViewTransForm:SliderFromLeft];
            }
            else
            {
                [self setContentViewTransForm:SliderFromRight];
            }
        }
    }
}

- (void)setContentViewTransForm:(SliderDirection)direction
{
    self.contentView.userInteractionEnabled = NO;
    self.navBakView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        switch (direction) {
            case SliderNone:
                self.contentView.transform = CGAffineTransformMakeTranslation(0, 0);
                break;
            case SliderFromLeft:
                self.contentView.transform = CGAffineTransformMakeTranslation(MaxContentOffsetX, 0);
                break;
            case SliderFromRight:
                self.contentView.transform = CGAffineTransformMakeTranslation(-MaxContentOffsetX, 0);
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        self.contentView.userInteractionEnabled = YES;
        self.navBakView.userInteractionEnabled = YES;
        
        curContentOffsetX = self.contentView.transform.tx;//获取当前偏移量
        
        if(tapGesture) [self.contentView removeGestureRecognizer:tapGesture];
        if (direction == SliderNone)
        {
            boundsSlider = YES; //视图在内容边界
        }
        else
        {
            tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesgure:)];
            [self.contentView addGestureRecognizer:tapGesture];
            boundsSlider = NO;//内容视图不在边界
        }
    }];
}

#pragma mark - UITapGestureRecognizer
- (void)tapGesgure:(UITapGestureRecognizer*)gesture
{
    [self setContentViewTransForm:SliderNone];
}

#pragma mark - Yac_LeftViewDelegate
- (void)leftViewClickedIndex:(int)index
{
    if (index == 0) {
        MyVc *vc = [[MyVc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 1) {
        MyVc2 *vc = [[MyVc2 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (index == 2) {
        MyVc3 *vc = [[MyVc3 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self setContentViewTransForm:SliderNone];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

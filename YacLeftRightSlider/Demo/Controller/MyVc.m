//
//  MyVc.m
//  YacLeftRightSlider
//
//  Created by ChangWingchit on 2017/4/6.
//  Copyright © 2017年 chit. All rights reserved.
//

#import "MyVc.h"

@interface MyVc ()

@end

@implementation MyVc

- (id)init
{
    if (self = [super init]) {
        self.title = @"子控制器1";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

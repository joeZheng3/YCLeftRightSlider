//
//  Yac_LeftView.m
//  YacLeftRightSlider
//
//  Created by ChangWingchit on 2017/4/6.
//  Copyright © 2017年 chit. All rights reserved.
//

#import "Yac_LeftView.h"

@interface Yac_LeftView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *aryData;

@end

@implementation Yac_LeftView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.aryData = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UIView *view = [[UIView alloc]init];
        self.tableView.tableFooterView = view;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - UItableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.aryData && [self.aryData count]) {
        return [self.aryData count];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    if (self.aryData && indexPath.row < [self.aryData count]) {
        cell.textLabel.text = [self.aryData objectAtIndex:indexPath.row];
        
    }
    return cell;
}

#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.aryData count]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(leftViewClickedIndex:)]) {
            [self.delegate leftViewClickedIndex:(int)indexPath.row];
        }
    }
}



@end

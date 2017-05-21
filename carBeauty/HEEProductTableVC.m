//
//  HEEProductTableVC.m
//  carBeauty
//
//  Created by apple7 on 17/4/9.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HEEProductTableVC.h"
#import <UIView+SDAutoLayout.h>
#import "HEEProductTableViewCell.h"
#import "ProductDetailViewController.h"

static CGFloat const OffsetY = 190;
static NSString *const oneCell = @"HEEOneCell";

@interface HEEProductTableVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HEEProductTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self setupConfigures];
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.contentSize = CGSizeMake(self.view.width, 0);
//    self.tableView = tableView;
}

- (void)setupConfigures{
    // 修改tableView的样式
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oneCell];
    self.tableView = tableView;
    self.tableView.contentInset = UIEdgeInsetsMake(OffsetY - 25, 0, -35, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HEEProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
    
    if (!cell) {
        cell = [[HEEProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCell];
    }
    
    cell.proIMG.image = [UIImage imageNamed:@"timg"];
    cell.proName.text = @"玻璃水常年配送";
    cell.proNum.text = @"五件 测试label长度 测试label长度 测试label长度 测试label长度 测试label长度 测试label长度";
    cell.proRMB.text = @"¥ 100";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = ([UIScreen mainScreen].bounds.size.width - 0) / 3 + 8;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    ProductDetailViewController *productDetailVC = [[ProductDetailViewController alloc] init];
    [self.navigationController pushViewController:productDetailVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark- scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(HEEProductTableVCDidScroll:)]) {
        [self.delegate HEEProductTableVCDidScroll:scrollView.contentOffset.y];
    }
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

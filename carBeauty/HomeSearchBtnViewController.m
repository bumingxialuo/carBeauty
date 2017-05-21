//
//  HomeSearchBtnViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/10.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "HomeSearchBtnViewController.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>

@interface HomeSearchBtnViewController ()
@property(nonatomic, strong) UISearchBar *seachBar;
@end

@implementation HomeSearchBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutSeachSubview];
}

- (void)layoutSeachSubview {
    self.view.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    self.navigationItem.title = @"搜索";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"0081f1"];
    
    UISearchBar *seachBar = [[UISearchBar alloc] init];
    self.seachBar = seachBar;
    seachBar.frame = CGRectMake(0, 0, self.view.width, 44);
    seachBar.placeholder = @"点击搜索保养知识";
    seachBar.showsSearchResultsButton = YES;
    
    [self.view addSubview:seachBar];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    imgV.image = [UIImage imageNamed: @"search_null"];
    [self.view addSubview:imgV];
    
    imgV.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(100)
    .heightIs(100);
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

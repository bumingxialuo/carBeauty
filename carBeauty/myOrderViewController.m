//
//  myOrderViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "myOrderViewController.h"
#import <Chameleon.h>

@interface myOrderViewController ()

@end

@implementation myOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    self.navigationItem.title = @"我的订单";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"0081f1"];
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

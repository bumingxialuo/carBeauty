//
//  CJEHomePage.m
//  carB
//
//  Created by iPhone8s on 17/4/14.
//  Copyright © 2017年 iPhone8s. All rights reserved.
//

#import "CJEHomePage.h"
#import <UIView+SDAutoLayout.h>
#import <UITableView+SDAutoTableViewCellHeight.h>
#import <SDCycleScrollView.h>
#import "CJETableViewCell.h"
#import <Chameleon.h>
//#import "SDCycleScrollView.h"
#import "HomeSearchBtnViewController.h"


@interface CJEHomePage ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *modelsArray;
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation CJEHomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 封装函数 提高viewDidLoad可读性
    [self setupHeaderView];
    
    [self creatModelsWithCount:10];
   ///<>
//    self.navigationController.navigationBar.translucent = NO;
}
- (IBAction)homePageSearchBtnClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    HomeSearchBtnViewController *searchVC = [[HomeSearchBtnViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)setupHeaderView {
    
    CGFloat tableH = [UIScreen mainScreen].bounds.size.height - 180;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *header = [[UIView alloc]init];
    
    // 由于tableviewHeaderView的特殊性， 在使他高度自适应之前你最好先给它设置一个宽度
    header.width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *picImageNamesArray = @[ @"car_1.jpg",@"car_2.jpg", @"car3.jpg",@"car4.jpg",@"car5.jpg",];
    
    SDCycleScrollView *scrollView = [[SDCycleScrollView alloc]init];
    scrollView.localizationImageNamesGroup = picImageNamesArray;
    scrollView.currentPageDotColor = [UIColor colorWithHexString:@"0081f1"];
    scrollView.pageDotColor = [UIColor whiteColor];
    
    ///<
    UITableView *tableV = [[UITableView alloc] init];
    self.tableView = tableV;
    tableV.delegate = self;
    tableV.dataSource = self;
    
    [self.view sd_addSubviews:@[tableV,header]];
    [header addSubview:scrollView];
    
    header.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(180);
    
    scrollView.sd_layout
    .leftSpaceToView(header,0)
    .topSpaceToView(header,0)
    .rightSpaceToView(header,0)
    .heightIs(180);
    
    tableV.sd_layout
    .topSpaceToView(header, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .heightIs(tableH);
///>
                                   
}


- (void)creatModelsWithCount:(NSInteger)count {
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"car_1.jpg",@"car_2.jpg",@"car3.jpg",@"car4.jpg",@"car5.jpg"];
    
    NSArray *namesArray = @[@"汽车美容之冬季雪天洗...",@"汽车美容，镀晶你懂吗...",@"不走寻常路 20万元...",@"停车被堵找不到车主怎...",@"汽车之家..."];
    
    NSArray *textArray = @[@"误区一：雪后洗车用热水有的车主在雪后自己洗车...",
                           @"在这个个性张扬、激情四射的年代，一个年轻人，...",
                           @"什么叫优贝无机汽车镀晶？汽车优贝无机镀晶是指...",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *picImageNamesArray = @[@"one.jpg",@"two.jpg",@"three.jpg",@"car4.jpg",@"car5.jpg"];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        int picRandomIndex = arc4random_uniform(5);
        
        CJEModel *model = [CJEModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandIndex];
        model.content = textArray[contentRandomIndex];
        
        // 模拟“有或者无图片”
        int random = arc4random_uniform(100);
        if (random <= 80) {
            model.picName = picImageNamesArray[picRandomIndex];
            
        }
        
        [self.modelsArray addObject:model];
        
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
// 数据源，显示单元格中的数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"test";
    CJETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[CJETableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.model = self.modelsArray[indexPath.row];
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    return cell;
}


/*  点击执行单元格删除的指令
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
   [self.modelsArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model" cellClass:[CJETableViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    
    return width;
}

@end

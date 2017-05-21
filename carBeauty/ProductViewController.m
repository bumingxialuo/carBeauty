//
//  ProductViewController.m
//  carBeauty
//
//  Created by apple7 on 17/4/7.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "ProductViewController.h"
#import "HEEProductTableVC.h"
#import "titleViewsScroll.h"
#import <UIView+SDAutoLayout.h>
#import <Chameleon.h>
#import "ProductSeachBtnViewController.h"
#import "HEEPositioningViewController.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface ProductViewController ()<UIScrollViewDelegate, HEEProductTableVCDelegate>

@property (strong, nonatomic) UIScrollView *titleView;                      //标题栏
@property (strong, nonatomic) titleViewsScroll *tableContain;               //内容的view
@property (strong, nonatomic) UIButton *currentSelectedBtn;                 //选中的按钮
@property (strong, nonatomic) UIView *selectedUnderLine ;                    //按钮选中时的下划线
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) HEEProductTableVC *productVC1;
@property (nonatomic, strong) HEEProductTableVC *productVC2;
@property (nonatomic, strong) HEEProductTableVC *productVC3;

@end

@implementation ProductViewController

//懒加载属性
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"供应", @"需求", @"发布"];
    }
    return  _titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutSubViews];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupChildViewController];//添加子控制器
    
    [self setUpTitleView];//添加标题栏内容
    
    [self addChildViewInContentView:0];
    
    [self setupUnderLine];//添加标题栏下划线
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    
    NSString *cityString = [KCURRENTCITYINFODEFAULTS objectForKey:@"resultTEXT"];
    NSLog(@"导航栏 %@",cityString);
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftButton addTarget:self action:@selector(pushToPositionViewC) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:cityString forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor colorWithHexString:@"0081f1"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)pushToPositionViewC {
    HEEPositioningViewController *positionVC = [[HEEPositioningViewController alloc] init];
    [self.navigationController pushViewController:positionVC animated:YES];
}

- (IBAction)productSeachBtnClick:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    NSLog(@"点击了 产品 页面左上角的 搜索 页面");
    ProductSeachBtnViewController *ProductSeachVC = [[ProductSeachBtnViewController alloc] init];
    [self.navigationController pushViewController:ProductSeachVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)settingNavContr {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                                                                      NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:1]}];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithHexString:@"0081F1"]];
    
}

- (void)layoutSubViews {
    
    [self.view layoutSubviews];
    
//    [self settingNavContr];
    
    //标题栏
    UIScrollView *titleView = [[UIScrollView alloc] init];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    //内容的view
    titleViewsScroll *tableContain = [[titleViewsScroll alloc] init];
    self.tableContain = tableContain;
    tableContain.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    tableContain.pagingEnabled = YES;
    tableContain.bounces = self;
    tableContain.delegate = self;
    tableContain.contentSize = CGSizeMake(self.titleArray.count * self.view.width, 0);
    
    [self.view sd_addSubviews:@[titleView,tableContain]];
    
    titleView.sd_layout
    .topSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .heightIs(40);
    
    tableContain.sd_layout
    .topSpaceToView(titleView, 0)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(self.view.height);
}

- (void)setupChildViewController {
    HEEProductTableVC *productVC1 = [[HEEProductTableVC alloc] init];
    self.productVC1 = productVC1;
    productVC1.delegate = self;
    [self addChildViewController:productVC1];
    
    HEEProductTableVC *productVC2 = [[HEEProductTableVC alloc] init];
    self.productVC2 = productVC2;
    productVC2.delegate = self;
    [self addChildViewController:productVC2];
    
    HEEProductTableVC *productVC3 = [[HEEProductTableVC alloc] init];
    self.productVC3 = productVC3;
    productVC3.delegate = self;
    [self addChildViewController:productVC3];
}

- (void)setUpTitleView {
    NSInteger count = self.titleArray.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize: 15];
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [btn setTitle:_titleArray[i] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0081F1"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnW = self.view.width / _titleArray.count;
        CGFloat btnH = 40;
        CGFloat btnX = i * btnW;
        btn.tag = i;
        //        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [self.titleView addSubview:btn];
        
        btn.sd_layout
        .topSpaceToView(_titleView, 0)
        .leftSpaceToView(_titleView, btnX)
        .widthIs(btnW)
        .heightIs(btnH);
        
        
        if (0 == i) {
            [self titleBtnClick:btn];
        }
    }
    
}

//添加相应的控制器的view到内容视图中
- (void) addChildViewInContentView:(NSInteger)index {
    UIViewController *childView = self.childViewControllers[index];
    [self.tableContain addSubview:childView.view];
    childView.view.frame = CGRectMake(index * self.view.width, -200, self.view.width, self.view.height + 200);
    
    //跳转时滚动到当前view的offsetY的位置
    //    [self HEEScrollToChangeHeaderViewHeight:teachingMaterialVC.tableView.contentOffset.y];
}


- (void)setupUnderLine {
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton = self.titleView.subviews.firstObject;
    UIView *underline = [[UIView alloc] init];
    CGFloat underlineH = 1;
    CGFloat underlineW =  self.view.width / [self titleArray].count;
    CGFloat underlineX = 0;
    CGFloat underlineY = 40 - 3;
    underline.frame = CGRectMake(underlineX, underlineY, underlineW, underlineH);
    //设置下划线的颜色,根随按钮选中的颜色一致
    underline.backgroundColor = [selectButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underline];
    self.selectedUnderLine = underline;
    
    [selectButton.titleLabel sizeToFit];
    selectButton.selected = YES;
    self.currentSelectedBtn = selectButton;
    
    self.selectedUnderLine.width = selectButton.titleLabel.width + 10;
    self.selectedUnderLine.centerX = selectButton.centerX;
    
}

- (void)titleBtnClick :(UIButton *)button {
    self.currentSelectedBtn.selected = NO;
    button.selected = YES;
    self.currentSelectedBtn = button;
    
    NSInteger index = button.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedUnderLine.width = button.titleLabel.width + 10;
        self.selectedUnderLine.centerX = button.centerX;
    } completion:nil];
    self.tableContain.contentOffset = CGPointMake(index * self.view.width, 0);
    [self addChildViewInContentView:index];
    
    _productVC1.tableView.scrollEnabled = YES;
    _productVC2.tableView.scrollEnabled = YES;
    _productVC3.tableView.scrollEnabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableContain) {
        _productVC1.tableView.scrollEnabled = NO;
        _productVC2.tableView.scrollEnabled = NO;
        _productVC3.tableView.scrollEnabled = NO;
    }
}

//滚动切换控制器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.tableContain) {
        _productVC1.tableView.scrollEnabled = YES;
        _productVC2.tableView.scrollEnabled = YES;
        _productVC3.tableView.scrollEnabled = YES;
    }
    
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    NSMutableArray *buttonArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titleView.subviews.count; i++) {
        UIView *button = self.titleView.subviews[i];
        if (button.class == [UIButton buttonWithType:UIButtonTypeCustom].class) {
            [buttonArray addObject:button];
        }
    }
    
    UIButton *button = buttonArray[index];
    NSLog(@"%ld",(long)button.tag);
    [self titleBtnClick:button];
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

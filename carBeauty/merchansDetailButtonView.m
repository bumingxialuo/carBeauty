//
//  merchansDetailButtonView.m
//  carBeauty
//
//  Created by apple7 on 17/4/18.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "merchansDetailButtonView.h"
#import <Chameleon.h>
#import <UIView+SDAutoLayout.h>

@implementation merchansDetailButtonView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutMerchansButtonSubview];
    }
    return self;
}

- (void)layoutMerchansButtonSubview {
    
    CGFloat halfScreenW = [UIScreen mainScreen].bounds.size.width / 2;
    
    UIButton *lookAppointment = [[UIButton alloc] init];
    lookAppointment.backgroundColor = [UIColor colorWithHexString:@"0081f1"];
    [lookAppointment setTitle:@"查看商家预约" forState:UIControlStateNormal];
    [lookAppointment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookAppointment addTarget:self action:@selector(showLookAppointmentView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *immediatelyAppiontment = [[UIButton alloc] init];
    immediatelyAppiontment.backgroundColor = [UIColor colorWithHexString:@"ff7c38"];
    [immediatelyAppiontment setTitle:@"立即预约" forState:UIControlStateNormal];
    [immediatelyAppiontment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [immediatelyAppiontment addTarget:self action:@selector(showImmediatelyAppiontmentView) forControlEvents:UIControlEventTouchUpInside];
    
    [self sd_addSubviews:@[lookAppointment,immediatelyAppiontment]];
    
    lookAppointment.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .widthIs(halfScreenW)
    .heightIs(48);
    
    immediatelyAppiontment.sd_layout
    .topSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .widthIs(halfScreenW)
    .heightIs(48);
}

- (void)showLookAppointmentView {
    //show 商家预约时间查看 视图
    if (self.showLookAppointmentViewBotttomViewBlock) {
        self.showLookAppointmentViewBotttomViewBlock();
    }
}

- (void)showImmediatelyAppiontmentView {
    //show 立即预约 视图          --适合着急用户
    if (self.showImmediatelyAppiontmentViewBotttomViewBlock) {
        self.showImmediatelyAppiontmentViewBotttomViewBlock();
    }
}
@end

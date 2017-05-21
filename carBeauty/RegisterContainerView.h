//
//  RegisterContainerView.h
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterContainerView;

@protocol RegisterContainerViewDelegate <NSObject>

//点击注册按钮
- (void)registerContainerViewDidClickSure: (RegisterContainerView *)container;

//点击了返回
- (void)registerContainerViewDidClickBack: (RegisterContainerView *)container;

@end

@interface RegisterContainerView : UIView

@property (nonatomic, weak) id<RegisterContainerViewDelegate> delegate;

@end


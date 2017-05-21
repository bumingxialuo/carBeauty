//
//  ForgotpwdContainerView.h
//  microblog
//
//  Created by apple7 on 17/3/6.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "ContainerView.h"
#import "NSString+RegexCategory.h"
//#import <AVOSCloud.h>
#import <Chameleon.h>
#import "UIView+SDAutoLayout.h"

@class ForgotpwdContainerView;

@protocol  ForgotpwdContainerViewDelegate <NSObject>

- (void)forgotpwdContainerViewDidClickSure: (ForgotpwdContainerView *)container;

- (void)forgotpwdContainerViewDidClickBack: (ForgotpwdContainerView *)container;

@end

@interface ForgotpwdContainerView : ContainerView

@property (nonatomic, weak) id<ForgotpwdContainerViewDelegate> delegate;

@end

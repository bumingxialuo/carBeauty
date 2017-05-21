//
//  ContainerView.m
//  carBeauty
//
//  Created by apple7 on 17/4/20.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import "ContainerView.h"
#import "UIView+SDAutoLayout.h"

@interface ContainerView()

@end

@implementation ContainerView

- (void) setSubView {
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    self.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.35];
}
@end

//
//  HEEProductTableVC.h
//  carBeauty
//
//  Created by apple7 on 17/4/9.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HEEProductTableVCDelegate<NSObject>
@optional
- (void)HEEProductTableVCDidScroll:(CGFloat)scrollY;
@end

@interface HEEProductTableVC: UITableViewController
/**代理*/
@property(nonatomic,weak)id<HEEProductTableVCDelegate> delegate;
@end

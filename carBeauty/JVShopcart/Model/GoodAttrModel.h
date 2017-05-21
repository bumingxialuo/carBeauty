//
//  GoodAttrModel.h
//  carBeauty
//
//  Created by apple7 on 17/4/16.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodAttrModel : NSObject
/** 属性名 */
@property (nonatomic, copy) NSString *attr_name;
/** 属性ID */
@property (nonatomic, copy) NSString *attr_id;
/** 属性 */
@property (nonatomic, copy) NSArray *attr_value;
@end


@interface GoodAttrValueModel : NSObject

/** 属性值 */
@property (nonatomic, copy) NSString *attr_value;
@end

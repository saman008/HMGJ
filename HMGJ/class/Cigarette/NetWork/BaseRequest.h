//
//  BaseRequest.h
//  YLProject
//
//  Created by qzp on 2017/3/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

///获取员工信息
+(void) getEmployeeOne:(void (^) (NSInteger code)) result;
+(void) getEmployeeOneForFirst:(void (^) (NSInteger code)) result;

//--------------------



@end

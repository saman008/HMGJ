//
//  NSDateTool.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDateTool : NSObject
NSString * yesterdayDate(NSString * formatter);
NSString * todayDate(NSString * formatter);
///今天之前的某天
NSString * preDate(NSString * formatter, NSInteger count);
NSString * lastDate(NSString * fomatter, NSInteger count);
NSString * changeDate(NSString * formatter, NSString * dateStr, NSString * oldFormatter);

//根据当前时间生成唯一标示符
NSString* getIdentifierByTime();




@end

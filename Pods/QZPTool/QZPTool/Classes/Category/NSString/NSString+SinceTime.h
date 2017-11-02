//
//  NSString+SinceTime.h
//  PaoTui
//
//  Created by qzp on 15/12/31.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SinceTime)
///获取当前时间的差值 返回格式 包含秒
- (NSString *) intervalSinceNow;
///获取当前时间的差值
- (NSString *) intervalSinecNowOnlyDay;
@end

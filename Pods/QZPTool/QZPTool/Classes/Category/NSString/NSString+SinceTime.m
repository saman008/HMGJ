//
//  NSString+SinceTime.m
//  PaoTui
//
//  Created by qzp on 15/12/31.
//  Copyright © 2015年 qzp. All rights reserved.
//

#import "NSString+SinceTime.h"

@implementation NSString (SinceTime)
- (NSString *)intervalSinceNow {
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    date.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    
    NSString * finishTime = [NSString stringWithFormat:@"%@ +0800",self];
    NSDate *d=[date dateFromString: finishTime];
    
    if (d==nil) {
        date.dateFormat = @"yyyy-MM-dd HH:mm:ss.s Z";
        d = [date dateFromString: finishTime];
    }
    

    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate date];

    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    
    NSTimeInterval  cha = now - late;

    
    //秒
    NSInteger m = cha;
    //分钟
    NSInteger f = cha/60;
    //小时
    NSInteger s = cha/3600;
    //天
    NSInteger t = cha/3600/24;

    
    if (m < 60) {
        if (m<1) {
            m=1;
        }
        
        return  [NSString stringWithFormat:@"%d秒前",m];
    }
    if (f<60) {
        return  [NSString stringWithFormat:@"%d分钟前",f];
    }
    if (s<24) {
        return  [NSString stringWithFormat:@"%d小时前",s];
    }
    if (t < 365) {
        return  [NSString stringWithFormat:@"%d天前",t];
    }
    
    return  @" ";
}
@end

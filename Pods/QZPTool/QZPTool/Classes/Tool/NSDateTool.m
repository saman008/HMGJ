//
//  NSDateTool.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "NSDateTool.h"

@implementation NSDateTool
NSString * yesterdayDate(NSString * formatter) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat: formatter];
    
    NSDate * yesterday = [[NSDate date] dateByAddingTimeInterval: - (60* 60 *24)];
    return [dateFormatter stringFromDate: yesterday];
    
}
NSString * todayDate(NSString * formatter) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate * today = [NSDate date];
    [dateFormatter setDateFormat: formatter];
    return [dateFormatter stringFromDate: today];
}
NSString * preDate(NSString * formatter, NSInteger count) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat: formatter];
    
    NSDate * yesterday = [[NSDate date] dateByAddingTimeInterval: - (60* 60 *24 * count)];
    return [dateFormatter stringFromDate: yesterday];
}
NSString * lastDate(NSString * fomatter, NSInteger count){
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat: fomatter];
    
    NSDate * yesterday = [[NSDate date] dateByAddingTimeInterval:  (60* 60 *24 * count)];
    return [dateFormatter stringFromDate: yesterday];
}
NSString * changeDate(NSString * formatter, NSString * dateStr, NSString * oldFormatter) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat: oldFormatter];
    NSDate * tDate = [dateFormatter dateFromString: dateStr];
    
    NSDateFormatter * df2 = [[NSDateFormatter alloc] init];
    [df2 setLocale:[NSLocale currentLocale]];
    [df2 setDateFormat: formatter];
    return  [df2 stringFromDate: tDate];
    
}

NSString* getIdentifierByTime(){
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *cur=[formatter stringFromDate:date];
    return cur;
}







@end

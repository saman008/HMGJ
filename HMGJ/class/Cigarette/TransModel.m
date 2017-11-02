//
//  TransModel.m
//  YLProject
//
//  Created by qzp on 2017/2/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "TransModel.h"

@implementation TransModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if([dic[@"tranType"] isEqualToString: @"QS"]) {
        _tranType = @"清算";
    }
    else if([dic[@"tranType"] isEqualToString: @"CZ"]) {
        _tranType = @"充值";
    }
    else if([dic[@"tranType"] isEqualToString: @"TX"]) {
        _tranType = @"提现";
    }
    else if([dic[@"tranType"] isEqualToString: @"SY"]) {
        _tranType = @"收益";
    }
    else if([dic[@"tranType"] isEqualToString: @"ALL"]) {
        _tranType = @"全部";
    }
    else {
        _tranType = @"未知";
    }
    
    
    return YES;
}
@end

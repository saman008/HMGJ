//
//  PersonModel.m
//  YLProject
//
//  Created by qzp on 2017/2/22.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString * ares = dic[@"area"];
    if ([ares isKindOfClass:[NSNull class]]) {
        _area = @"未设置";
    }
    if([dic[@"address"] isKindOfClass:[NSNull class]]) {
        _address = @"未设置";
    }
//    if ([dic[@"gender"] integerValue] == 1) {
//        _gender = @"男";
//    }
//    if ([dic[@"gender"] integerValue] == 0) {
//        _gender = @"女";
//    }
    
    return YES;
}



@end

@implementation RuleList



@end

@implementation ServiceList



@end

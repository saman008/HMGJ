//
//  BalanceModel.h
//  YLProject
//
//  Created by qzp on 2017/2/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BalanceModel : NSObject
@property (nonatomic, assign) NSInteger code;
///可用余额
@property (nonatomic, copy) NSString * avaiBal;
///余额
@property (nonatomic, copy) NSString * workingBal;
///基金份额
@property (nonatomic, copy) NSString * fundShare;
///可用基金份额
@property (nonatomic, copy) NSString * avaiFundShare;
///昨日收益
@property (nonatomic, copy) NSString * earningsYesterday;
@end

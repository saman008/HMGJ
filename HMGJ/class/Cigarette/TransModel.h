//
//  TransModel.h
//  YLProject
//
//  Created by qzp on 2017/2/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransModel : NSObject
///手续费
@property (nonatomic, strong) NSString * charge;
///实际金额
@property (nonatomic, strong) NSString * settleAmt;
///交易总金额
@property (nonatomic, strong) NSString * totleAmt;
///交易类型 CZ：充值；TX提现；SY：收益；QS：清算；ALL：全部
@property (nonatomic, strong) NSString * tranType;
@property (nonatomic, strong) NSString * transDate;
@end

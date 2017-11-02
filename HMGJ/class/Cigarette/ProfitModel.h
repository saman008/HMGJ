//
//  ProfitModel.h
//  YLProject
//
//  Created by qzp on 2017/2/27.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfitModel : NSObject

@property (nonatomic, copy) NSString * settleDate;
///产品类型
@property (nonatomic, copy) NSString * productType;
///产品代码
@property (nonatomic, copy) NSString * productCode;
///币种 交易类型（TX:提现；CZ:充值;QF:清分；SY:收益）
@property (nonatomic, copy) NSString * currency;
@property (nonatomic, copy) NSString * productName;
///产品收益到账期限
@property (nonatomic, copy) NSString * settlePeriod;
///起售金额
@property (nonatomic, copy) NSString * minimumAmt;
///基金公司名称
@property (nonatomic, copy) NSString * fundName;
///七日年化收益率
@property (nonatomic, copy) NSString * sevenDayEarns;
///dayEarnsPerWan
@property (nonatomic, copy) NSString * dayEarnsPerWan;
//isWorkDay 0：非工作日 1：工作日
@property (nonatomic, copy) NSString * isWorkDay;


@end

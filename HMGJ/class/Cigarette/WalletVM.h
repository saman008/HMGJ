//
//  WalletVM.h
//  YLProject
//
//  Created by qzp on 2017/2/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BalanceModel.h"
#import "TransModel.h"
#import "ProfitModel.h"
#import "CardInfoModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface WalletVM : NSObject

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSString * transType;

@property (nonatomic, assign) NSInteger sevenCurrentPage;
@property (nonatomic, copy) NSString * startDate;
@property (nonatomic, copy) NSString * endDate;

///充值，转出金额
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, copy) NSString * passWord;
///获取余额
@property (nonatomic, strong) RACCommand * getBalanceCommand;
@property (nonatomic, strong) RACCommand * getTransCommand;

///历史收益率明细
@property (nonatomic, strong) RACCommand * getProfitRatioCommand;
///钱包收益
@property (nonatomic, strong) RACCommand * getTransMonthCommand;
///充值
@property (nonatomic, strong) RACCommand * rechargeCommand;
///提现
@property (nonatomic, strong) RACCommand * cashoutCommand;
///获取银行卡
@property (nonatomic, strong) RACCommand * getCardCommand;





@end

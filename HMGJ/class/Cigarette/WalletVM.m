//
//  WalletVM.m
//  YLProject
//
//  Created by qzp on 2017/2/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "WalletVM.h"
#import "HttpRequest.h"
#import <YYWebImage/YYWebImage.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "SMProgressHUD.h"
#import "NSObject+HUD.h"
#define Count 1
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];
@implementation WalletVM

- (RACCommand *)getBalanceCommand {
    if (!_getBalanceCommand) {
        _getBalanceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [HttpRequest ebankBalance:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    BalanceModel * model = [BalanceModel yy_modelWithJSON: anyobject];                    
                    [subscriber sendNext: model];
                    [subscriber sendCompleted];
                    
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _getBalanceCommand;
}

- (RACCommand *)getTransCommand  {
    if (!_getTransCommand) {
        @weakify(self);
        _getTransCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
//                [MBProgressHUD showBusy];
                [HttpRequest ebankTransWithCurrentPage: self.currentPage showCount: Count startDate: @"" endDate: @"" transType: self.transType result:^(NSInteger statusCode, NSString *msg, id anyobject) {
//                    [MBProgressHUD hideProgress];
                    if(statusCode == HttpResponseCodeSuccess) {
                        if ([anyobject count] != 0) {
                            TransModel * model = [TransModel yy_modelWithJSON: anyobject[0]];
                            [subscriber sendNext: model];
                            [subscriber sendCompleted];
                        }
                    }
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _getTransCommand;
}



- (RACCommand *)getProfitRatioCommand {
    if (!_getProfitRatioCommand) {
        @weakify(self);
        _getProfitRatioCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSignal * singal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [HttpRequest ebankProfitRatioWithCurrentPage: self.sevenCurrentPage showCount:Count startDate: self.startDate endDate: self.endDate result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    if (statusCode == HttpResponseCodeSuccess) {
                        if([anyobject count] != 0) {
                            ProfitModel *model = [ProfitModel yy_modelWithJSON: anyobject[0]];
                            [subscriber sendNext: model];
                            [subscriber sendCompleted];
                        }

                    }
                   
                }];
                return  nil;
            }];
            return  singal;
        }];
    }
    return _getProfitRatioCommand;
}


- (RACCommand *)getTransMonthCommand {
    if (!_getTransMonthCommand) {
        _getTransMonthCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self);
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [MBProgressHUD showBusy];
                [HttpRequest ebankTransWithCurrentPage: self.currentPage showCount: 30 startDate: self.startDate endDate: self.endDate transType: self.transType result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    [MBProgressHUD hideProgress];
                    NSMutableArray * mur = [NSMutableArray array];
                    if (statusCode == HttpResponseCodeSuccess) {
                        for (NSDictionary * dic in anyobject) {
                            TransModel * model = [TransModel yy_modelWithJSON: dic];
                            [mur addObject: model];
                        }
                    }
                
                    [subscriber sendNext: mur];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
            return signal;
            
        }];
    }
    return _getTransMonthCommand;
}

- (RACCommand *)rechargeCommand {
    if (!_rechargeCommand) {
        _rechargeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self);
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [HttpRequest ebankRechrgeWithAmout: self.amount password: self.passWord result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    [subscriber sendNext: @[[NSNumber numberWithInteger: statusCode], msg, anyobject]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _rechargeCommand;
}

- (RACCommand *)cashoutCommand {
    if (!_cashoutCommand) {
        _cashoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @weakify(self);
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                @strongify(self);
                [HttpRequest ebankCashoutWithAmount: self.amount password: self.passWord result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    [subscriber sendNext: @[[NSNumber numberWithInteger: statusCode], msg, anyobject]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _cashoutCommand;
}

- (RACCommand *)getCardCommand {
    if (!_getCardCommand) {
        _getCardCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [HttpRequest ebankGetCardWithCustCode: nil result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    
                    if (statusCode == HttpResponseCodeSuccess) {
                        CardInfoModel * model = [CardInfoModel yy_modelWithJSON: anyobject[0]];
                        [subscriber sendNext: model];
                        [subscriber sendCompleted];
                    }
 
                }];
                return nil;
            }];
            return signal;
        }];
    }
    return _getCardCommand;
}

@end

//
//  InMoneyPasswordVC.h
//  YLProject
//
//  Created by qzp on 2017/3/5.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypedefMacro.h"


@interface HandleMoneyPasswordVC : UIViewController
@property (nonatomic, assign) HandleMoneyType type;
///单位分
@property (nonatomic, assign) float amount;

///订单流水
@property (nonatomic, assign) NSString * bill_acct_id;
@end

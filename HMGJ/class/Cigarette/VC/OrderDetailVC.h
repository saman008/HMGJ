//
//  OrderDetailVC.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OdrerListModel.h"

@interface OrderDetailVC : UIViewController
@property (nonatomic,assign) BOOL isCurrentOrder; ///是否为当期订单
@property (nonatomic, strong) NSString * orderNo; //订单号
@property (nonatomic, strong) OdrerListModel * model;
@end

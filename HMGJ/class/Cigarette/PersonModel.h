//
//  PersonModel.h
//  YLProject
//
//  Created by qzp on 2017/2/22.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RuleList;
@class ServiceList;
@interface PersonModel : NSObject
///详细地址
@property (nonatomic, copy) NSString * address;
///地区
@property (nonatomic, copy) NSString * area;
///
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * email;
///
@property (nonatomic, copy) NSString * fixedQR;
//男1 女0
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * headImgUrl;
///会员id
@property (nonatomic, copy) NSString * memberId;
@property (nonatomic, copy) NSString * realName;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, strong) NSArray<RuleList *> * ruleList;
@property (nonatomic, strong) NSArray * serviceList;
@property (nonatomic, copy) NSString * sysAct;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * cell;
@property (nonatomic, copy) NSString * idcard;

@property (nonatomic, copy) NSString * behindUrl;
@property (nonatomic, copy) NSString * frontUrl;


@end

@interface RuleList : NSObject
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) NSString * ruleId;
@property (nonatomic, copy) NSString * text;

@end

@interface ServiceList : NSObject
///服务地址
@property (nonatomic, copy) NSString * service;
/**baccy 订烟Url
info 信息Url
pay 支付Url
saler 营销Url
merchant 商户Url
score 积分Ur
*/
@property (nonatomic, copy) NSString * serviceCode;
@property (nonatomic, copy) NSString * serviceId;

@end

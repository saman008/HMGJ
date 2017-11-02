//
//  RoleModel.h
//  YLProject
//
//  Created by qzp on 2017/2/24.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoleModel : NSObject
@property (nonatomic, copy) NSString * realName;
///0-待审核 1-可用 2-不可用 3-收款关闭
@property (nonatomic, copy) NSString * status;
///0-店主 1-店长 2-店员
@property (nonatomic, copy) NSString * roleCode;
@property (nonatomic, copy) NSString * roleName;
@property (nonatomic, copy) NSString * qrCode;
@property (nonatomic, copy) NSString * eAccountFlag;
@property (nonatomic, copy) NSString * tobaccoFlag;
@property (nonatomic, assign) NSInteger  code;

@end

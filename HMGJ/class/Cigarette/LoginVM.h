//
//  LoginVM.h
//  Epay
//
//  Created by disancheng on 2017/5/24.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface LoginVM : NSObject
@property (nonatomic, copy) NSString * phone;
@property (nonatomic, copy) NSString * pwd;
@property (nonatomic, copy) RACCommand * loginCommand;
@property (nonatomic, strong) RACCommand * registerCommand;
@end

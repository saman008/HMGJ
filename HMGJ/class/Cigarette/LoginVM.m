//
//  LoginVM.m
//  Epay
//
//  Created by disancheng on 2017/5/24.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "LoginVM.h"
#import <YYWebImage/YYWebImage.h>
#import "AppMacro.h"
#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "QZPToolHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
#import <YTKKeyValueStore/YTKKeyValueStore.h>
#import "ThirdParyMarco.h"
#import "AppManager.h"
#define N_UpdateUserCenter @"N_UpdateUserCenter"
@implementation LoginVM



- (RACCommand *)loginCommand {
    @weakify(self);
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            RACSignal * dataSource = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                [HttpRequest loginWithPassword: self.pwd userName: self.phone equipNo: UUID results:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    
                    if (statusCode == HttpResponseCodeSuccess) {
                        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                        [userDefault setObject: self.pwd forKey: @"UD_PWD"];
                        [userDefault setObject: self.phone forKey: @"UD_PHONE"];
                        [userDefault synchronize];
                        
                    
                        
                        YTKKeyValueStore * store = [[YTKKeyValueStore alloc] initDBWithName: DBName];
                        [store createTableWithName: Person_table];
                        [store putObject: anyobject withId: Person_DB_Key intoTable:  Person_table];
                        [[NSNotificationCenter defaultCenter] postNotificationName: N_UpdateUserCenter object:nil];
                        
                        
                        [HttpRequest employeeOne:^(NSInteger statusCode, NSString *msg, id anyobject) {
                           
                        }];
                        
                    }
                    [subscriber sendNext: @[[NSNumber numberWithInteger: statusCode],msg]];
                    [subscriber sendCompleted];
                    [AppManager postRender];
                    
                }];
                
                return nil;
            }];
            return dataSource;
        }];
        
    }
    return _loginCommand;
}

- (RACCommand *)registerCommand {
    
    @weakify(self);
    if (!_registerCommand) {
        
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            RACSignal * dataSource = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
                [HttpRequest registerWithCell: self.phone password: self.pwd result:^(NSInteger statusCode, NSString *msg, id anyobject) {
               
                    [subscriber sendNext: @[[NSNumber numberWithInteger: statusCode],msg,anyobject]];
                    [subscriber sendCompleted];
                }];
                
                return nil;
            }];
            return dataSource;
            
        }];
        
    }
    return _registerCommand;
}

@end



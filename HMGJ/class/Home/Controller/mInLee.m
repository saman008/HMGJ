//
//  RNManagerBridge.m
//  RNBridgeSwift
//
//  Created by Zero on 2017/3/28.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import "mInLee.h"
#import "HooDatePicker.h"

@interface mInLee ()<HooDatePickerDelegate>
@property (nonatomic, strong) HooDatePicker * datePicker;

@end

@implementation mInLee
{
    RCTResponseSenderBlock _alertCallback;
    NSString *_status;
}


    RCT_EXPORT_MODULE(); //此处不添加参数即默认为这个OC类的名字（RNManagerBridge）

RCT_EXPORT_METHOD(hide){
    NSLog(@" ===> doSomething");
  
        // [MBProgressHUD hideProgress];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notificatioinhide" object:@"成功" userInfo:nil];
    });
    
}

RCT_REMAP_METHOD(showDialog,s1:(id)s1 s2:(id)s2 callback:(RCTResponseSenderBlock)callback s3:(id)s3 ){
    
    _status = s2;
    _alertCallback = callback;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_status integerValue] == 1) {
            [self initDataPicker];
            _datePicker.datePickerMode = HooDatePickerModeDate;
        } else {
            [self initDataPicker];
            _datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
        }
        
        [self.datePicker show];
    });
    
    
}
- (void) initDataPicker {
    _datePicker= [[HooDatePicker alloc] initWithSuperView: [UIApplication sharedApplication].delegate.window.rootViewController.view];
    _datePicker.backgroundColor = [UIColor redColor];
    
    _datePicker.delegate =self;
    _datePicker.maximumDate = [NSDate date];
    [_datePicker dismiss];
}


RCT_EXPORT_METHOD(finishActivity){
    NSLog(@" ===> finishActivity");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"K_finishActivity" object:nil];
    });
    
}

RCT_REMAP_METHOD(a,s1:(id) s1 s2:(id)s2 allback:(RCTResponseSenderBlock)callback s3:(id) s3){
    NSLog(@" ===> finishActivity");
    
}
#pragma mark -HooDatePickerDelegate-
- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    if ([_status integerValue] == 1) {//日
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else { //月
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSString * str =  [dateFormatter stringFromDate: date];
    
    [self.datePicker dismiss];
    self.datePicker = nil;
    _alertCallback(@[@{@"time": str}]);
    
}


//    // transportMessage 和 js上调用方法一致
//    RCT_EXPORT_METHOD(transportMessage:(id)message) {
//        NSLog(@"transportMessage:\n %@",message);
//        
//        if ([message isKindOfClass:[NSDictionary class]]) {
//            NSString *method = [message objectForKey:@"method"];
//            
//            BOOL isNext = method ? ([method isEqualToString:@"push"] || [method isEqualToString:@"present"]) : NO ;
//            
//            if (isNext) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinNext" object:message userInfo:nil];
//            } else {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinBack" object:message userInfo:nil];
//            }
//            
//        }
//    }
//    
//    //RN传参数调用原生OC,并且返回数据给RN  通过CallBack
//    RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
//        NSLog(@"接收到RN传过来的数据为:%@",dictionary);
//        NSArray *events = @[
//                            @{
//                                @"name" : @"我是回调1item---",
//                                @"value": @"100"
//                                },
//                            @{
//                                @"name" : @"我是回调2item---",
//                                @"value": @"99"
//                                }
//                            ];
//        
//        callback(@[[NSNull null], events]);
//    }
@end

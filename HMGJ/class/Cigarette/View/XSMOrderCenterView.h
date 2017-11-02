//
//  XSMOrderCenterView.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XSMOrderReturnType) {
XSMOrderReturnTypeModfiy,
XSMOrderReturnTypePay,
XSMOrderReturnTypeDelete,
XSMOrderReturnTypeCheck
};

@interface XSMOrderCenterView : UIView
@property (nonatomic, assign) NSDictionary * params;
@property (nonatomic, copy) void(^returnBlock)(XSMOrderReturnType type);

@end

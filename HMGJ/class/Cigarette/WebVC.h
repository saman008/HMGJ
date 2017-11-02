//
//  WebVC.h
//  YLProject
//
//  Created by qzp on 2017/3/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WebType) {
    WebTypeUrl,
    WebTypeFile,
    WebTypeNormalWeb
};

@interface WebVC : UIViewController
@property (nonatomic, copy) NSString * urlStr;
@property (nonatomic, assign) WebType type;

//是否隐藏导航栏，并注入JS
@property (nonatomic, assign) BOOL hideNav;

@property (nonatomic, assign) BOOL isPay;

@end

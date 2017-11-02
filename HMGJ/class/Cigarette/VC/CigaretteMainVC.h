//
//  CigaretteMainVC.h
//  Epay
//
//  Created by qzp on 2017/6/17.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CigaretteMainVC : UIViewController

//订烟过后输入的账号和密码
@property (nonatomic, strong) NSString * custId;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * orgCode;
@property (nonatomic, strong) NSString * cell;
//判断是否是易付订烟进入该界面的
@property (nonatomic, strong) NSString * changeRefresh;
@property (nonatomic, strong) NSDictionary * params; //返回的json 自动登录
@end

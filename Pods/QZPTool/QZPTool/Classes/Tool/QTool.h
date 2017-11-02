//
//  QTool.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QTool : NSObject
//文本自适应
CGSize getStringSize(NSString *str,UIFont *font,float width);
//去除字符串中所有空格
NSString* removeStringBlank(NSString *str);
///限制输入,只能输入validationstr字符串
BOOL inputValidation(NSString *inputStr,NSString *validationStr);
//判断某字符串是否全部是中文
BOOL allChinese(NSString *str);
//判断某字符串是否包含是中文
BOOL haveChinese(NSString *str);
















/**
 *  只能输入数字和一个小数点
 *
 *  @param textField 输入框
 *  @param range     范围
 *  @param string    string
 *  @param number    小数点后可以有几位数
 *
 *  @return 是否满足条件
 */
+ (BOOL) isValidAboutInputText: (UITextField *)textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string decimalNumber: (NSInteger) number;

///
+ (void) colorLabel: (UILabel *) label font: (UIFont *) font rang: (NSRange) rang color: (UIColor *) color;


@end

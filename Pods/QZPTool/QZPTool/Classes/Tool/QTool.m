//
//  QTool.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "QTool.h"

@implementation QTool

CGSize getStringSize(NSString *str,UIFont *font,float width){
    CGSize size;
    CGRect rect=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                               attributes:@{NSFontAttributeName:font}
                                  context:nil];
    size=rect.size;
    return size;
    
}
NSString* removeStringBlank(NSString *str){
    NSMutableString *newstr=[[NSMutableString alloc]init];
    for (int i=0; i<str.length; i++) {
        NSString *temp=[str substringWithRange:NSMakeRange(i, 1)];
        
        if ([temp isEqualToString:@" "]) {
            
        }
        else{
            [newstr appendString:temp];
            
        }
        
    }
    return newstr;
}
BOOL inputValidation(NSString *inputStr,NSString *validationStr){
    BOOL res=YES;
    NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:validationStr];
    int i=0;
    while (i<inputStr.length) {
        NSString *tempStr=[inputStr substringWithRange:NSMakeRange(i, 1)];
        NSRange range=[tempStr rangeOfCharacterFromSet:set];
        if (range.length==0) {
            res=NO;
            break;
        }
        i++;
    }
    return res;
}
BOOL allChinese(NSString *str){
    BOOL is=YES;
    //UTF8编码：汉字占3个字节，英文字符占1个字节
    NSInteger length=[str length];
    for (int i=0; i<length; i++) {
        NSRange range=NSMakeRange(i, 1);
        NSString *subStr=[str substringWithRange:range];
        const char *cString=[subStr UTF8String];
        if (strlen(cString)!=3) {
            return NO;
        }
        
    }
    return is;
}
BOOL haveChinese(NSString *str){
    BOOL is=NO;
    //UTF8编码：汉字占3个字节，英文字符占1个字节
    NSInteger length=[str length];
    for (int i=0; i<length; i++) {
        NSRange range=NSMakeRange(i, 1);
        NSString *subStr=[str substringWithRange:range];
        const char *cString=[subStr UTF8String];
        if (strlen(cString)==3) {
            return YES;
        }
        
    }
    return is;
    
}




+ (BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange :(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number {
    NSScanner * scanner = [NSScanner scannerWithString: string];
    NSCharacterSet * numbers;
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if ((pointRange.length > 0) && (pointRange.location < range.location || pointRange.location > range.location + range.length)) {
        numbers = [NSCharacterSet characterSetWithCharactersInString: @"0123456789"];
    }else {
        numbers = [NSCharacterSet characterSetWithCharactersInString: @"0123456789."];
    }
    
    if ([textField.text isEqualToString:@""] && [string isEqualToString: @"."]) {
        return NO;
    }
    short remain = number;
    NSString * tempStr = [textField.text stringByAppendingString: string];
    NSUInteger strLength = [tempStr length];
    if (pointRange.length > 0 && pointRange.location > 0) {///判断输入框内是否含有“.”
        if ([string isEqualToString: @"."]) {//当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效
        if (strLength > 0 && (strLength - pointRange.location) > remain + 1) {
            
            return NO;
        }
    }
    
    NSRange zeroRange = [textField.text rangeOfString: @"0"];
    if (zeroRange.length ==1 && zeroRange.location == 0) {//判断输入框第一个字符是否为“0”
        //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
        if (![string isEqualToString: @"0"] && ![string isEqualToString:@"."] && textField.text.length == 1) {
            textField.text = string;
            return NO;
        } else {
            //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
            if (pointRange.length == 0 && pointRange.location > 0) {
                if ([string isEqualToString: @"0"]) {
                    return NO;
                }
            }
        }
    }
    NSString * buffer;
    if (![scanner scanCharactersFromSet: numbers intoString: &buffer] && string.length != 0) {
        return NO;
    }else {
        return YES;
    }
    
}
+ (void)colorLabel:(UILabel *)label font:(UIFont *)font rang:(NSRange)rang color:(UIColor *)color {
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString: label.text];
    [str addAttribute:NSFontAttributeName value:font range:rang];
    [str addAttribute: NSForegroundColorAttributeName value: color range: rang];
    label.attributedText = str;
}

@end

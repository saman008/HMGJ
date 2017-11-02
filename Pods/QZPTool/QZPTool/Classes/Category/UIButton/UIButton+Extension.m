//
//  UIButton+Extension.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
#import "UIImage+Extension.h"

static char rightImageKey;
static char topImageKey;
static char lineSpacingKey;
static char backgroundColorAtNormalKey;
static char txtColorKey;
@implementation UIButton (Extension)
- (void)setTxtColor:(BOOL)txtColor {
    objc_setAssociatedObject(self, &txtColorKey, @(txtColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)txtColor {
    NSNumber *txtColor = objc_getAssociatedObject(self, &txtColorKey);
    return txtColor.boolValue;
}
- (UIImage *)rightImage {
    return objc_getAssociatedObject(self, &rightImageKey);
}
- (void)setRightImage:(UIImage *)rightImage {
    NSString *title = [self titleForState:UIControlStateNormal];
    title = [NSString stringWithFormat:@"%@  ", title ?: @""];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title];
    UIColor *normalColor = [self titleColorForState:UIControlStateNormal];
    UIColor *selectedColor = [self titleColorForState:UIControlStateSelected];
    UIColor *heighColor = [self titleColorForState:UIControlStateHighlighted];
    NSMutableAttributedString *normalString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [normalString addAttribute:NSForegroundColorAttributeName
                         value:normalColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [rightImage imageTintedWithColor:normalColor];
    NSAttributedString *attributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [normalString appendAttributedString:attributeStr1];
    [self setAttributedTitle:normalString forState:UIControlStateNormal];
    NSMutableAttributedString *selectedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [selectedString addAttribute:NSForegroundColorAttributeName
                           value:[self titleColorForState:UIControlStateSelected]
                           range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentSelected = [[NSTextAttachment alloc] init];
    textAttachmentSelected.image = [rightImage imageTintedWithColor:selectedColor];
    NSAttributedString *selectedAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentSelected];
    [selectedString appendAttributedString:selectedAttributeStr1];
    [self setAttributedTitle:selectedString forState:UIControlStateSelected];
    NSMutableAttributedString *heightString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [heightString addAttribute:NSForegroundColorAttributeName
                         value:heighColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentHeigh = [[NSTextAttachment alloc] init];
    textAttachmentHeigh.image = [rightImage imageTintedWithColor:heighColor];
    NSAttributedString *selectedAttributeStr2 = [NSAttributedString attributedStringWithAttachment:textAttachmentHeigh];
    [heightString appendAttributedString:selectedAttributeStr2];
    [self setAttributedTitle:heightString forState:UIControlStateHighlighted];
    objc_setAssociatedObject(self, &rightImageKey, rightImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)topImage {
    return objc_getAssociatedObject(self, &topImageKey);
}
- (void)setTopImage:(UIImage *)topImage {
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *title = [self titleForState:UIControlStateNormal];
    title = [@"\n" stringByAppendingString:title];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = self.lineSpacing;
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentCenter:
            style.alignment = NSTextAlignmentCenter;
            break;
        case UIControlContentHorizontalAlignmentLeft:
            style.alignment = NSTextAlignmentLeft;
            break;
        case UIControlContentHorizontalAlignmentRight:
            style.alignment = NSTextAlignmentRight;
            break;
        default:
            style.alignment = NSTextAlignmentCenter;
            break;
    }
    //    [attributeStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    UIColor *normalColor = [self titleColorForState:UIControlStateNormal];
    UIColor *selectedColor = [self titleColorForState:UIControlStateSelected];
    UIColor *heighlightColor = [self titleColorForState:UIControlStateHighlighted];
    //正常button
    NSMutableAttributedString *normalString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [normalString addAttribute:NSForegroundColorAttributeName
                         value:normalColor
                         range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = self.txtColor ? [topImage imageTintedWithColor:normalColor] : topImage;
    NSAttributedString *attributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [normalString insertAttributedString:attributeStr1 atIndex:0];
    [normalString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    [self setAttributedTitle:normalString forState:UIControlStateNormal];
    //选中的button
    NSMutableAttributedString *selectedString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [selectedString addAttribute:NSForegroundColorAttributeName
                           value:[self titleColorForState:UIControlStateSelected]
                           range:NSMakeRange(0, title.length)];
    // 插入图片
    NSTextAttachment *textAttachmentSelected = [[NSTextAttachment alloc] init];
    textAttachmentSelected.image = self.txtColor ? [topImage imageTintedWithColor:selectedColor] : topImage;
    NSAttributedString *selectedAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentSelected];
    [selectedString insertAttributedString:selectedAttributeStr1 atIndex:0];
    [selectedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    [self setAttributedTitle:selectedString forState:UIControlStateSelected];
    //高亮的button
    NSMutableAttributedString *heighlightString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeStr];
    [heighlightString addAttribute:NSForegroundColorAttributeName
                             value:[self titleColorForState:UIControlStateHighlighted]
                             range:NSMakeRange(0, title.length)];
    NSTextAttachment *textAttachmentHeighlight = [[NSTextAttachment alloc] init];
    textAttachmentHeighlight.image = self.txtColor ? [topImage imageTintedWithColor:heighlightColor] : topImage;
    NSAttributedString *heighlightAttributeStr1 = [NSAttributedString attributedStringWithAttachment:textAttachmentHeighlight];
    [heighlightString insertAttributedString:heighlightAttributeStr1 atIndex:0];
    [heighlightString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, normalString.length)];
    [self setAttributedTitle:heighlightString forState:UIControlStateHighlighted];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    objc_setAssociatedObject(self, &topImageKey, topImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setBackgroundColorAtNormal:(UIColor *)backgroundColorAtNormal {
    UIImage *imgColor = [UIImage imageWithColor:backgroundColorAtNormal];
    [self setBackgroundImage:imgColor forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &backgroundColorAtNormalKey, backgroundColorAtNormal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)backgroundColorAtNormal {
    return objc_getAssociatedObject(self, &backgroundColorAtNormalKey);
}
#pragma mark - 样式
- (CGFloat)lineSpacing {
    return [objc_getAssociatedObject(self, &lineSpacingKey) floatValue];
}
- (void)setLineSpacing:(CGFloat)lineSpacing {
    objc_setAssociatedObject(self, &lineSpacingKey, @(lineSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.topImage = self.topImage;
}
@end

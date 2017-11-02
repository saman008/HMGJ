//
//  UIImage+Extension.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  @brief 更改图片颜色
 *
 *  @param color 颜色值
 *
 *  @return 更改颜色之后的图片
 */
- (UIImage *)imageTintedWithColor:(UIColor *)color;
#pragma mark ----------- 遮罩
/**
 *  @brief 将自己图片加在一个遮罩上
 *
 *  @param maskImage 遮罩图
 *
 *  @return 加上遮罩后的图片
 */
- (UIImage *) maskWithImage:(const UIImage *) maskImage;
/**
 *  @brief 给自己加个遮罩色
 *
 *  @param color 遮罩色
 *
 *  @return 加上遮罩后的图片
 */
- (UIImage *) maskWithColor:(UIColor*) color;
#pragma mark - 设置圆角图片   圆形图片
/**
 *  @brief 设置圆形图片
 *
 *  @param diameter 圓直径
 *
 *  @return 圆形图片
 */
- (UIImage *)circularImageWithDiamter:(NSUInteger)diameter;
/**
 *  @brief 设置圆角图片
 *
 *  @param width        图片长宽
 *  @param cornerRadius 圆角角度
 *
 *  @return 圆角图片
 */
- (UIImage *)roundedRectImageWithWidth:(NSUInteger)width withCornerRadius:(CGFloat)cornerRadius;
- (UIImage *)roundedRectImageWithSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius;
#pragma mark -------------------------------
/**
 *  @brief 缩小图片大小
 *
 *  @param aRect 大小
 *
 *  @return 处理后的图片
 */
- (UIImage*)shrinkImage:(CGRect)aRect;
/**
 *  @brief 设置缩略图
 *
 *  @param aImage 源图片
 *
 *  @return 处理后的图片
 */
- (UIImage *)generatePhotoThumbnail:(UIImage *)aImage;
/**
 *  @brief //计算适合的大小。并保留其原始图片大小
 *
 *  @param aThisSize 当前图片大小
 *  @param aSize     容器框大小
 *
 *  @return 适合的大小
 */
+ (CGSize)fitSize:(CGSize)aThisSize inSize:(CGSize)aSize;
/**
 *  @brief 返回调整的缩略图
 *
 *  @param aImage    源图片
 *  @param aViewsize 容器大小
 *
 *  @return 调整的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage fitInSize:(CGSize)aViewsize;
/**
 *  @brief 居中图片
 *
 *  @param aImage    源图片
 *  @param aViewsize 展示大小
 *
 *  @return 居中的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize;
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize backgroundColor:(UIColor*)bgColor;
/**
 *  @brief 填充图片
 *
 *  @param aImage    源图片
 *  @param aViewsize 需要填充的大小
 *
 *  @return 填充的缩略图
 */
+ (UIImage *)image:(UIImage *)aImage fillSize:(CGSize)aViewsize;
/**
 *  @brief 让图片变小
 *
 *  @param aInImage 源图片
 *  @param aSize    略小的大小
 *
 *  @return 变小后的图片
 */
+ (UIImage *)rescaleToSize:(UIImage *)aInImage toSize:(CGSize)aSize;
#pragma mark
- (UIImage *) croppedImage:(CGRect)cropRect;
+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float) i_width;
/**
 *  @brief 画出一个纯色的图片
 *
 *  @param color 图片颜色
 *  @param aSize 尺寸
 *
 *  @return 画出来的图片
 */
+ (UIImage*)imageTintedWithColor:(UIColor*)color  toSize:(CGSize)aSize;
/**
 *   @brief  纯色图片
 *
 *   @param color 颜色
 *
 *   @return 相应颜色的图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;
/**
 *  @brief 图片保存为jpg,png文件
 *
 *  @param aImage    源图片
 *  @param aFilePath 存放位置
 *
 *  @return 是否保存成功
 */
+ (BOOL) writeToImage:(UIImage*)aImage toFileAtPath:(NSString *)aFilePath;

///2种渐变颜色的生成图片 direction =0 从上到下 =1 从左到右
+ (UIImage *) imageForColors:(NSArray *) colorArray withSize: (CGSize) size direction:(NSInteger) direction;

@end

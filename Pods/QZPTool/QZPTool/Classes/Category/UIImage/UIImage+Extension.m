//
//  UIImage+Extension.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
#pragma mark - 更改图片颜色
- (UIImage *)imageTintedWithColor:(UIColor *)color
{
    // This method is designed for use with template images, i.e. solid-coloured mask-like images.
    return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
    if (color) {
        // Construct new image the same size as this one.
        UIImage *image;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
        if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
            UIGraphicsBeginImageContextWithOptions([self size], NO, [UIScreen mainScreen].scale); // 0.f for scale means "scale for device's main screen".
        } else {
            UIGraphicsBeginImageContext([self size]);
        }
#else
        UIGraphicsBeginImageContext([self size]);
#endif
        CGRect rect = CGRectZero;
        rect.size = [self size];
        
        // Composite tint color at its own opacity.
        [color set];
        UIRectFill(rect);
        
        // Mask tint color-swatch to this image's opaque mask.
        // We want behaviour like NSCompositeDestinationIn on Mac OS X.
        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
        
        // Finally, composite this image over the tinted mask at desired opacity.
        if (fraction > 0.0) {
            // We want behaviour like NSCompositeSourceOver on Mac OS X.
            [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
        }
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    return self;
}
#pragma mark -----------
- (UIImage *)maskWithImage:(const UIImage *) maskImage
{
    float scaleFactor = [[UIScreen mainScreen] scale];
    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const CGImageRef maskImageRef = maskImage.CGImage;
    
    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width* scaleFactor, maskImage.size.height* scaleFactor, 8, maskImage.size.width * scaleFactor * 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextScaleCTM(mainViewContentContext, scaleFactor, scaleFactor);
    CGContextSetInterpolationQuality(mainViewContentContext, kCGInterpolationHigh);
    CGColorSpaceRelease(colorSpace);
    
    if (! mainViewContentContext)
    {
        return nil;
    }
    
    CGFloat ratio = maskImage.size.width / self.size.width;
    
    if (ratio * self.size.height < maskImage.size.height)
    {
        ratio = maskImage.size.height / self.size.height;
    }
    
    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    
    const CGRect imageRect  = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
                                         self.size.width * ratio,
                                         self.size.height * ratio);
    
    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    return theImage;
    //    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //    const CGImageRef maskImageRef = maskImage.CGImage;
    //
    //    const CGContextRef mainViewContentContext = CGBitmapContextCreate(NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    ////    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    //    CGColorSpaceRelease(colorSpace);
    //
    //    if (! mainViewContentContext)
    //    {
    //        return nil;
    //    }
    //
    //    CGFloat ratio = maskImage.size.width / self.size.width;
    //    if (ratio * self.size.height < maskImage.size.height)
    //    {
    //        ratio = maskImage.size.height / self.size.height;
    //    }
    //
    //    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    //
    //    const CGRect imageRect = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
    //                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
    //                                         self.size.width * ratio,
    //                                         self.size.height * ratio);
    //
    //    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    //    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    //
    //    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    //    CGContextRelease(mainViewContentContext);
    //
    //    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    //
    //    CGImageRelease(newImage);
    //
    //    return theImage;
    
}
/*
 maskWithColor
 takes a (grayscale) image and 'tints' it with the supplied color.
 */
- (UIImage *) maskWithColor:(UIColor *) color
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    //    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, self.CGImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
    
}
#pragma mark - 设置圆角图片   圆形图片
- (UIImage *)circularImageWithDiamter:(NSUInteger)diameter
{
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    [self drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)roundedRectImageWithWidth:(NSUInteger)width withCornerRadius:(CGFloat)cornerRadius
{
    CGSize size = CGSizeMake(width, width);
    return [self roundedRectImageWithSize:size withCornerRadius:cornerRadius];
}
- (UIImage *)roundedRectImageWithSize:(CGSize)size withCornerRadius:(CGFloat)cornerRadius
{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:cornerRadius];
    [imgPath addClip];
    [self drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -------------------------------
- (UIImage*)shrinkImage:(CGRect)aRect {
    UIGraphicsBeginImageContextWithOptions(aRect.size, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:aRect];
    
    UIImage* shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return shrinkedImage;
}
- (UIImage *)generatePhotoThumbnail:(UIImage *)aImage {
    // Create a thumbnail version of the image for the event object.
    CGSize size = aImage.size;
    CGSize croppedSize;
    //	CGFloat ratio = 64.0;
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([aImage CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, croppedSize.width, croppedSize.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}
+ (CGSize)fitSize:(CGSize)aThisSize inSize:(CGSize)aSize
{
    CGFloat scale;
    CGSize newsize = aThisSize;
    
    if (newsize.height && (newsize.height > aSize.height))
    {
        scale = aSize.height / newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    if (newsize.width && (newsize.width >= aSize.width))
    {
        scale = aSize.width / newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    
    return newsize;
}
//返回调整的缩略图
+ (UIImage *)image:(UIImage *)aImage fitInSize:(CGSize)aViewsize
{
    // calculate the fitted size
    CGSize size = [self fitSize:aImage.size inSize:aViewsize];
    
    UIGraphicsBeginImageContext(aViewsize);
    
    float dwidth = (aViewsize.width - size.width) / 2.0f;
    float dheight = (aViewsize.height - size.height) / 2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [aImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
//返回居中的缩略图
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize
{
    return [self image:aImage centerInSize:aViewsize backgroundColor:nil];
}
+ (UIImage *)image:(UIImage *)aImage centerInSize:(CGSize)aViewsize backgroundColor:(UIColor*)bgColor
{
    CGSize size = aImage.size;
    UIGraphicsBeginImageContextWithOptions(aViewsize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (bgColor) {
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, aViewsize.width, aViewsize.height));
    }
    
    
    float dwidth = (aViewsize.width - size.width) / 2.0f;
    float dheight = (aViewsize.height - size.height) / 2.0f;
    CGRect rect = CGRectMake(dwidth, dheight, size.width, size.height);
    [aImage drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
//返回填充的缩略图
+ (UIImage *)image:(UIImage *)aImage fillSize:(CGSize)aViewsize
{
    CGSize size = aImage.size;
    
    CGFloat scalex = aViewsize.width / size.width;
    CGFloat scaley = aViewsize.height / size.height;
    CGFloat scale = MAX(scalex, scaley);
    
    UIGraphicsBeginImageContext(aViewsize);
    
    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;
    
    float dwidth = ((aViewsize.width - width) / 2.0f);
    float dheight = ((aViewsize.height - height) / 2.0f);
    
    CGRect rect = CGRectMake(dwidth, dheight, size.width * scale, size.height * scale);
    [aImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
//让图片变小
+ (UIImage *)rescaleToSize:(UIImage *)aInImage toSize:(CGSize)aSize {
    CGRect rect = CGRectMake(0.0, 0.0, aSize.width, aSize.height);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(aSize, NO, [UIScreen mainScreen].scale); // 0.f for scale means "scale for device's main screen".
    } else {
        UIGraphicsBeginImageContext(aSize);
    }
#else
    UIGraphicsBeginImageContext([self size]);
#endif
    
    //	UIGraphicsBeginImageContext(rect.size);
    [aInImage drawInRect:rect];
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}
#pragma mark
- (UIImage *) croppedImage:(CGRect)cropRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect( [self CGImage], cropRect );
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:1.0f orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return croppedImage;
}
+ (BOOL) writeToImage:(UIImage*)aImage toFileAtPath:(NSString *)aFilePath
{
    if ( (aImage == nil) || (aFilePath == nil) ) {
        return NO;
    }
    
    @try {
        NSData *imageData = nil;
        NSString *ext = [aFilePath pathExtension];
        if ([ext isEqualToString:@"jpeg"]||[ext isEqualToString:@"jpg"]) {
            // 0. best  1. lost
            imageData = UIImageJPEGRepresentation(aImage, 0);
        }
        else if([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(aImage);
        }
        
        if ( (imageData == nil) || ([imageData length] <= 0)) {
            return NO;
        }
        
        [imageData writeToFile:aFilePath atomically:YES];
        
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"create file exception.");
    }
    return NO;
}
+ (UIImage*)imageTintedWithColor:(UIColor*)color  toSize:(CGSize)aSize
{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage*)imageWithColor:(UIColor*)color
{
    CGFloat width = 5.f;
    CGFloat height = 5.f;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
}
+ (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageForColors:(NSArray *)colorArray withSize:(CGSize)size direction:(NSInteger)direction {
    NSMutableArray *arr=[NSMutableArray  array];
    for (UIColor *color in colorArray ) {
        [arr addObject:(id)color.CGColor];
    }
    //生成透明图片阴影
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    //获取图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //当前图形入栈
    CGContextSaveGState(context);
    //
    CGColorSpaceRef colorSpace=CGColorGetColorSpace([[colorArray lastObject] CGColor]);
    //
    CGGradientRef gardient=CGGradientCreateWithColors(colorSpace, (CFArrayRef)arr, NULL);
    CGPoint start;
    CGPoint end;
    
    //从上到下
    if (direction == 0) {
        start=CGPointMake(0, 0);
        end=CGPointMake(0, size.height);
    } else {
        //从左到右
        start=CGPointMake(0, 0);
        end=CGPointMake(size.width, 0);
    }
    //------从右上到左下-----
//    start=CGPointMake(size.width, 0);
//    end=CGPointMake(0, size.height);
    
    CGContextDrawLinearGradient(context, gardient, start, end, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    //资源释放
    CGGradientRelease(gardient);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    //结束
    UIGraphicsEndImageContext();
    return image;
}





@end

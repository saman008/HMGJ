//
//  QZP_BaseMacro.h
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#ifndef QZP_BaseMacro_h
#define QZP_BaseMacro_h

#define IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define IPHONE6PLUS ([[UIScreen mainScreen] bounds].size.height == 736)
#define IPAD  ([[UIScreen mainScreen] bounds].size.height == 1024)


#define UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define QPWeak(type)  __weak typeof(type) weak##type = type;
#define QPStrong(type)  __strong typeof(type) type = weak##type;
#ifdef DEBUG
#define QLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define QLog( s, ... )
#endif

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define UserDefaults   [NSUserDefaults standardUserDefaults]
#define kWindow         [[UIApplication sharedApplication] keyWindow]
#define GetUserDefaults(KEY)     [[NSUserDefaults standardUserDefaults]objectForKey:KEY]
#define SetUserDefaults(VALUE,KEY)  [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)
#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)
#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)
#define GetImage(imgName) [UIImage imageNamed:imgName]
#define URL(url) [NSURL URLWithString:url]
#define string(str1,str2) [NSString stringWithFormat:@"%@%@",str1,str2]
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])// 当前系统语言
///正常字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define Font30 [UIFont systemFontOfSize:30]
#define Font29 [UIFont systemFontOfSize:29]
#define Font28 [UIFont systemFontOfSize:28]
#define Font27 [UIFont systemFontOfSize:27]
#define Font26 [UIFont systemFontOfSize:26]
#define Font25 [UIFont systemFontOfSize:25]
#define Font24 [UIFont systemFontOfSize:24]
#define Font23 [UIFont systemFontOfSize:23]
#define Font22 [UIFont systemFontOfSize:22]
#define Font21 [UIFont systemFontOfSize:21]
#define Font20 [UIFont systemFontOfSize:20]
#define Font19 [UIFont systemFontOfSize:19]
#define Font18 [UIFont systemFontOfSize:18]
#define Font17 [UIFont systemFontOfSize:17]
#define Font16 [UIFont systemFontOfSize:16]
#define Font15 [UIFont systemFontOfSize:15]
#define Font14 [UIFont systemFontOfSize:14]
#define Font13 [UIFont systemFontOfSize:13]
#define Font12 [UIFont systemFontOfSize:12]
#define Font11 [UIFont systemFontOfSize:11]
#define Font10 [UIFont systemFontOfSize:10]
#define Font9 [UIFont systemFontOfSize:9]
#define Font8 [UIFont systemFontOfSize:8]

#endif /* QZP_BaseMacro_h */

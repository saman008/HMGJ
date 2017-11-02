//
//  CigaretteGoodsAddVC.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cigarette.h"
@interface CigaretteGoodsAddVC : UIViewController
@property (nonatomic, assign) NSInteger number; //当前数量
@property (nonatomic, copy) void (^numberChange)(NSInteger index);
@property (nonatomic, strong) NSDictionary * limitDic; //限量
@property (nonatomic, assign) Cigarette * cigarette;
@property (nonatomic, copy) void (^collectChange)(BOOL isFav); ///点击收藏回调
@end

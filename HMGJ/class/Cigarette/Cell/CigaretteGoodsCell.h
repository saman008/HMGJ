//
//  CigaretteGoodsCell.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cigarette.h"

typedef NS_ENUM(NSInteger, CigaretteGoodsType)  {
//    收藏
    CigaretteGoodsTypeCollect,
    ///历史订单
    CigaretteGoodsTypeHistoyList,
    ///订烟列表
    CigaretteGoodsTypeGoodsList,
};

@interface CigaretteGoodsCell : UITableViewCell


@property (nonatomic, assign) CigaretteGoodsType type;
@property (nonatomic, strong) Cigarette * cigartte;

@end

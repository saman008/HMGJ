//
//  Cigarette.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cigarette : NSObject
//经营类型1:新品,2:紧俏,3:顺销,9:其他
@property (nonatomic, copy) NSString * brdType;
//替代品类型
@property (nonatomic, copy) NSString * cateGory;
//品牌名称
@property (nonatomic, copy) NSString * cgtBrandName;
//盒码
@property (nonatomic, copy) NSString * cgtCartonCode;
//卷烟编码
@property (nonatomic, copy) NSString * cgtCode;
//卷烟名称
@property (nonatomic, copy) NSString * cgtName;
//条码
@property (nonatomic, copy) NSString * cgtPacketCode;
//卷烟类型
@property (nonatomic, copy) NSString * cgtTypeName;
//一氧化碳(mg)
@property (nonatomic, copy) NSString * coCont;
//烟气烟碱(mg)
@property (nonatomic, copy) NSString * gasNictine;
//是否推荐
@property (nonatomic, copy) NSString * isAdvise;
//是否纳入到订单量限量限制
@property (nonatomic, copy) NSString * isCoLmt;
//是否纳入到订单订购量倍数的限制
@property (nonatomic, copy) NSString * isCoMulti;
//是否收藏
@property (nonatomic, copy) NSString * isFav;
//产地：/0:省内,1:省外,2:其它,3:国外
@property (nonatomic, copy) NSString * isImported;
//是否使用单品种卷烟订购量的倍数限制
@property (nonatomic, copy) NSString * isMulti;
//是否促销
@property (nonatomic, copy) NSString * isPromote;
@property (nonatomic, copy) NSString * isShort;
//是否有活动
@property (nonatomic, copy) NSString * isTask;
@property (nonatomic, copy) NSString * mfrId;
@property (nonatomic, copy) NSString * mfrIdName;
//批发价
@property (nonatomic, copy) NSString * price;
//促销内容
@property (nonatomic, copy) NSString * promote;
//可用量
@property (nonatomic, copy) NSString * qtyLmt;
//需求量最大值
@property (nonatomic, copy) NSString * reqQtyMax;
//零售价
@property (nonatomic, copy) NSString * rtlPrice;
//卷烟简码
@property (nonatomic, copy) NSString * shortCode;
@property (nonatomic, copy) NSString * tarval;
@property (nonatomic, copy) NSString * umSaleName;
///订购量
@property (nonatomic, copy) NSString * ordQty;


///---添加字段  总金额
@property (nonatomic, copy) NSString * ordAmt;



@end

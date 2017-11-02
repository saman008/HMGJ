//
//  OrderListCell.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "OrderListCell.h"

#import "QZPToolHeader.h"
@interface OrderListCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(OdrerListModel *)model {
    self.orderNumberLabel.text = model.coNum;
    NSString * orderTime = changeDate(@"yyyy.MM.dd", model.orderDate, @"yyyyMMdd");
    self.label1.text = [NSString stringWithFormat:@"订单时间:%@",orderTime ];
    
    /**
     
     订单状态，10:新建,20:提交,30:审核,40:确认,50:配送,60:完成,90:停止
     */
    NSString * orderStatusStr = @"未知";
    NSInteger status = [model.pmtStatus integerValue];
//    if (status == 10) {
//        orderStatusStr = @"新建";
//    } else if (status == 20) {
//        orderStatusStr = @"提交";
//    } else if (status == 30) {
//        orderStatusStr = @"审核";
//    } else if (status == 40) {
//        orderStatusStr = @"确认";
//    } else if (status == 50) {
//        orderStatusStr = @"配送";
//    } else if (status == 60) {
//        orderStatusStr = @"完成";
//    } else if (status == 90) {
//        orderStatusStr = @"停止";
//    }
    
    if (status == 0) {
        orderStatusStr = @"未付款";
    }else if (status == 1) {
        orderStatusStr = @"已付款";
    } else if (status == 2) {
        orderStatusStr = @"付款中";
    }
    
    self.label2.text = [NSString stringWithFormat:@"支付状态:%@", orderStatusStr];
    
    self.label3.text = [NSString stringWithFormat:@"订货量:%@条",model.ordQtySum];
    self.label4.text = [NSString stringWithFormat:@"订单金额:%.2f", [model.ordAmtSum floatValue]];
    
    
}

@end

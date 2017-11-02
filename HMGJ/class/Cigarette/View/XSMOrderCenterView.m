//
//  XSMOrderCenterView.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "XSMOrderCenterView.h"
#import "NSDateTool.h"
#import "AppMacro.h"
@interface XSMOrderCenterView ()
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *giveLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btn2Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

@end

@implementation XSMOrderCenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(id)sender {
//    NSInteger payStatus = [self.params[@"pmtStatus"] integerValue];
    
    if (self.returnBlock) {
    
            if (sender == self.btn2) { //删除
                NSInteger payStatus = [self.params[@"pmtStatus"] integerValue];
                if (payStatus == 2) {
                        self.returnBlock(XSMOrderReturnTypeCheck);
                } else {
                    self.returnBlock(XSMOrderReturnTypeDelete);
                }
            
            } else if (sender == self.btn1) {
                self.returnBlock(XSMOrderReturnTypePay);
            } else if (sender == self.btn3) {
                self.returnBlock(XSMOrderReturnTypeModfiy);
            } else if (sender == self.btn4) {
                self.returnBlock(XSMOrderReturnTypeDelete);
            }else if (sender == self.btn5) {
                self.returnBlock(XSMOrderReturnTypeModfiy);
            }
      
     
    }
    
}


- (void)setParams:(NSDictionary *)params {
    _params = params;
    self.orderLabel.text = params[@"coNum"];
    
    NSString * dateStr = changeDate(@"yyyy年MM月dd日", params[@"orderDate"], @"yyyyMMdd");
    NSUInteger details = [params[@"details"] count];
    
    NSString * date = [NSString stringWithFormat:@"订货日：%@  规格：%lu  订货量：%@条", dateStr,
                       (unsigned long)details, params[@"ordQtySum"]];
    self.dateLabel.text = date;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [params[@"ordAmtSum"] floatValue]];
    self.giveLabel.text = [NSString stringWithFormat:@"赠送：%@",@"0"];
    
    if (XSM_ISEPAY) { //易付用户
        
    } else {//非易付用户
//        [self.btn1 setTitle:@"取消" forState: UIControlStateNormal];
//        self.btn1.hidden = self.btn2.hidden = self.btn3.hidden = YES;
//        self.btn4.hidden = self.btn5.hidden = NO;
    }
//    NSInteger status = [params[@"status"] integerValue];
    //PMT_STATUS付款状态，0:未付款；1:已付款；2：付款中
    
    
//    NSInteger payStatus = [params[@"pmtStatus"] integerValue];
    //test
    NSInteger payStatus = 0;
    if (payStatus == 1) { //已付款
        self.btn1.hidden = self.btn2.hidden = self.btn3.hidden  = self.btn4.hidden = self.btn5.hidden = YES;
        self.payStatusLabel.hidden = NO;
    }
    else if (payStatus == 0) { //去付款
        self.btn3.hidden = NO;
        self.btn2.hidden = NO;
        self.btn1.hidden = NO;
     
    }
    else if (payStatus == 2) { //支付中
        self.btn1.hidden = self.btn3.hidden = self.btn4.hidden = self.btn5.hidden = self.payStatusLabel.hidden = YES;
        [self.btn2 setTitle:@"校验" forState:UIControlStateNormal];
    
    
    }
  
    

    

}
@end

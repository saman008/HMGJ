//
//  OrderDetailVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "OrderDetailVC.h"
#import "CigaretteGoodsCell.h"
#import "Cigarette.h"
#import "CigarettePayResultVC.h"


#import <YYWebImage/YYWebImage.h>
#import "AppMacro.h"
#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "QZPToolHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
@interface OrderDetailVC () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *lable5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) NSMutableArray<Cigarette *> * dataSource;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@end
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];
@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    // Do any additional setup after loading the view.
    self.dataSource = [NSMutableArray array];
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib: CigaretteGoodsCell.nib  forCellReuseIdentifier:@"CigaretteGoodsCell"];
    
    NSString * orderTime = changeDate(@"yyyy年MM月dd日", self.model.orderDate, @"yyyyMMdd");
    self.label1.text = [NSString stringWithFormat:@"订单时间:%@",orderTime];
    self.label2.text = [NSString stringWithFormat:@"订货量:%@条",self.model.ordQtySum];
    self.label3.text = [NSString stringWithFormat:@"积分:%@",@"0"];
    self.label4.text = [NSString stringWithFormat:@"%.2f", [_model.ordAmtSum floatValue]];
    
    /**
     
     订单状态，10:新建,20:提交,30:审核,40:确认,50:配送,60:完成,90:停止
     */
    NSString * orderStatusStr = @"未知";
    NSInteger status = [self.model.pmtStatus integerValue];
    if (status == 0) {
        orderStatusStr = @"未付款";
    }else if (status == 1) {
        orderStatusStr = @"已付款";
    } else if (status == 2) {
        orderStatusStr = @"付款中";
    }
    self.label6.text = [NSString stringWithFormat:@"付款状态:%@", orderStatusStr];
    
    NSInteger statusX = [self.model.status integerValue];
    NSString * statusXStr = @"未知";
    
    if (statusX == 10) {
        statusXStr = @"新建";
    } else if (statusX == 20) {
        statusXStr = @"提交";
    } else if (statusX == 30) {
        statusXStr = @"审核";
    } else if (statusX == 40) {
        statusXStr = @"确认";
    } else if (statusX == 50) {
        statusXStr = @"配送";
    } else if (statusX == 60) {
        statusXStr = @"完成";
    } else if (statusX == 90) {
        statusXStr = @"停止";
    }
    self.lable5.text = [NSString stringWithFormat:@"订单状态:%@",statusXStr];
    
    self.bottomHeight.constant = 0;
    self.bottomView.hidden = YES;
    
//    if(self.isCurrentOrder) {
//        self.btn4.hidden = YES;
//        if (status == 1) { //当期订单已付款
//            self.bottomHeight.constant = 0;
//            self.bottomView.hidden = YES;
//        }
//    }
    
    [MBProgressHUD showBusy];
    @weakify(self);
    [HttpRequest xsmGetOrderDetailWithOrderNo: self.orderNo result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        [MBProgressHUD hideProgress];
        if (statusCode == HttpResponseCodeSuccess) {
            for (NSDictionary * dic in anyobject) {
                Cigarette * cg = [Cigarette yy_modelWithDictionary: dic];
                [self.dataSource addObject: cg];
            }
            [self.tableView reloadData];
        }else {
            ShowError(msg);
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)buttonClick:(id)sender {
    if (self.btn1 == sender) {
        
    }else if (self.btn2 == sender) {
        
    } else if (self.btn3 == sender) {
        
    } else if (self.btn4 == sender) { //查询支付结果
//        [MBProgressHUD showBusy];
        @weakify(self);
        [HttpRequest xsmOrderPayResultWithOrderNo: self.model.coNum ref_id: self.model.custCode company_id:self.model.orgCode key:@"FD3BFAB4421CE0196203CD039AA8945D" service_code:@"037" version:@"1.0.0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
//            [MBProgressHUD hideProgress];
            @strongify(self);
            CigarettePayResultVC * vc = [[UIStoryboard storyboardWithName:@"CigaretteStoryboard" bundle:nil]instantiateViewControllerWithIdentifier:@"CigarettePayResultVC"];
            if (statusCode == HttpResponseCodeSuccess) {
                vc.success = YES;
            }
            vc.msg = msg;
            [self.navigationController pushViewController: vc animated: YES];
            
        }];
        
        
    }
}


#pragma mark -UITableViewDataSource-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CigaretteGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CigaretteGoodsCell"];
    cell.type = CigaretteGoodsTypeHistoyList;
    cell.cigartte = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end

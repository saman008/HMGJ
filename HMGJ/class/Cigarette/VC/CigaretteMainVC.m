//
//  CigaretteMainVC.m
//  Epay
//
//  Created by qzp on 2017/6/17.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigaretteMainVC.h"
#import "UINavigationBar+Awesome.h"
#import "UIViewController+Cloudox.h"
#import "CPersonInfo.h"
#import "XSMOrderCenterView.h"
#import "Cigarette.h"
#import "CigareteeHistoryOrderVC.h"
#import "HandleMoneyPasswordVC.h"
#import "CigarettePayResultVC.h"
#import "WebVC.h"


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

@interface CigaretteMainVC ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *centerView;

@property (nonatomic, strong) CPersonInfo * personInfo;
@property (nonatomic, strong) XSMOrderCenterView * orderCenterView1;
@property (nonatomic, strong) NSMutableArray<Cigarette *> * cigarettes;
@property (nonatomic, assign) BOOL hadCurrentOrder; //是否有当前订单
@property (nonatomic, copy) NSString *currentOrderNo;//当期订单的订单号，为空则没有当期订单
@property (nonatomic, strong) NSDictionary * currentDic; //当前订单




@end
//typedef NS_ENUM(NSInteger, HandleMoneyType) {
//    HandleMoneyTypeIn,
//    HandleMoneyTypeOut,
//    HandleMoneyTypePay
//};
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];

@implementation CigaretteMainVC

//手机新商盟界面

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
//    [self.navigationController setNavigationBarHidden: NO animated: animated];
//    self.navBarBgAlpha = @"0.0";
    
    
//    [UINavigationBar appearance].backgroundColor = [UIColor purpleColor];
    
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    
    //NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    _custId = [userDefault objectForKey:@"Q_CustID"];
//    _cell = [userDefault objectForKey:@"Q_Phone"];
//    _password = [userDefault objectForKey:@"Q_password"];
//    _orgCode = [userDefault objectForKey:@"Q_orgCode"];
//    
//    if (_orgCode == nil){
//        ShowError(@"登录过期，请重新登录");
//        return;
//    }
//    
//    if ([_password length] != 0){
//        
//    }
    //[self loginReFresh];
    ///=================
    [self getService];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navBarBgAlpha = @"1.0";
}
//切换账号
- (IBAction)rightClick:(id)sender {

    UIViewController * vc = [[UIStoryboard storyboardWithName:@"CigaretteStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"CigaretteLoginVC"];
    [self.navigationController pushViewController: vc animated: YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
     self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cigarettes = [NSMutableArray array];
 
    self.personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    
   
    
    self.label1.text = self.personInfo.custName;
    self.label2.text = [NSString stringWithFormat:@"%@(%@)",self.personInfo.shortName, self.personInfo.userId];
    self.label3.text = [NSString stringWithFormat:@"客户经理：%@",self.personInfo.slsmanName];
    
    NSString * orderBeginTime = [self.personInfo.orderBeginTime substringToIndex:5];
    NSString * orderEndTime = [self.personInfo.orderEndTime substringToIndex: 5];
    
    NSString * changeBeginTime = changeDate(@"yyyy.MM.dd", self.personInfo.beginDate, @"yyyyMMdd");
    NSString * changeEndTime = changeDate(@"yyyy.MM.dd",  self.personInfo.endDate, @"yyyyMMdd");
    
    NSString * startStr = [NSString stringWithFormat:@"%@ %@", changeBeginTime, orderBeginTime];
    NSString * endStr = [NSString stringWithFormat:@"%@ %@",changeEndTime, orderEndTime];
    self.timeLabel.text = [NSString stringWithFormat:@"订货时间：%@--%@", startStr, endStr];
    
    [self.timeView addBottomLineWithColor: [UIColor groupTableViewBackgroundColor]];
    
    
    [self getCurrentBills];
    
    ///刷新当前订单
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"k_updateCurrentOrder" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        for (UIView * view in self.centerView.subviews) {
            [view removeFromSuperview];
        }
        [self getCurrentBills];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取当前订单
- (void) getCurrentBills {
    [MBProgressHUD showBusy];
    @weakify(self);
    [HttpRequest xsmGetCurrentBillsWithCustId: self.personInfo.custCode result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        if (statusCode == HttpResponseCodeSuccess ) {
            if ([msg isEqualToString:@"请求失败"]) {
                [self getGoodsList];
                return ;
            }
            self.hadCurrentOrder = YES;
            self.currentDic = anyobject;
            self.currentOrderNo = anyobject[@"coNum"];
            [MBProgressHUD hideProgress];
            self.orderCenterView1.params = anyobject;
            [self.centerView addSubview: self.orderCenterView1];
            ///将当前订单缓存到本地
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSData * date = [NSKeyedArchiver archivedDataWithRootObject: anyobject[@"details"]];
            [userDefaults setObject: date forKey:@"cigaretteLocalOrder"];
            [userDefaults synchronize];
    
        }
        else { //获取当前订单失败 3001
            [self getGoodsList];
        }
    }];
    
}

- (void) getGoodsList {
    @weakify(self);
    [HttpRequest xsmGetBillsListWithCustId: self.personInfo.custCode result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        [MBProgressHUD hideProgress];
        @strongify(self);
        if (statusCode == HttpResponseCodeSuccess) {
            for (NSDictionary * dic in anyobject) {
                Cigarette * cigarette = [Cigarette yy_modelWithDictionary: dic];
                [self.cigarettes addObject: cigarette];
            }
            [self initGoodsScrollView];
        }else {
            ShowError(msg);
        }
        
    }];
    
}


- (void) initGoodsScrollView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:
                                 CGRectMake(8, 0, Main_Screen_Width-16, CGRectGetHeight(self.centerView.bounds))];
    [self.centerView addSubview: scrollView];
    
    CGFloat sW = scrollView.frame.size.width / 4.0;
    CGFloat sH = scrollView.frame.size.height / 2.0;
    
    NSInteger wNumber = ceilf(self.cigarettes.count / 2.0);
    
    for (NSInteger i = 0; i < self.cigarettes.count; i++) {
       UIView * view = [[UIView alloc] initWithFrame:
                           CGRectMake( i %wNumber * sW, i/ wNumber * sH ,sW,  sH)];
        [scrollView addSubview: view];
        
        UIView * iv = [[UIView alloc] initWithFrame:
                            CGRectMake(4, 8, sW-8, sH-40)];
        iv.layer.cornerRadius = 5;
        iv.layer.borderWidth = 1;
        iv.layer.borderColor = [UIColor blackColor].CGColor;
        [view addSubview: iv];
        NSString * urlStr = [NSString stringWithFormat:@"http://gz.xinshangmeng.com/xsm6/resource/ec/cgtpic/%@_middle_face.png",self.cigarettes[i].cgtCode];
        
        UIImageView * cIV = [[UIImageView alloc] initWithFrame:
                             CGRectMake(4, 4, CGRectGetWidth(iv.bounds)-8, CGRectGetHeight(iv.bounds)-8)];
        [cIV yy_setImageWithURL: [NSURL URLWithString: urlStr] placeholder: GetImage(@"no_pic")];
        cIV.contentMode = UIViewContentModeScaleAspectFit;
        [iv addSubview: cIV];
        UILabel * label = [[UILabel alloc] initWithFrame:
                           CGRectMake(0, CGRectGetMaxY(iv.frame) + 8, sW, 40-16)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor darkGrayColor];
        label.text = self.cigarettes[i].cgtName;
        [view addSubview: label];
        
    }
    scrollView.contentSize = CGSizeMake(ceilf(self.cigarettes.count / 8.0) * scrollView.bounds.size.width, 0);
    scrollView.showsVerticalScrollIndicator = scrollView.showsHorizontalScrollIndicator = NO;

    
}

- (IBAction)buttonClick:(id)sender {
    if (sender == self.btn2) {
        CigareteeHistoryOrderVC * vc = [CigareteeHistoryOrderVC new];
        vc.hadCurrentOrder = self.hadCurrentOrder;
        [self.navigationController pushViewController: vc  animated: YES];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushOrderVC"]) {
        UIViewController * vc = [segue destinationViewController];
        [vc setValue: self.currentOrderNo forKey: @"currentOrderNo"];
    }
}

#pragma mark-getter-
- (XSMOrderCenterView *)orderCenterView1 {
    if (!_orderCenterView1) {
        _orderCenterView1 = [[NSBundle mainBundle] loadNibNamed:@"XSMOrderCenterView" owner:self options:nil].firstObject;
        _orderCenterView1.frame = self.centerView.bounds;
        @weakify(self);
        _orderCenterView1.returnBlock = ^(XSMOrderReturnType type) {
            @strongify(self);
            if (type == XSMOrderReturnTypeDelete) {
                [MBProgressHUD showHUDAddedTo: self.view animated: YES];
                [HttpRequest  xsmDeleteOrderWithBillsNo: self.currentOrderNo result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    [MBProgressHUD hideHUDForView: self.view animated: YES];
                    if (statusCode == HttpResponseCodeSuccess) { //刷新页面
                        for (UIView * view in self.centerView.subviews) {
                            [view removeFromSuperview];
                        }
                        [self getCurrentBills];
                    } else {
                        ShowError(msg);
                    }
                }];
                
            }else if (type == XSMOrderReturnTypeModfiy) {// 修改
                [self performSegueWithIdentifier:@"pushOrderVC" sender:self];
            }else if (type == XSMOrderReturnTypePay) {//支付
                if (!XSM_ISEPAY) { //非易付用户
                    WebVC * vc = [[WebVC alloc] init];
                    vc.hideNav = YES;
                       CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
                    NSString * baseURL  =@"https://www.zdepay.com/front/mobile/register";
                    NSString * tempStr = @"{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}";
                    NSString * md5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", personInfo.compId,
                                         personInfo.custCode,
                                         @"6A198E59AF3DE87507A6E95D0620EAA5",
                                         personInfo.compName,
                                         personInfo.custName,
                                         @"1",
                                         tempStr];
//                    NSString * md5Str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", @"11510101",
//                                         @"510106101312",
//                                         @"6A198E59AF3DE87507A6E95D0620EAA5",
//                                         @"成都分公司",
//                                         @"成都市金牛区瑞林副食商店",
//                                         @"1",
//                                         tempStr];
             
                    

                    
                    NSString * lastMD5 = [md5Str md5];

                    NSString  *allurl = [NSString stringWithFormat:@"%@?company_id=%@&ref_id=%@&comp_name=%@&xsmflg=1&cust_name=%@&key=%@&industry_id=%@&MD5=%@",baseURL,
                                         personInfo.compId,
                                         personInfo.custCode,
                                         personInfo.compName,
                                         personInfo.custName,
                                         @"6A198E59AF3DE87507A6E95D0620EAA5",
                                         @"1",
                                         lastMD5];
                    
//                    NSString  *allurl = [NSString stringWithFormat:@"%@?company_id=%@&ref_id=%@&comp_name=%@&xsmflg=1&cust_name=%@&key=%@&industry_id=%@&MD5=%@",baseURL,
//                                        @"11510101",
//                                         @"510106101312",
//                                         @"成都分公司",
//                                         @"成都市金牛区瑞林副食商店",
//                                         @"6A198E59AF3DE87507A6E95D0620EAA5",
//                                         @"1",
//                                         lastMD5];
                 
//                    
//                    NSString * str = @"http://www.zdepay.com/front/mobile/register?company_id=11510101&ref_id=511000000002&comp_name=ABC&cust_name=ABC&key=6A198E59AF3DE87507A6E95D0620EAA5&industry_id=1&MD5=df526b4f142a0b821b922855f6a1393e";
            
                    vc.urlStr = allurl;
                    vc.type = WebTypeUrl;
                    vc.isPay = YES;
                    [self.navigationController pushViewController: vc animated: YES];
                    
                    
                    return ;
                }
                
                
                [MBProgressHUD showHUDAddedTo: self.view animated: YES];
                [HttpRequest xsmAllowForPhoneWithCoNum: self.currentOrderNo ordQtySum: self.currentDic[@"ordQtySum"] ordAmtSum:self.currentDic[@"ordAmtSum"] result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                    [MBProgressHUD hideHUDForView: self.view animated: YES];
                    //模拟测试
//                    anyobject = @{@"MSG":@"已业务系统校验不一致",@"CODE":@"504"}; //失败
//                     anyobject = @{@"MSG":@"成功",@"CODE":@"000"}; //成功
                    if (statusCode == HttpResponseCodeSuccess) {
                        if (![anyobject isKindOfClass:[NSNull class]]) {
                            NSInteger CODE = [anyobject[@"CODE"] integerValue];
                            if (CODE == 0) { //成功，可以支付
                                [self pay];
                            } else {
                                if (anyobject != nil) {
                                    ShowError(anyobject[@"MSG"]);
                                }
                                
                            }

                        }
                        
                    } else {
                        ShowError(@"失败");
                    }
                }];
            
            }else if (type == XSMOrderReturnTypeCheck) { //校验支付结果
                [self check];
            }
            
        };
        
        
    }
    return _orderCenterView1;
}

- (void) check {
    @weakify(self);
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    [HttpRequest xsmOrderPayResultWithOrderNo: self.currentOrderNo ref_id: personInfo.custCode company_id: personInfo.compId key:@"FD3BFAB4421CE0196203CD039AA8945D" service_code:@"037" version:@"1.0.0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
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

- (void) pay {
    @weakify(self);
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    NSInteger money = [self.currentDic[@"ordAmtSum"] floatValue] * 1000;
    [HttpRequest xsmPayBillCheckStateWithKey:@"" from_order_id:self.currentOrderNo  ref_id: personInfo.custCode bill_acct:[NSString stringWithFormat:@"%ld", (long)money] exp_date: self.currentDic[@"orderDate"] order_type: @"101" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        //模拟
//        statusCode = 200;
//        anyobject = @{@"result_code":@"000",@"bill_acct_id":@"7h7y23782837283"};
        
        QLog(@"%ldd-%@-%@",(long) (long)statusCode, msg, anyobject);
        if (statusCode == HttpResponseCodeSuccess) {
            NSInteger CODE = [anyobject[@"result_code"] integerValue];
            if (CODE == 0) { //成功，可以支付
                NSString * bill_acct_id = anyobject[@"bill_acct_id"];//流水号
                HandleMoneyPasswordVC * vc = [[HandleMoneyPasswordVC alloc]init];
                vc.type = HandleMoneyTypePay;
                vc.amount = money;
                vc.bill_acct_id = bill_acct_id;
                [self.navigationController pushViewController: vc animated: YES];
                
            } else {
                ShowError(anyobject[@"result_msg"]);
            }

        }
        else {
               ShowError(anyobject[@"result_msg"]);
        }
    }];
}

- (BOOL)navigationShouldPopOnBackButton{
    [self.navigationController popToRootViewControllerAnimated: YES];
    return NO;
}
- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                (CFStringRef)input,
                                                                                                NULL,
                                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                kCFStringEncodingUTF8));
    return outputStr;
}

//提供能够再次登录的数据 账号面膜机构公司等
- (void)getService {
    
    [HttpRequest getAvailable:^(NSInteger statusCode, NSString *msg, id anyobject) {
        NSLog(@"%@", anyobject);
        if (statusCode == HttpResponseCodeSuccess) {
         NSLog(@"%@", anyobject);
            NSData *jsonData = [anyobject dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            [HttpRequest aaxsmLoginWithPhone:dic result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        
        
            }];

            
            
        }else {
            //            ShowMessage(msg);
        }
        
    }];
    

    
    
}

//登录接口（为了刷新token时间限制）
- (void) loginReFresh{

    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString *cell1 = [userDefault objectForKey:@"Q_Phone"];
    NSString *custId1 = [userDefault objectForKey:@"Q_CustID"];
    NSString *password1 = [userDefault objectForKey:@"Q_password"];
    NSString *orgCode1 = [userDefault objectForKey:@"Q_orgCode"];
    
    
    [HttpRequest xsmLoginWithPhone: cell1 password: password1 custId: custId1 orgCode: orgCode1 result:^(NSInteger statusCode, NSString *msg, id anyobject) {

        if (statusCode == HttpResponseCodeSuccess) {
 
            
            
            //判断当前用户是否为易付用户  result_code =00001 不是易付用户,0000易付
            [HttpRequest xsmIsEpay: anyobject[@"custCode"] key: @"FD3BFAB4421CE0196203CD039AA8945D" service:@"035" version:@"1.0.0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {

                
                
            }];
            
            
        }else {
            //[MBProgressHUD hideHUDForView: self.view animated: YES];
            ShowError(msg);
        }
        
    }];

}


@end

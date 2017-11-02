//
//  CigaretteLoginVC.m
//  Epay
//
//  Created by qzp on 2017/6/17.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigaretteLoginVC.h"
#import "ValuePickerView.h"
#import "CigaretteMainVC.h"

#import "AppMacro.h"
#import "AppManager.h"

#import "NSObject+HUD.h"
#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>
#import "QZPToolHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"

@interface CigaretteLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSMutableArray * dataSourceName;
@property (nonatomic, assign) NSInteger currentIndex;



@property (nonatomic, strong) NSArray * secondDataSource;
@property (nonatomic, strong) NSMutableArray * secondDataSourceName;
@property (nonatomic, assign) NSInteger secondIndex;

@end
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];

//订烟登录界面
@implementation CigaretteLoginVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: NO animated: animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_memberidStr.length > 0){
        [self getService];
        //return;
    }
    
    // Do any additional setup after loading the view.
    self.dataSourceName = [NSMutableArray array];
    self.secondDataSourceName = [NSMutableArray array];
    self.pickerView = [[ValuePickerView alloc]init];
    

    
    
    [MBProgressHUD showBusy];
    @weakify(self);
    [HttpRequest getOrganizeById:@"0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        [MBProgressHUD hideProgress];
        if (statusCode==HttpResponseCodeSuccess) {
            self.dataSource = anyobject;
            [self.btn1 setTitle: [self.dataSource.firstObject objectForKey:@"orgName"] forState: UIControlStateNormal];
            for (NSDictionary * dic in anyobject) {
                [self.dataSourceName addObject: dic[@"orgName"]];
            }
            [self initSecond];
        }
    }];
    
//    self.nameTF.text = @"450122100179";
//    self.passwordTF.text = @"263510";
//    self.phoneTF.text = @"13788714266";
//    
//    self.nameTF.text = @"510112100055";
//    self.passwordTF.text = @"786786";
//510106101312 460986
//    450107121026 696960 
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    id custID = [userDefault objectForKey:@"Q_CustID"];
    id cell = [userDefault objectForKey:@"Q_Phone"];
    id password = [userDefault objectForKey:@"Q_password"];
    
    //存储memberid
    
//    [userDefault setObject: _memberidStr forKey: @"memberid"];
//    [userDefault synchronize];
    
    if (![custID isKindOfClass:[NSNull class]]) {
        self.nameTF.text = custID;
    }
    if (![cell isKindOfClass:[NSNull class]]) {
        self.phoneTF.text = cell;
    }
    if (![password isKindOfClass:[NSNull class]]) {
        self.passwordTF.text = password;
    }
    
//    [userDefault setObject: custId forKey: @"Q_CustID"];
//    [userDefault setObject: cell forKey: @"Q_Phone"];
//    [userDefault setObject: password forKey: @"Q_password"];
    

    /**
     450122100179	263510	13788714266
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initSecond {
    [MBProgressHUD showBusy];
    NSString * index = [self.dataSource[self.currentIndex] objectForKey:@"id"];
    NSLog(@"%ld", (long)self.currentIndex);
    NSLog(@"%@", index);
    @weakify(self);
    [HttpRequest getOrganizeById:index  result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        [MBProgressHUD hideProgress];
        if (statusCode==HttpResponseCodeSuccess) {
            [self.secondDataSourceName removeAllObjects];
            self.secondDataSource = anyobject;
            
            [self.btn2 setTitle: [self.secondDataSource.firstObject objectForKey:@"orgName"] forState: UIControlStateNormal];
            for (NSDictionary * dic in anyobject) {
                [self.secondDataSourceName addObject: dic[@"orgName"]];
                
            }
        }
    }];

}


- (IBAction)buttonClick:(id)sender {
    [self.view endEditing: YES];
    @weakify(self);
    if (sender == self.btn1) {
        
        self.pickerView.dataSource = self.dataSourceName;
        self.pickerView.pickerTitle = @"请选择机构";
        self.pickerView.valueDidSelect = ^(NSString *value) {
            @strongify(self);
            NSArray * stateArr = [value componentsSeparatedByString:@"/"];
            //self.currentIndex = [stateArr.lastObject integerValue]-1;
            [self.btn1 setTitle: stateArr[0] forState: UIControlStateNormal];
            
        };
        self.pickerView.valueDidSelect1 = ^(NSString *value){
            @strongify(self);
            self.currentIndex = [value integerValue]-1;
            NSLog(@"ld",(long)self.currentIndex);
            [self initSecond];
//            self.secondIndex = [value integerValue]-1;
//            NSLog(@"%ld", (long)self.secondIndex);
            
        };
        [self.pickerView show];
        
    }
    else if (sender == self.btn2) {
        self.pickerView.dataSource = self.secondDataSourceName;
        self.pickerView.pickerTitle = @"请选择公司";
        self.pickerView.valueDidSelect = ^(NSString *value) {
            @strongify(self);
            NSArray * stateArr = [value componentsSeparatedByString:@"/"];
            NSLog(@"%@", stateArr);
           // self.secondIndex = [stateArr.lastObject integerValue]-1;
            [self.btn2 setTitle: stateArr[0] forState: UIControlStateNormal];
       
           
        };
        self.pickerView.valueDidSelect1 = ^(NSString *value) {
             @strongify(self);
            self.secondIndex = [value integerValue]-1;
            NSLog(@"%ld", (long)self.secondIndex);
        };
        [self.pickerView show];

    
    }
    else if (sender == self.submitBtn) {
        
        
        [self aa];
    }
}

- (void)aa{
    NSString * custId = self.nameTF.text;
    NSString * cell = self.phoneTF.text;
    NSString * password = self.passwordTF.text;
    if (custId.length == 0) {
        ShowMessage(@"新商盟账号不能为空");
        return;
    }
    if (password.length == 0) {
        ShowMessage(@"新商盟密码不能为空");
        return;
    }
    //        custId = 510302102913;
    //        orgCode = 11510301;
    //        password = 402624;
    
    
    NSString * orgCode = [self.secondDataSource[self.secondIndex] objectForKey:@"orgCode"];//@"11510301";
    @weakify(self);
    [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    
    [HttpRequest xsmLoginWithPhone: cell password: password custId: custId orgCode: orgCode result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        
        @strongify(self);
        if (statusCode == HttpResponseCodeSuccess) {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject: anyobject];
            
            [userDefault removeObjectForKey:@"cigaretteList"]; //移除以前的烟品列表
            [userDefault removeObjectForKey:@"cigareetLimit"];//移除以前的烟品限量
            [userDefault removeObjectForKey:@"cigaretteLocalOrder"]; //移除本地缓存的订单
            
            [userDefault setObject:@"1" forKey:@"XSM_AUTOLOGIN"];//是否自动登录
            [userDefault setValue: data forKey: @"cigretteInfo"];
            [userDefault setObject: custId forKey: @"Q_CustID"];
            [userDefault setObject: cell forKey: @"Q_Phone"];
            [userDefault setObject: password forKey: @"Q_password"];
            [userDefault setObject: orgCode forKey: @"Q_orgCode"];
            [userDefault synchronize];
            
            //判断当前用户是否为易付用户  result_code =00001 不是易付用户,0000易付
            [HttpRequest xsmIsEpay: anyobject[@"custCode"] key: @"FD3BFAB4421CE0196203CD039AA8945D" service:@"035" version:@"1.0.0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                [MBProgressHUD hideHUDForView: self.view animated: YES];
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                
                [userDefaults setObject: anyobject[@"result_code"] forKey:@"result_code"];
                //test
                //                     [userDefaults setObject: @"1" forKey:@"result_code"];
                [userDefaults synchronize];
                CigaretteMainVC * mainVC = [[UIStoryboard storyboardWithName:@"CigaretteStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"CigaretteMainVC"];
                
                
                [self.navigationController pushViewController: mainVC animated: YES];
            }];
            
            
            
            
            
            
            
        }else {
            [MBProgressHUD hideHUDForView: self.view animated: YES];
            ShowError(msg);
        }
        
    }];
    
}
//提供能够再次登录的数据 账号面膜机构公司等
- (void)getService {
    
    [HttpRequest getAvailable:^(NSInteger statusCode, NSString *msg, id anyobject) {
        
        if (statusCode == HttpResponseCodeSuccess) {
           
            NSData *jsonData = [anyobject dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            [HttpRequest aaxsmLoginWithPhone:dic result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                
                if (statusCode == HttpResponseCodeSuccess) {
                    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                    NSData * data = [NSKeyedArchiver archivedDataWithRootObject: anyobject];
                    
                    [userDefault removeObjectForKey:@"cigaretteList"]; //移除以前的烟品列表
                    [userDefault removeObjectForKey:@"cigareetLimit"];//移除以前的烟品限量
                    [userDefault removeObjectForKey:@"cigaretteLocalOrder"]; //移除本地缓存的订单
                    
                    [userDefault setObject:@"1" forKey:@"XSM_AUTOLOGIN"];//是否自动登录
                    [userDefault setValue: data forKey: @"cigretteInfo"];
                    [userDefault synchronize];
                    
                    //判断当前用户是否为易付用户  result_code =00001 不是易付用户,0000易付
                    [HttpRequest xsmIsEpay: anyobject[@"custCode"] key: @"FD3BFAB4421CE0196203CD039AA8945D" service:@"035" version:@"1.0.0" result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                        [MBProgressHUD hideHUDForView: self.view animated: YES];
                        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                        
                        [userDefaults setObject: anyobject[@"result_code"] forKey:@"result_code"];
                        //test
                        //                     [userDefaults setObject: @"1" forKey:@"result_code"];
                        [userDefaults synchronize];
                        CigaretteMainVC * mainVC = [[UIStoryboard storyboardWithName:@"CigaretteStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"CigaretteMainVC"];
                        
                        
                        [self.navigationController pushViewController: mainVC animated: YES];
                    }];
                    
                    
                    
                }else {
                    [MBProgressHUD hideHUDForView: self.view animated: YES];
                    ShowError(msg);
                }
                
            }];
            
            
            
        }else {
            //            ShowMessage(msg);
        }
        
    }];
    
    
    
    
}
@end


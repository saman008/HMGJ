//
//  InMoneyPasswordVC.m
//  YLProject
//
//  Created by qzp on 2017/3/5.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "HandleMoneyPasswordVC.h"
#import "WalletVM.h"
#import "NSString+Hash.h"
//#import "FinshVC.h"

#import <YYWebImage/YYWebImage.h>
#import "AppMacro.h"
#import "NSObject+HUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <YYModel/YYModel.h>

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"


#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 45  //每一个输入框的高度
#define Screen_Width     [UIScreen mainScreen].bounds.size.width
#define Screen    [UIScreen mainScreen].bounds.size


@interface HandleMoneyPasswordVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic, strong) UIView * bView;
@property (nonatomic, strong) WalletVM * walletVM;

@end
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];
@implementation HandleMoneyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initializeUserInterface {
    if (self.type == HandleMoneyTypeIn) {
        self.title = @"转入";
    } else if(self.type == HandleMoneyTypeOut){
        self.title = @"转出";
    } else if (self.type == HandleMoneyTypePay) {
        self.title = @"支付";
    }
    self.view.backgroundColor = [UIColor colorWithRed: 247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    [self.bView addSubview:self.textField];
    
    [self.view addSubview: self.bView];

    [self initPwdTextField];
//    UILabel * titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"请输入支付密码进行身份验证";
//    titleLabel.frame = CGRectMake(0, 20, Main_Screen_Width, 30);
//    titleLabel.font = Font15;
//    titleLabel.textColor = [UIColor lightGrayColor];
//    [self.bView addSubview: titleLabel];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self.textField becomeFirstResponder];
    
//    self.walletVM.amount = self.amount;
    @weakify(self);
//    [MBProgressHUD showBusy];
//    [self.walletVM.rechargeCommand.executionSignals.flatten subscribeNext:^(NSArray * x) {
//        @strongify(self);
//        QLog(@"%@",x);
//        [MBProgressHUD hideProgress];
//        
////        UIViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HandleMoneyResultVC"];
////        [vc setValue: x forKey: @"resultArray"];
////        [vc setValue:[NSNumber numberWithInteger: 0] forKey:@"type"];
////        [self.navigationController pushViewController: vc animated: YES];
//    }];
    
//    [self.walletVM.cashoutCommand.executionSignals.flatten subscribeNext:^(NSArray * x) {
//        @strongify(self);
//        QLog(@"%@",x);
////        [LoadingView hideLoding];
//        [MBProgressHUD hideProgress];
//        UIViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HandleMoneyResultVC"];
//        [vc setValue: x forKey: @"resultArray"];
//        [vc setValue:[NSNumber numberWithInteger: 1] forKey:@"type"];
//        [self.navigationController pushViewController: vc animated: YES];
//    }];
}



- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (Screen_Width - 32) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, K_Field_Height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.bView addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.bView addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
        [self.view endEditing: YES];
//        [LoadingView showLoding];
        self.walletVM.passWord = [textField.text md5_32bit];
        if (self.type == HandleMoneyTypeIn) {
//            [self.walletVM.rechargeCommand execute: nil];
            [self moneyInOrOut: YES];
        } else if(self.type == HandleMoneyTypeOut){
            [self moneyInOrOut: NO];
        } else if (self.type == HandleMoneyTypePay) { //支付
            NSString * PW =  [textField.text md5_32bit];
            [HttpRequest xsmPayBillCheckWithKey:@"FD3BFAB4421CE0196203CD039AA8945D" bill_acct_id:self.bill_acct_id payword: PW result:^(NSInteger statusCode, NSString *msg, id anyobject) {
                if (statusCode == 0) {
                    ShowSuccess(msg);
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"k_updateCurrentOrder" object:nil];
                    [self.navigationController popViewControllerAnimated: YES];
                    
                }else {
                    ShowError(msg);
                }
            }];
        
        
        }
        

        
    }
}



- (void) moneyInOrOut:(BOOL) isIns {
//    NSDictionary * params = @{@"amount":[NSString stringWithFormat:@"%.2f",self.amount],
//                              @"passWord": self.textField.text ,
//                         };
//    NSString * jsonStr = [Epay dicToJson: params];
//    @weakify(self);
//    NSString * isIn = @"pay.acount.cashin";
//    if (!isIns) {
//        isIn = @"pay.acount.cashout";
//    }
//    
//    [HttpRequest paymentTransactionWithCategory: isIn dataJson: jsonStr transactionNo:@"12222" sign: isIn result:^(NSInteger statusCode, NSString *msg, id anyobject, id sign) {
//        @strongify(self);
//        QLog(@"%ld-%@-%@-%@", (long)statusCode, msg, anyobject, sign);
//        if (statusCode == HttpResponseCodeSuccess) {
//            FinshVC * vc = [[UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil ] instantiateViewControllerWithIdentifier:@"FinshVC"];
//            vc.type = FinshTypeMoney;
//            [self.navigationController pushViewController: vc animated: YES];
//            
//        }else {
//            ShowError(msg);
//        }
//    }];
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(16, 55, Screen_Width - 32, K_Field_Height)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.layer.cornerRadius = 5;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIView *)bView {
    if (!_bView) {
        _bView = [[UIView alloc] initWithFrame:  CGRectMake(0, 70, Screen.width, 150)];
        _bView.backgroundColor = [UIColor colorWithRed: 247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    return _bView;
}
- (WalletVM *)walletVM {
    if (!_walletVM) {
        _walletVM = [[WalletVM alloc] init];
    }
    return _walletVM;
}
@end

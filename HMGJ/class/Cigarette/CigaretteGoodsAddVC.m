//
//  CigaretteGoodsAddVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigaretteGoodsAddVC.h"

@interface CigaretteGoodsAddVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *lostBtn;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@end

@implementation CigaretteGoodsAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.numberTF.text = [NSString stringWithFormat:@"%ld",(long)self.number];
    self.numberTF.delegate = self;

    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.number = [self.numberTF.text integerValue];
            [self changeTF];
        });
 
    }];
}

- (void)setCigarette:(Cigarette *)cigarette {
    _cigarette = cigarette;

    
    NSString * text = @"取消收藏";
    if ([cigarette.isFav isEqualToString:@"0"]) {
        text = @"收藏";
        dispatch_async(dispatch_get_main_queue(), ^{
                [self.subBtn setTitle: @"收藏" forState: UIControlStateNormal];
        });


    }else {
        text = @"取消收藏";
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.subBtn setTitle: @"取消收藏" forState: UIControlStateNormal];
        });
  
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.numberTF.text = [NSString stringWithFormat:@"%ld", (long)self.number];
         self.numberLabel.text = [NSString stringWithFormat:@"限量：%@", self.limitDic[@"qtyLmt"]];
    });
    
   


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
    if (sender == self.subBtn) {
        if ([self.cigarette.isFav isEqualToString:@"0"]) {
              [self collect];
        }else {
            [self collectCancel];
        }
    
    }
    else if (sender == self.lostBtn) { // -
        self.number --;
        if (self.number < 0) {
            self.number = 0;
        }
        [self changeTF];
    
    }
    else if (sender == self.addBtn) { // +
        self.number++;
        [self changeTF];
    }
    
}

- (void) changeTF {
    
    if (self.number > [self.limitDic[@"qtyLmt"] integerValue]) {
        self.number  = [self.limitDic[@"qtyLmt"] integerValue];
    }
    
    self.numberTF.text = [NSString stringWithFormat:@"%ld", (long)self.number];
    
    if (self.numberChange) {
        self.numberChange(self.number);
    }
    
}

///收藏
-(void) collect {
    NSDictionary * params = @{
                              @"brdType":self.cigarette.brdType?:@"0",
                              @"cgtBrandName":self.cigarette.cgtBrandName?:@"0",
                              @"cgtCartonCode": self.cigarette.cgtCartonCode?:@"0",
                              @"cgtCode": self.cigarette.cgtCode?:@"0",
                              @"cgtName":self.cigarette.cgtName?:@"0",
                              @"cgtPacketCode": self.cigarette.cgtPacketCode?:@"0",
                              @"cgtTypeName": self.cigarette.cgtTypeName?:@"0",
                              @"coCont": self.cigarette.coCont?:@"0",
                              @"gasNicotine": self.cigarette.gasNictine?:@"0",
                              @"isAdvise": self.cigarette.isAdvise?:@"0",
                              @"isCoLmt":self.cigarette.isCoLmt?:@"0",
                              @"isCoMulti":self.cigarette.isCoMulti?:@"0",
                              @"isFav":[NSNumber numberWithBool: YES],
                              @"isImported": self.cigarette.isImported?:@"0",
                              @"isMulti": self.cigarette.isMulti?:@"0",
                              @"isShort": self.cigarette.isShort?:@"0",
                              @"isTask": self.cigarette.isTask?:@"0",
                              @"mfrId": self.cigarette.mfrId?:@"0",
                              @"price": self.cigarette.price?:@"0",
                              @"promote": self.cigarette.promote?:@"0",
                              @"qtyLmt": self.cigarette.qtyLmt?:@"0",
                              @"reqQtyMax": self.cigarette.reqQtyMax?:@"0",
                              @"rtlPrice": self.cigarette.rtlPrice?:@"0",
                              @"shortCode": self.cigarette.shortCode?:@"0",
                              @"umSaleName": self.cigarette.umSaleName?:@"0"
                              };
     CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    @weakify(self);
    [MBProgressHUD showBusy];
    [HttpBaseRequest requestWithURL:@"baccy/baccy/favorite" params: @{@"custId":personInfo.custCode,@"details":@[params]} method: MethodTypePOST completion:^(NSInteger code, NSString *msg, id anyobject) {
        [MBProgressHUD hideProgress];
        @strongify(self);
        if(code == HttpResponseCodeSuccess) {
            [ self.subBtn setTitle:@"取消收藏" forState: UIControlStateNormal];
            self.cigarette.isFav = @"1";
             [AppManager changeCigarette: params];
            if(self.collectChange) {
                self.collectChange(YES);
            }
        }else {
            ShowError(msg);
        }
    }];

}
//取消收藏
- (void) collectCancel {
    NSDictionary * params = @{
                              @"brdType":self.cigarette.brdType?:@"0",
                              @"cgtBrandName":self.cigarette.cgtBrandName?:@"0",
                              @"cgtCartonCode": self.cigarette.cgtCartonCode?:@"0",
                              @"cgtCode": self.cigarette.cgtCode?:@"0",
                              @"cgtName":self.cigarette.cgtName?:@"0",
                              @"cgtPacketCode": self.cigarette.cgtPacketCode?:@"0",
                              @"cgtTypeName": self.cigarette.cgtTypeName?:@"0",
                              @"coCont": self.cigarette.coCont?:@"0",
                              @"gasNicotine": self.cigarette.gasNictine?:@"0",
                              @"isAdvise": self.cigarette.isAdvise?:@"0",
                              @"isCoLmt":self.cigarette.isCoLmt?:@"0",
                              @"isCoMulti":self.cigarette.isCoMulti?:@"0",
                              @"isFav":[NSNumber numberWithBool: NO],
                              @"isImported": self.cigarette.isImported?:@"0",
                              @"isMulti": self.cigarette.isMulti?:@"0",
                              @"isShort": self.cigarette.isShort?:@"0",
                              @"isTask": self.cigarette.isTask?:@"0",
                              @"mfrId": self.cigarette.mfrId?:@"0",
                              @"price": self.cigarette.price?:@"0",
                              @"promote": self.cigarette.promote?:@"0",
                              @"qtyLmt": self.cigarette.qtyLmt?:@"0",
                              @"reqQtyMax": self.cigarette.reqQtyMax?:@"0",
                              @"rtlPrice": self.cigarette.rtlPrice?:@"0",
                              @"shortCode": self.cigarette.shortCode?:@"0",
                              @"umSaleName": self.cigarette.umSaleName?:@"0"
                              };
    CPersonInfo * personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    @weakify(self);
    [MBProgressHUD showBusy];
    [HttpBaseRequest requestWithURL:@"baccy/baccy/favorite" params: @{@"custId":personInfo.custCode,@"cgtCode": self.cigarette.cgtCode} method: MethodTypeGET completion:^(NSInteger code, NSString *msg, id anyobject) {
        [MBProgressHUD hideProgress];
        @strongify(self);
        if(code == HttpResponseCodeSuccess) {
            [ self.subBtn setTitle:@"收藏" forState: UIControlStateNormal];
            self.cigarette.isFav = @"0";
            [AppManager changeCigarette: params];
            if(self.collectChange) {
                self.collectChange(NO);
            }
        }else {
            ShowError(msg);
        }
    }];


}

@end

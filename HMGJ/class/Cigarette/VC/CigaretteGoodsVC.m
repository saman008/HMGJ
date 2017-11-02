//
//  CigaretteGoodsVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//
/*
 1.调用 http://admin.inlee.com.cn:9980/baccy/baccy/merchant/limit?custId=510106101312
 2.点开单个烟品调用  http://admin.inlee.com.cn:9980/baccy/baccy/cigarette/limit?custId=510106101312&orderDate=20170626&cgtCodes=6901028124348
 3.收藏 http://admin.inlee.com.cn:9980/baccy/baccy/favorite
 4.取消收藏  http://admin.inlee.com.cn:9980/baccy/baccy/favorite?custId=510106101312&cgtCode=6901028124348
 
 
 */
#import "CigaretteGoodsVC.h"
#import "CigaretteGoodsCell.h"
#import "Cigarette.h"
#import "CPersonInfo.h"
#import "JWFolders.h"
#import "CigaretteGoodsAddVC.h"
#import "CigartteGoodsResultVC.h"


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
#import "AppManager.h"
@interface CigaretteGoodsVC () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CPersonInfo * personInfo;
@property (nonatomic, strong) CigaretteGoodsAddVC * addVC;
@property (nonatomic, strong) NSMutableArray <Cigarette *> * dataSource;
@property (nonatomic, strong) UISearchController * searchController;
@property (nonatomic, strong) CigartteGoodsResultVC * resultVC;

@property (nonatomic, strong) NSMutableArray * limits; //限量
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

//CO_QTY_LMT  订单单次限量  MON_QTY_LMT客户月限量 MON_QTY_ORD客户月已订购量
@property (nonatomic, strong) NSDictionary * orderLimits; ///订单限量

@property (nonatomic, strong) NSArray * submitLimitArray;//提交判断

@end
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowMessage(msg) {\
[[SMProgressHUD shareInstancetype]showAlertWithTitle: @"提示" message: [NSString stringWithFormat:@"\n%@\n",msg] delegate: nil alertStyle: SMProgressHUDAlertViewStyleDefault cancelButtonTitle: @"确定"\
otherButtonTitles: @[] ];\
}\


#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
#define ShowSuccess(msg)  [[SMProgressHUD shareInstancetype] showTip: msg];

@implementation CigaretteGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.limits = [NSMutableArray array];
    self.personInfo = [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 80;
    self.tableView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    [self.tableView registerNib: CigaretteGoodsCell.nib forCellReuseIdentifier:@"CigaretteGoodsCell"];
    [self initData];
    [self setupSearchBar];
    [self getorgparm];
}
//-(BOOL)prefersStatusBarHidden
//
//{
//    
//    return NO;// 返回YES表示隐藏，返回NO表示显示
//    
//}
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData {
    [MBProgressHUD showBusy];
    @weakify(self);
    NSComparator cmptr = ^(Cigarette * obj1, Cigarette * obj2){
        if ([obj1.price floatValue] > [obj2.price floatValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1.price floatValue] < [obj2.price floatValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    
    [HttpRequest xsmGetBillsListWithCustId: self.personInfo.custCode result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        [MBProgressHUD hideProgress];
        @strongify(self);
        if (statusCode == HttpResponseCodeSuccess) {
            for (NSDictionary * dic in anyobject) {
                Cigarette * cigarette = [Cigarette yy_modelWithDictionary: dic];
                [self.dataSource addObject: cigarette];
            }
            //排序
            NSArray * array = [self.dataSource sortedArrayUsingComparator: cmptr];
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray: array];
            [self handleLocalOrder];
            [self calculatingdata];
            [self.tableView reloadData];
        }else {
            ShowError(msg);
        }
        
    }];
    
    [HttpRequest xsmGetLimt:^(NSInteger statusCode, NSString *msg, id anyobject) {
        QLog(@"%ld-%@-%@", (long)statusCode, msg, anyobject);
        @strongify(self);
        if (statusCode == HttpResponseCodeSuccess) {
            self.orderLimits = anyobject;
            self.label5.text = [NSString stringWithFormat:@"配额：%@", anyobject[@"coQtyLmt"]];
        }
    }];

}

///获取提交判断
- (void) getorgparm {
    if(self.submitLimitArray.count == 0) {
        
        [HttpRequest xsmgetOrgarm:^(NSInteger statusCode, NSString *msg, id anyobject) {
            
            if (statusCode == HttpResponseCodeSuccess) {
                self.submitLimitArray = anyobject;
            }
            else {
                ShowError(msg);
            }
        }];
    
    }
    

}

///整合本地订单和当前订单
- (void) handleLocalOrder {
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
     id cigaretteLocalOrder = [NSKeyedUnarchiver unarchiveObjectWithData: [userdefaults objectForKey:@"cigaretteLocalOrder"]];
    if ([cigaretteLocalOrder isKindOfClass:[NSArray class]]) {
        NSArray * cigTempArray = (NSArray *) cigaretteLocalOrder;
        if (cigTempArray.count > 0) {
            for (NSDictionary  * dic in cigTempArray) {
                NSString * ordQty = dic[@"ordQty"];
                NSString * cgtCode = dic[@"cgtCode"];
                for (NSInteger i =0;i< self.dataSource.count;i++) {
                    Cigarette * cg = self.dataSource[i];
                    if ([cg.cgtCode isEqualToString: cgtCode]) {
                        cg.ordQty = [NSString stringWithFormat:@"%@",ordQty];
                        [self.dataSource replaceObjectAtIndex: i withObject: cg];
                    }
                }
                
            }
            
            
        }
        
        
    }

}
- (void) calculatingdata {
    NSInteger guige = 0;
    NSInteger orderNumber = 0;
    NSInteger normal = 0;
    NSInteger notNormal = 0;
    float totle = 0;
    
    for (Cigarette * cg  in self.dataSource) {
        if ([cg.ordQty integerValue] != 0) { //规格 == 中类
            guige++;
            orderNumber += [cg.ordQty integerValue]; // 定量
            float p = [cg.price floatValue];
            totle += (p *  [cg.ordQty integerValue]);
            
        }
    }
    
    self.label1.text = [NSString stringWithFormat:@"规格：%ld", (long)guige];
    self.label2.text = [NSString stringWithFormat:@"订量：%ld", (long)orderNumber ];
    self.label3.text = [NSString stringWithFormat:@"常规：%ld", (long)orderNumber ];
    self.label4.text = [NSString stringWithFormat:@"异型：%ld", (long)orderNumber];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", totle];
    

}

- (void) setupSearchBar {
    self.resultVC = [[CigartteGoodsResultVC alloc] init];
    self.resultVC.vc = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController: _resultVC];
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"请输入烟品名称";
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleDefault;
    [self.searchController.searchBar setContentMode: UIViewContentModeLeft];
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    @weakify(self);
    self.resultVC.clickRetultDataSource = ^(Cigarette *cg) {
        @strongify(self);
        [self.searchController setActive: NO];
        for (NSInteger i = 0; i< self.dataSource.count; i++) {
            if ([cg.cgtCode isEqualToString: self.dataSource[i].cgtCode]) { //滚动到选择的那行
                CGFloat to = MIN(self.tableView.contentSize.height, i * self.tableView.rowHeight);
                [self.tableView setContentOffset: CGPointMake(0, to)];
                return ;
            }
        }
        
        
    };
    
    for (UIView * view in self.searchController.searchBar.subviews ) {
        for (UIView * subView in view.subviews) {
            if ([subView isKindOfClass: [UITextField class]]) {
                subView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            }
        }
    }
    self.searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchController.searchBar.tintColor =  UIColorFromRGB(0x999999);
    self.searchController.searchBar.barTintColor = [UIColor whiteColor];
    self.searchController.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchController.searchBar.layer.borderWidth = 1;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    
    [self.view addSubview: self.searchController.searchBar];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) {
        UIView * view = [self.searchController.view.subviews lastObject];
        UIView * whiteView = [[UIView alloc] initWithFrame: CGRectMake(0, 0,  Main_Screen_Width, 20)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [view addSubview: whiteView];
    }
    
}
- (IBAction)buttonClick:(id)sender {
    if (sender == self.submitBtn) { //提交
        NSInteger order = [[self.label2.text substringFromIndex:3] integerValue];
        if (order == 0) {
            ShowMessage(@"订购量为0,不能提交");
            return;
        }
        
        if (self.submitLimitArray.count == 0) {
            [HttpRequest xsmgetOrgarm:^(NSInteger statusCode, NSString *msg, id anyobject) {
                if (statusCode == HttpResponseCodeSuccess) {
                    self.submitLimitArray = anyobject;
                    [self submitPostData];
                }
                else {
                    ShowError(msg);
                }

        }];


        } else {
            [self submitPostData];
        }
    
    }
}

- (void) submitPostData {
    // 参与订单总量限制的卷烟订购量合计最小值 CO_LMT_MIN_QTY
    NSInteger order = [[self.label2.text substringFromIndex:3] integerValue]; //订购量
    
    NSString * CO_MIN_QTY = [self getParm_valueByName: @"CO_MIN_QTY"];
    if (order < [CO_MIN_QTY integerValue]) {
        NSString * msg =[NSString stringWithFormat:@"订单最小订购量为:%@", CO_MIN_QTY];
        ShowMessage(msg);
        return;
    }
    //不满足倍数时的提示信息
    NSString * alerttext = [self getParm_valueByName: @"CO_QTY_MULTIP"];
    
    NSString * CO_QTY_MULTI = [self getParm_valueByName:@"CO_QTY_MULTI"];
    if (order % [CO_QTY_MULTI integerValue] != 0) {
        ShowMessage(alerttext);
        return;
    }
    
    
    NSMutableArray * postArray = [NSMutableArray array];
    for (Cigarette * cg in self.dataSource) {
        if ([cg.ordQty integerValue] > 0) {
            float money = [cg.ordQty integerValue] * [cg.price floatValue];
            cg.ordAmt = [NSString stringWithFormat:@"%.2f", money];
            NSDictionary * dic = [cg yy_modelToJSONObject];
            [postArray addObject: dic];
        }

    }
    
    
    if (self.currentOrderNo.length == 0) { //没有当期订单 。则执行提交操作
        [MBProgressHUD showHUDAddedTo: self.view animated: YES];
        [HttpRequest xsmSubmitOrder: postArray result:^(NSInteger statusCode, NSString *msg, id anyobject) {
            [MBProgressHUD hideHUDForView: self.view animated: YES];
            if (statusCode == HttpResponseCodeSuccess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"k_updateCurrentOrder" object:nil]; //刷新当前订单
                [self.navigationController popViewControllerAnimated: YES];
            } else {
                ShowError(msg);
            }
        }];
        
        
    }else { //有当期订单执行更新操作
        
        [MBProgressHUD showHUDAddedTo:self.view animated: YES];
        [HttpRequest xsmUpdateOrderWithCoNum: self.currentOrderNo details: postArray result:^(NSInteger statusCode, NSString *msg, id anyobject) {
            [MBProgressHUD hideHUDForView: self.view animated: YES];
            if (statusCode == HttpResponseCodeSuccess) {
                ShowSuccess(msg);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"k_updateCurrentOrder" object:nil]; //刷新当前订单
                [self.navigationController popViewControllerAnimated: YES];
            }
            else {
                ShowError(msg);
            }
        }];
        
    }
}




- (id) getParm_valueByName:(NSString *) name {
    for (NSInteger i = 0; i< self.submitLimitArray.count; i++) {
        NSDictionary * tempDic = self.submitLimitArray[i];
        if ([tempDic[@"parm_NAME"] isEqualToString: name]) {
            return  tempDic[@"parm_VALUE"];
        }
    }
    return @"";
}


#pragma mark -UITableViewDataSource-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CigaretteGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CigaretteGoodsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = CigaretteGoodsTypeGoodsList;
    cell.cigartte = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self);
    Cigarette * cg = self.dataSource[indexPath.row];
    NSInteger limit = [AppManager getCigaretteLimitByCgCode: cg.cgtCode];
    if (limit == -1) { //本地暂未缓存
        [MBProgressHUD showHUDAddedTo: self.view animated: YES];
        [HttpRequest xsmGetSingleLimtByCgtCodes: cg.cgtCode result:^(NSInteger statusCode, NSString *msg, id anyobject) {
            @strongify(self);
            [MBProgressHUD hideHUDForView: self.view  animated: YES];
            if (statusCode == HttpResponseCodeSuccess) {
                //本地缓存限量
                NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                id cigareetLimit = [NSKeyedUnarchiver unarchiveObjectWithData: [userDefault objectForKey:@"cigareetLimit"]];
                NSMutableArray * oldArray = [NSMutableArray array];
                if ([cigareetLimit isKindOfClass:[NSArray class]]) {
                    [oldArray addObjectsFromArray: cigareetLimit];
                }
                //////////处理如果anyobject为空就不让他处理让他重新登录//////////
                NSArray * tempArr = (NSArray *) anyobject;
                if (tempArr.count == 0){
                    ShowError(@"登录过期，请重新登录");
                    return;
                }
                [oldArray addObject: anyobject[0]];
                NSData * data = [NSKeyedArchiver archivedDataWithRootObject:  oldArray];
                [userDefault setObject: data forKey: @"cigareetLimit"];
                [userDefault synchronize];
                
                [self showVIew: indexPath result: anyobject[0]];
            }else {
                ShowError(msg);
            }
        }];
    } else {
        [self showVIew: indexPath result: @{@"qtyLmt":[NSString stringWithFormat:@"%ld",(long)limit]}];
    }

}
//展开选择数量视图
//MARK 修改订货的tableviewcell的选择偏移量 出现取消收藏与否
- (void) showVIew:(NSIndexPath *) indexPath result:(NSDictionary *) anyobject {
    CGRect rect=[self.tableView rectForRowAtIndexPath:indexPath];
    float y=rect.origin.y-[self.tableView contentOffset].y+64 + 80;
    if(y>self.view.frame.size.height)
    {
        y=self.view.frame.size.height;
    }
    CGPoint openPoint=CGPointMake(0, y);
    
    self.addVC.number = [self.dataSource[indexPath.row].ordQty integerValue];
    self.addVC.limitDic = anyobject;
    self.addVC.cigarette = self.dataSource[indexPath.row];
    __weak typeof(self) weakSelf = self;
    self.addVC.collectChange = ^(BOOL isFav) { //刷新当前缓存数据
        Cigarette * cg = weakSelf.dataSource[indexPath.row];
        cg.isFav = [NSString stringWithFormat:@"%d", isFav];
        [weakSelf.dataSource replaceObjectAtIndex: indexPath.row withObject: cg];
    };
    self.addVC.numberChange = ^(NSInteger index) {
        Cigarette * tempCg = weakSelf.dataSource[indexPath.row];
        tempCg.ordQty = [NSString stringWithFormat:@"%ld",(long)index];
        [weakSelf.dataSource replaceObjectAtIndex: indexPath.row withObject: tempCg];
        
        NSDictionary * tempDic = [tempCg yy_modelToJSONObject];
        [tempDic setValue: [NSString stringWithFormat:@"%ld", (long)index] forKey: @"ordQty"];
        [AppManager chnangeShopCigarette: tempDic];
        ///实时刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf calculatingdata];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
        });

        
    };
    
    JWFolders *folder = [JWFolders folder];
    folder.contentView = self.addVC.view;
    folder.containerView = self.view;
    folder.position = openPoint;
    folder.direction = JWFoldersOpenDirectionDown;
    folder.contentBackgroundColor = [UIColor whiteColor];
    folder.shadowsEnabled = NO;
    folder.darkensBackground = NO;
    folder.showsNotch = YES;
    [folder open];
}

#pragma mark -UISearchBarDelegate-
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}
#pragma mark - UISearchResultUpdating-
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString * searchText = searchController.searchBar.text;
    NSMutableArray * resultArray = [NSMutableArray array];
    for (Cigarette * cg in self.dataSource) {
        NSString * txt = [self URLDecodedString: cg.cgtName];
        NSRange range = [txt rangeOfString:searchText];
        
        NSLog(@"%@", NSStringFromRange(range));
        if (range.length > 0) {
            [resultArray addObject: cg];
        }
    }
    self.resultVC.resultArray = resultArray;
    if (self.resultVC.resultArray.count == 0) {
        
    } else {
        
    }
    [self.resultVC.tableView reloadData];
    
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.placeholder = @"请输入烟品名称";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.placeholder = @"搜索";
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    return  YES;
}

//#pragma mark--UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (id searchbuttons in [[self.searchController.searchBar subviews][0] subviews]) { //只需在此处修改即可
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            if (searchText.length > 0) {
                [cancelButton setTitleColor:UIColorFromRGB(0x29a8ec) forState:UIControlStateNormal];
            } else {
                [cancelButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            }
        }
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    for (id searchbuttons in [[self.searchController.searchBar subviews][0] subviews]) { //只需在此处修改即可
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitleColor: NavColor forState:UIControlStateNormal];
        }
    }
}



-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

- (CigaretteGoodsAddVC *)addVC {
    if (!_addVC) {
        _addVC = [[CigaretteGoodsAddVC alloc] init];
    }
    return _addVC;
}

@end

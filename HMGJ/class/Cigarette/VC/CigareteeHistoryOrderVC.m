//
//  CigareteeHistoryOrderVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigareteeHistoryOrderVC.h"
#import "OdrerListModel.h"
#import "OrderListCell.h"
#import "OrderDetailVC.h"


#import <YYModel/YYModel.h>
#import "QZPToolHeader.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
@interface CigareteeHistoryOrderVC ()
@property (nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation CigareteeHistoryOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.title = @"我的订单";
    [self initData];
    
    [self initializeUserInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initializeUserInterface {
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:OrderListCell.nib forCellReuseIdentifier: @"OrderListCell"];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}


- (void) initData {
    @weakify(self);
    [HttpRequest xsmGetOrder:^(NSInteger statusCode, NSString *msg, id anyobject) {
        @strongify(self);
        NSLog(@"错误所在");
        NSLog(@"%ld", (long)statusCode);
        if (statusCode == HttpResponseCodeSuccess) {
            
            NSLog(@"%@", anyobject);
            //////////处理如果anyobject为空就不让他处理让他重新登录//////////
            NSArray * tempArr = (NSArray *) anyobject;
            if (tempArr.count == 0){
                ShowError(@"登录过期，请重新登录");
                return;
            }
            NSArray * resArra = [[tempArr reverseObjectEnumerator] allObjects];
      
                NSMutableArray * secondArray = [NSMutableArray array];
                for (NSInteger i = 0; i < resArra.count; i++) {
                    OdrerListModel * listModel = [OdrerListModel yy_modelWithDictionary: resArra[i]];
                    if (self.hadCurrentOrder) { //有当前订单
                        if (i == 0) {
                            [self.dataSource addObject:@[listModel]];
                        }
                        else {
                            [secondArray addObject: listModel];
                        }
                    } else {
                        [secondArray addObject: listModel];
                    }
                }
                [self.dataSource addObject: secondArray];
            
            [self.tableView reloadData];
       
            
        }else {
            ShowError(msg);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell" forIndexPath: indexPath];
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label = [[UILabel alloc] initWithFrame:
                       CGRectMake(0, 0, Main_Screen_Width, 30)];
    label.backgroundColor = [UIColor whiteColor];
    UILabel * btl = [[UILabel alloc] initWithFrame:
                     CGRectMake(0, 29, Main_Screen_Width, 1)];
    btl.backgroundColor = [UIColor redColor];
    [label addSubview: btl];
    
    if (self.dataSource.count == 1) {
        label.text = @"    历史订单";
    }
    else if (self.dataSource.count == 2) {
        if (section == 0) {
            label.text = @"    当期订单";
        }else {
            label.text = @"    历史订单";
        }
    }
    
    
    return label;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.dataSource.count == 2  && section == 0) {
        return 8;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailVC * vc = [[UIStoryboard storyboardWithName:@"CigaretteStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderDetailVC"];
    vc.orderNo = [(OdrerListModel *)(self.dataSource[indexPath.section][indexPath.row]) coNum];
    vc.model = self.dataSource[indexPath.section][indexPath.row];
    if (self.dataSource.count == 2 && indexPath.section == 0) {
        vc.isCurrentOrder = YES;
    }
    
    [self.navigationController pushViewController: vc animated: YES];
}

@end

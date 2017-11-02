//
//  CigareteeCollectVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigareteeCollectVC.h"
#import "CigaretteGoodsCell.h"
#import "CPersonInfo.h"
#import "Cigarette.h"
#import "QZPToolHeader.h"
#import <YYModel/YYModel.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "HttpRequest.h"
#import <MJRefresh/MJRefresh.h>
#import "SMProgressHUD.h"
#define CigaretteInfo   [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"cigretteInfo"]]
#define ShowError(msg)  [[SMProgressHUD shareInstancetype] showErrorTip: msg]
@interface CigareteeCollectVC ()

@property (nonatomic, strong) NSMutableArray<Cigarette *> * dataSource;

@end

@implementation CigareteeCollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    
    self.title = @"我的收藏夹";
    [self initData];

    
    [self.tableView registerNib: CigaretteGoodsCell.nib forCellReuseIdentifier: @"CigaretteGoodsCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 80;
    
}


- (void)initData {
    CPersonInfo * personInfo =   [CPersonInfo yy_modelWithDictionary: CigaretteInfo];
    @weakify(self);
    [HttpRequest xsmFavoriteWithCustId: personInfo.custCode  result:^(NSInteger statusCode, NSString *msg, id anyobject) {
        NSLog(@"========");
        NSLog(@"%@", anyobject);
        if (anyobject == NULL){
            NSLog(@"111111");
            ShowError(@"网络错误");
            return;
        }
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        NSLog(@"错误所在");
        NSLog(@"%ld", (long)statusCode);
        if (statusCode == HttpResponseCodeSuccess) {
            [self.dataSource removeAllObjects];
            //////////处理如果anyobject为空就不让他处理让他重新登录//////////
            NSArray * tempArr = (NSArray *) anyobject;
            if (tempArr.count == 0){
                ShowError(@"登录过期，请重新登录");
                return;
            }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CigaretteGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier: @"CigaretteGoodsCell" forIndexPath: indexPath];
    cell.type = CigaretteGoodsTypeCollect;
    cell.cigartte = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

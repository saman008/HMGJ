//
//  CigartteGoodsResultVC.h
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cigarette.h"
@interface CigartteGoodsResultVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) UIViewController * vc;
@property (nonatomic, strong) NSArray* resultArray;
@property (nonatomic, copy) void (^clickRetultDataSource)(Cigarette * cg);
@end

//
//  CigartteGoodsResultVC.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigartteGoodsResultVC.h"
#import "CigaretteGoodsCell.h"
#import "CigaretteGoodsAddVC.h"
#import "JWFolders.h"


#import "AppMacro.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "QZPToolHeader.h"
@interface CigartteGoodsResultVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CigaretteGoodsAddVC * addVC;
@end

@implementation CigartteGoodsResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 80;
    [self.tableView registerNib: CigaretteGoodsCell.nib forCellReuseIdentifier:@"CigaretteGoodsCell"];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 36)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 16, 100, 16)];
        label.text = @"搜索结果";
        label.textColor = DEF_Gray_Text9Color;
        label.font = [UIFont systemFontOfSize:15.0f];
        
        [view addSubview:label];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 36, Main_Screen_Width - 1, 1)];
        lineView.backgroundColor = DEF_BackGroundColor;
        [view addSubview:lineView];
        
        view;
    });
    
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_tableView];
    
    self.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });

}
- (instancetype)init {
    if (self = [super init]) {
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.navigationController.navigationBar.translucent = NO;
        self.title = @"关键字搜索";
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CigaretteGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CigaretteGoodsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = CigaretteGoodsTypeGoodsList;
    cell.cigartte = self.resultArray[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGRect rect=[tableView rectForRowAtIndexPath:indexPath];
//    float y=rect.origin.y-[tableView contentOffset].y+64 + 60;
//    if(y>self.view.frame.size.height)
//    {
//        y=self.view.frame.size.height;
//    }
//    CGPoint openPoint=CGPointMake(0, y);
//    
//    JWFolders *folder = [JWFolders folder];
//    folder.contentView = self.addVC.view;
//    folder.containerView = self.view;
//    folder.position = openPoint;
//    folder.direction = JWFoldersOpenDirectionDown;
//    folder.contentBackgroundColor = [UIColor whiteColor];
//    folder.shadowsEnabled = NO;
//    folder.darkensBackground = NO;
//    folder.showsNotch = YES;
//    [folder open];
    if (self.clickRetultDataSource) {
        self.clickRetultDataSource(self.resultArray[indexPath.row]);
    }
    
}

- (CigaretteGoodsAddVC *)addVC {
    if (!_addVC) {
        _addVC = [[CigaretteGoodsAddVC alloc] init];
    }
    return _addVC;
}

@end

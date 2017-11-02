//
//  TabBaseTableViewController.swift
//  FunLife
//
//  Created by Forever on 2017/6/20.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit
import MJRefresh


class TabBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 对导航栏下面那条线做处理
        //self.navigationBar.clipsToBounds = alpha == 0.0;
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        //self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
        //设置导航栏标题颜色
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.init(white: 0.871, alpha: 1.000)
        shadow.shadowOffset = CGSize(width: 0.5, height: 0.5)
        shadow.shadowBlurRadius = 20
        let attributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSShadowAttributeName:shadow]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = attributes
    }

    

}

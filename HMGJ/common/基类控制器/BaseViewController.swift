//
//  BaseViewController.swift
//  FunLife
//
//  Created by Forever on 2017/6/20.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit

import MJRefresh

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = RColor
        self.navigationController?.navigationBar.barTintColor = rColor
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        //self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

}

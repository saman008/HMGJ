//
//  shopListliushuiViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/29.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh

class shopListliushuiViewController: BaseViewController{

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    
    var tableView:UITableView!
    
    var page = 1
    var moneyStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "店铺列表"
        
        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "shoplistliushuiTableViewCell", bundle: nil), forCellReuseIdentifier: "shoplistliushuiTableViewCell")
       
        self.view.addSubview(tableView)
        
        self.getNetData()
        self.tableView.rowHeight = 100
        
    }

    
}
////MARK: - 刷新空间
//extension shopListliushuiViewController{
//    
//    func addRefreshView(){
//        
//        //1.添加header
//        self.tableView?.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
//            
//            self.page = 1
//            self.getNetData(page: self.page)
//            
//        })
//        
//        self.tableView?.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
//            
//            
//            self.getNetData(page: self.page)
//            
//        })
//    }
//}


extension shopListliushuiViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoplistliushuiTableViewCell", for: indexPath) as! shoplistliushuiTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? storelistModel
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.dataArray[indexPath.row] as? storelistModel
        
        if let shopqr = model?.shopQRCode{
            
            if moneyStr == "1"{
                

                let setleVC = settleAcountViewController()
                
                setleVC.hidesBottomBarWhenPushed = true
                setleVC.shopQRCodeStr = shopqr
                self.navigationController?.pushViewController(setleVC, animated: true)
                
            }else{
                let myVC = Running_waterViewController()
                
                myVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(myVC, animated: true)
            }
            
        }
        

        
    }
    
    
}


extension shopListliushuiViewController{
    
    //获取店铺列表
    func getNetData(){
        
        NetworkTools.requestData(type: .get, URLString: storelistSTR + "?masterMId=\(memberId)&shopQRCode=", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            
            if let dataStr = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: storelistModel.self, json: dataStr){
                    self.dataArray.removeAllObjects()
                    self.dataArray.addObjects(from: modelArray)
                    
                    self.tableView?.reloadData()
                    
                    
                }
                
            }
        }) { (error) in
            
            
        }
        
        
    }
}

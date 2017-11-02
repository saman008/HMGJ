//
//  withdrawalDetailViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/31.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh

class withdrawalDetailViewController: BaseViewController {

    var settleAcountStr = ""
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    var tableView:UITableView!
    

    
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "记录"
        
       self.billsGetNetData(page: self.page)
        
        tableView = UITableView(frame: self.view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "withmonyDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "withmonyDetailTableViewCell")
        
        self.addRefreshView()
        
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }

    
}

extension withdrawalDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "withmonyDetailTableViewCell", for: indexPath) as! withmonyDetailTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? widthCheckModel
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let model = self.dataArray[indexPath.row] as? widthCheckModel
        
        //http 是否为空
        
        
    }
    
    
}

//MARK: - 刷新空间
extension withdrawalDetailViewController{
    
    func addRefreshView(){
        
        //1.添加header
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.page = 1
            self.billsGetNetData(page: self.page)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            
            self.billsGetNetData(page: self.page)
            
        })
    }
}


extension withdrawalDetailViewController{
    
    //交易记录
    func billsGetNetData(page:Int){
        
        NetworkTools.requestData(type: .post, URLString: reportapplySTR , parameters: ["service":"pay.acount.bills","version":"1.0","memberId":memberId,"settleAcount":settleAcountStr,"showCount":"10","currentPage":"\(page)"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if self.tableView.mj_header.isRefreshing(){
                self.dataArray.removeAllObjects()
            }
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let data2Array = dataDict["list"] as? NSArray{
                    if let modelArray = NSArray.yy_modelArray(with: widthCheckModel.self, json: data2Array){
                        DispatchQueue.main.async(execute: {
                            
                            self.dataArray.addObjects(from: modelArray)
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.mj_footer.endRefreshing()
                            self.tableView.reloadData()
                            self.page += 1
                            
                        })
                    }
                }
                

                
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
}

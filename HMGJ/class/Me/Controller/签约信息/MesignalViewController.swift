//
//  MesignalViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/10/20.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MesignalViewController: BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        
        
        return NSMutableArray()
    }()
    
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "签约信息"
        
        tableView = UITableView.init(frame: self.view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "MySignTableViewCell", bundle: nil), forCellReuseIdentifier: "MySignTableViewCell")
        tableView.register(UINib.init(nibName: "MysignhtmlTableViewCell", bundle: nil), forCellReuseIdentifier: "MysignhtmlTableViewCell")
        
        tableView.tableFooterView = UIView()
        
        self.view.addSubview(tableView)
        
        self.getNetData()
        
    }


    

}


extension MesignalViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.dataArray[indexPath.row] as? sigingingModel
        

        if let typeStr = model?.type{

            if typeStr == "1"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "MysignhtmlTableViewCell", for: indexPath) as? MysignhtmlTableViewCell
                
                cell?.model = model
                
               return cell!
            }
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySignTableViewCell", for: indexPath) as? MySignTableViewCell
        cell?.model = model
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let model = self.dataArray[indexPath.row] as? sigingingModel
        let webVC = AllWebViewController()
        if let typeStr = model?.type{
            
            if typeStr == "1"{
                
                webVC.url = model!.value
                
                self.navigationController?.pushViewController(webVC, animated: true)
                
            }
            
        }
        
    }
    
    
}


extension MesignalViewController{
    
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.agreement","version":"1.0"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            
            self.dataArray.removeAllObjects()
            if let dataDict = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: sigingingModel.self, json: dataDict){
                    
                    self.dataArray.addObjects(from: modelArray)
                    
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
}

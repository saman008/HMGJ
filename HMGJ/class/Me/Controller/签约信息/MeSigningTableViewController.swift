//
//  MeSigningTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeSigningTableViewController: TabBaseTableViewController {

    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "签约信息"
        
        self.getNetData()
        
    }

    

}
extension MeSigningTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //serviceAgreement_dzzh 上海银行电子账户服务协议
        //serviceAgreement_yelc 上海银行余额理财服务协议
        //we_chat_agreement 上海银行微信支付服务协议
        let webVC = AllWebViewController()
        
//        let path = Bundle.main.bundlePath
//        let baseURL = NSURL.fileURL(withPath: path)
        
        if indexPath.row == 4{
            
            let htmlPath = Bundle.main.path(forResource: "serviceAgreement_dzzh", ofType: "html")
            
            webVC.url = htmlPath!
            
            self.navigationController?.pushViewController(webVC, animated: true)
        }else if indexPath.row == 5{
            
            let htmlPath = Bundle.main.path(forResource: "serviceAgreement_yelc", ofType: "html")
            
            webVC.url = htmlPath!
            
            self.navigationController?.pushViewController(webVC, animated: true)
        }else if indexPath.row == 6{
            
            let htmlPath = Bundle.main.path(forResource: "we_chat_agreement", ofType: "html")
            
            webVC.url = htmlPath!
            
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    
}
extension MeSigningTableViewController{
    
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

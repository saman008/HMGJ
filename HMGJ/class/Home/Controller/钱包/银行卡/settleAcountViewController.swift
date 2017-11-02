//
//  settleAcountViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/30.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire

class settleAcountViewController: UIViewController {

    
    var shopQRCodeStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.getNetData()
    }

    

}
extension settleAcountViewController{
    //        //获取e账户列表
    func getNetData(){
        
        Alamofire.request(acountapplySTR, method: .post, parameters: ["service":"pay.acount.list","version":"1.0","memberId":memberId], encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            print(data)
            if let json = data.result.value as? AnyObject{
                if let codeStr = json.value(forKey: "code") as? String{
                    
                    //有e账户列表 直接申请
                    if codeStr == "0000"{
                        
                        
                        if let data1Array = json.value(forKey: "data") as? NSArray{
                            
                            if let i = data1Array[0] as? NSDictionary{
                                
                                if let settleAcountStr = i["settleAcount"] as? String{
                                    DispatchQueue.main.async(execute: {
                                        
                                        self.openGetNetData(setle: settleAcountStr)
                                        
                                    })
                                }
                                
                            }
                            
                        }
                        
                        
                        
                    }else{
                        //没有e账户列表就去注册
                        let ALLBankVC = UIStoryboard.init(name: "AllBankAcountCreatSB", bundle: nil).instantiateViewController(withIdentifier: "ALLBankVC") as! ALLBankTableViewController
                        
                        //shopQRCode
                        
                        ALLBankVC.shopQRCodeStr = self.shopQRCodeStr
                        ALLBankVC.hidesBottomBarWhenPushed = true
                        
                        self.navigationController?.pushViewController(ALLBankVC, animated: true)
                    }
                    
                }
            }
            

            
        }
        
        
    }
    //E账户开通
    
    func openGetNetData(setle:String){
        print(["service":"pay.acount.create","version":"1.0","memberId":memberId,"settleAcount":setle,"shopNo":shopQRCodeStr])
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.create","version":"1.0","memberId":memberId,"settleAcount":setle,"shopNo":shopQRCodeStr], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            let suVC = UIStoryboard.init(name: "PublicSuccessSB", bundle: nil).instantiateViewController(withIdentifier: "PublicSuccessVC") as! PublicSuccessTableViewController
            
            suVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(suVC, animated: true)
            print("绑定成功界面")
        }) { (error) in
            
            
        }
        
    }
    
    
    
}

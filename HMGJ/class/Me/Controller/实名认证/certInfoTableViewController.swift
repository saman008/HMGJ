//
//  certInfoTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class certInfoTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var cardTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "认证信息"
        
        
        self.rightBtn()
    }
    //右上角
    func rightBtn(){
        let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        
        rightBtn.setTitle("确定", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){

        self.achiveGetNetData(idcard: self.cardTextfield.text!)
        
        
        
    }
    

}

extension certInfoTableViewController{
    
    //验证身份
    func achiveGetNetData(idcard:String){
        
        if idcard.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入身份证号码", T: self)
            
            return
        }
        if !idCardPublicManager.isTrueIDNumber(text: idcard){
            
            ToolManger.defaultShow(Str: "请输入正确的身份证号码", T: self)
            return
        }
        
        
        NetworkTools.requestData(type: .post, URLString: authcheckCertSTR, parameters: ["mid":memberId,"idCard":idcard], encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let state = dataDict["state"] as? String{
                    
                    if state == "0"{
                        let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
                        self.navigationController?.pushViewController(certVC, animated: true)
                    }else if state == "1"{
                        ToolManger.defaultShow(Str: "实名认证通过", T: self)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                            let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
                            certVC.okornoStr = "1"
                            self.navigationController?.pushViewController(certVC, animated: true)
                        })
                    }
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
}

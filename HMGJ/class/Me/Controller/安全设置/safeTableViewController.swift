//
//  safeTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/20.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class safeTableViewController: TabBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "安全设置"
        
        self.tableView.tableFooterView = UIView()
        
        self.view.backgroundColor = UIColor.gray
        
        
    }
    
    
    
    
    
}

extension safeTableViewController{
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //实名认证
        if indexPath.row == 0{
            
            let alertController = UIAlertController(title: "查询实名验证是否通过",
                                                    message: "请输入你的身份证号码", preferredStyle: .alert)
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "请输入你的身份证号"
            }
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                //也可以用下标的形式获取textField let login = alertController.textFields![0]
                let login = alertController.textFields!.first!
                
                self.achiveGetNetData(idcard: login.text!)
                
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
        //修改密码
        if indexPath.row == 1{
            
            
            //            let changePasswordVC = UIStoryboard(name: "changePasswordSB", bundle: nil).instantiateViewController(withIdentifier: "changePasswordVC") as! changePasswordTableViewController
            //
            //
            //            self.navigationController?.pushViewController(changePasswordVC, animated: true)
            
        }
        
        
        //拨打电话
        if indexPath.row == 2{
            
            let alert = UIAlertController(title: "客服电话", message: "请拨打:4001006501", preferredStyle: UIAlertControllerStyle.alert)
            
            
            let okAction = UIAlertAction(title: "立即拨号", style: UIAlertActionStyle.default, handler: { (Action) in
                
                let callWebView = UIWebView()
                callWebView.loadRequest(URLRequest.init(url: URL.init(string: "tel:4001006501")!))
                
                self.view.addSubview(callWebView)
                
            })
            
            let noAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okAction)
            
            alert.addAction(noAction)
            
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
        
        
    }
    
    
}

extension safeTableViewController{
    
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
        
        
        NetworkTools.requestData(type: .post, URLString: authcheckCertSTR, parameters: ["mid":memberId,"idCard":idcard], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
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



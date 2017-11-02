//
//  forgetTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/19.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire

class forgetTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var surePasswordTextField: UITextField!
    
    @IBOutlet weak var reginTextField: UITextField!
    
    @IBOutlet weak var reginBtn: UIButton!
    
    @IBOutlet weak var okBtn: UIButton!
    
    var random = ""
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            
            reginBtn.setTitle("\(newValue)S", for: UIControlState.normal)
            if newValue <= 0 {
                
                reginBtn.setTitle("重获验证码", for: UIControlState.normal)
                isCounting = false
                self.okBtn.isUserInteractionEnabled = false
                self.okBtn.backgroundColor = UIColor.gray
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                reginBtn.backgroundColor = UIColor.gray
                //verfiBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                
                reginBtn.backgroundColor = UIColor.gray
            }
            
            reginBtn.isEnabled = !newValue
        }
    }
    
    var The_navigation_barV:The_navigation_barViewView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //自定义导航栏
        The_navigation_barV = UINib.init(nibName: "The_navigation_barView", bundle: nil).instantiate(withOwner: self, options: nil).first as! The_navigation_barViewView
        The_navigation_barV.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 64)
        
        The_navigation_barV.backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        The_navigation_barV.titleLabel.text = "忘记密码"
        
        
        //发送验证码
        reginBtn.addTarget(self, action: #selector(verAction), for: UIControlEvents.touchUpInside)
        
        
        //确认按钮
        okBtn.backgroundColor = UIColor.gray
        //okBtn.isUserInteractionEnabled = false
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
    }
    
    func okAction(){
        
        
        getNetData3()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        UIApplication.shared.keyWindow?.addSubview(The_navigation_barV)
        
    }
    //返回按钮
    func backAction(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.The_navigation_barV.removeFromSuperview()
        
    }
    
    //发送验证码
    func verAction(){
        
        getNetData2()
        
    }
    
    
}

//所有网络请求
extension forgetTableViewController{
    
    
//    //验证是否是新用户
//    func getNetData1(){
//        
//        if phoneTextField.text?.characters.count != 11{
//            
//            ToolManger.defaultShow(Str: "请输入正确的账号", T: self)
//            
//            return
//            
//        }
//        let index_str2 = (phoneTextField.text! as NSString).substring(to: 1)
//        
//        if index_str2 != "1"{
//            
//            ToolManger.defaultShow(Str: "请输入正确的账号", T: self)
//            
//            return
//        }
//        
//        if index_str2 == "9"{
//            
//            ToolManger.defaultShow(Str: "请联系你的店组来修改密码", T: self)
//            
//            return
//        }
//        //        let aa = ["account":"\(phoneTextField.text!)"]
//        let bb = RegisterBodySTR + "?account=\(phoneTextField.text!)"
//        Alamofire.request(bb, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (data) in
//            self.isCounting = true
//            if let json = data.result.value as? AnyObject{
//                if let code = json.value(forKey: "code") as? String{
//                    if code == "1003"{
//                        self.okBtn.backgroundColor = UIColor.red
//                        self.okBtn.isUserInteractionEnabled = true
//                        
//                        self.getNetData2()
//                    }else if code == "1002"{
//                        if let msg = json.value(forKey: "msg") as? String{
//                            ToolManger.defaultShow(Str: msg, T: self)
//                        }
//                    }
//                }
//            }
//            
//        }
//        
//    }
    //点击获取验证码
    
    func getNetData2(){
        //     usergetRandomSTR 
        
        if phoneTextField.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的账号", T: self)
            
            return
            
        }
        NetworkTools.requestData(type: .get, URLString: usergetRandomSTR + "?account=\(phoneTextField.text!)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.isCounting = true
            
            self.okBtn.isUserInteractionEnabled = true
            self.okBtn.backgroundColor = UIColor.red
            
        }) { (error) in
            
            
        }
        
    }
    
    
    func getNetData3(){
        
        
        if reginTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            return
        }
        
        if passwordTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请输入密码", T: self)
            return
        }
        
        if surePasswordTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请再次输入密码", T: self)
            return
        }
        
        if passwordTextField.text! != surePasswordTextField.text!{
            ToolManger.defaultShow(Str: "两次密码输入不一致", T: self)
            return
        }
        

        
        if (passwordTextField.text?.characters.count)! < 6 || (passwordTextField.text?.characters.count)! > 12{
            
            
            ToolManger.defaultShow(Str: "请输入正确的密码", T: self)
            
            return
        }
        NetworkTools.requestData(type: .get, URLString: randgetRandomSTR+"?key=\(phoneTextField.text!)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.random = (data as! NSDictionary)["data"] as! String
            
            DispatchQueue.main.async(execute: {
                self.getNetData4()
                
            })
            
        }) { (error) in
            
            
        }
        
        
    }
    
    
    //通过
    
    func getNetData4(){
        //AES(MD5(password) + random)
        let passStr = passwordTextField.text!.MD5() + random
        
        let para = aesEncryptString(passStr, self.random)
        
        NetworkTools.requestData(type: .post, URLString: forgetPasswordSTR, parameters: ["account":phoneTextField.text!,"challenge":reginTextField.text!,"password":para!], encoding: "post", T: self, ShowStr: true, finishedCallback: { (json) in
            
            ToolManger.defaultShow(Str: "成功", T: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                self.dismiss(animated: true, completion: nil)
                
            })
            
        }) { (eoor) in
            
            
        }
        
        
    }
    
    
}

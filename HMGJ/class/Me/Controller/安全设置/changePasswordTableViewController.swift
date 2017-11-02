//
//  changePasswordTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/20.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class changePasswordTableViewController: TabBaseTableViewController {

    @IBOutlet weak var riginBtn: UIButton!
    
    @IBOutlet weak var VerificationTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var oldTextField: UITextField!
    
    
    @IBOutlet weak var okBtn: UIButton!
    
    var random = ""
    
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            
            riginBtn.setTitle("\(newValue)S", for: UIControlState.normal)
            if newValue <= 0 {
                
                riginBtn.setTitle("重获验证码", for: UIControlState.normal)
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
                riginBtn.backgroundColor = UIColor.gray
                //verfiBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                
                riginBtn.backgroundColor = UIColor.red
            }
            
            riginBtn.isEnabled = !newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "修改登录密码"
        
        //验证码
        riginBtn.addTarget(self, action: #selector(riginAction), for: UIControlEvents.touchUpInside)
        //确定
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
        okBtn.isUserInteractionEnabled = false
        okBtn.backgroundColor = UIColor.gray
        
    }
    
    func riginAction(){
        
        self.getNetData2()
        
    }
    func okAction(){
        
        self.getNetData3()
    }
    
    
    
}

extension changePasswordTableViewController{
    
    //点击获取验证码
    
    func getNetData2(){
        //        print(RegisterRandomSTR)
        
        NetworkTools.requestData(type: .get, URLString: usergetRandomSTR + "?account=\(PhoneNumber)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.isCounting = true
            
            self.okBtn.isUserInteractionEnabled = true
            self.okBtn.backgroundColor = UIColor.red
            
        }) { (error) in
            
            
        }
        
        
    }
    //获取加密随机码
    //获取随机数 利用随机数进行加密

    
    //后台验证
    
    
    
    func getNetData3(){
        
        if VerificationTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            return
        }
        
        if passwordTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请输入密码", T: self)
            return
        }

        
        if oldTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请再次输入密码", T: self)
            return
        }
        
        if passwordTextField.text! != oldTextField.text!{
            ToolManger.defaultShow(Str: "两次密码输入不一致", T: self)
            return
        }
        if (passwordTextField.text?.characters.count)! < 6 || (passwordTextField.text?.characters.count)! > 12{
            
            
            ToolManger.defaultShow(Str: "请输入正确的密码", T: self)
            
            return
        }

        NetworkTools.requestData(type: .get, URLString:  randgetRandomSTR+"?key=\(PhoneNumber)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
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
        //let para = LanAES.aes256_encrypt(self.random, encrypttext: passStr)
        //        let para1 = LanAES.aes256_encrypt("6194", encrypttext: "e10adc3949ba59abbe56e057f20f883e6194")
        //        let aa = LanAES.aes256_decrypt("6194", decrypttext: para1)
        //
        //        let dd = "123456".MD5() + "0000000000000000"
        
        
        if passwordTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请输入密码", T: self)
            return
        }
        
        if oldTextField.text?.characters.count == 0{
            ToolManger.defaultShow(Str: "请再次输入密码", T: self)
            return
        }
        
        if passwordTextField.text! != oldTextField.text!{
            ToolManger.defaultShow(Str: "两次密码输入不一致", T: self)
            return
        }
        
        if VerificationTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            return
        }
        print(resetPasswordSTR)
        print(["mid":memberId,"challenge":VerificationTextField.text!,"password":para!])
        
        NetworkTools.requestData(type: .post, URLString: resetPasswordSTR, parameters: ["mid":memberId,"password":para!,"challenge":VerificationTextField.text!], encoding: "post", T: self, ShowStr: true, finishedCallback: { (json) in
            
            
            let sucVC = UIStoryboard.init(name: "PublicSuccessSB", bundle: nil).instantiateViewController(withIdentifier: "PublicSuccessVC") as! PublicSuccessTableViewController
            
            
            self.navigationController?.pushViewController(sucVC, animated: true)
            
        }) { (eoor) in
            
            self.getNetData4()
        }
        
        
    }
    
    
    
}
    

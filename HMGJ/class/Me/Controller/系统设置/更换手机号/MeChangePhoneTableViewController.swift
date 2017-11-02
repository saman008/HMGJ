//
//  MeChangePhoneTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeChangePhoneTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var oldPhoneLabel: UILabel!
    
    
    @IBOutlet weak var newPhoneTextField: UITextField!
    
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var codeBtn: UIButton!
    
     let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
    
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            
            codeBtn.setTitle("\(newValue)S", for: UIControlState.normal)
            if newValue <= 0 {
                
                codeBtn.setTitle("重获验证码", for: UIControlState.normal)
                isCounting = false
                self.rightBtn.isUserInteractionEnabled = false
                self.rightBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                codeBtn.backgroundColor = UIColor.gray
                //verfiBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                
                codeBtn.backgroundColor = UIColor.red
            }
            
            codeBtn.isEnabled = !newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "更换手机号"
        self.rightAction()
        
        codeBtn.addTarget(self, action: #selector(codeAction), for: UIControlEvents.touchUpInside)
        
        rightBtn.isUserInteractionEnabled = false
        rightBtn.setTitleColor(UIColor.gray, for: UIControlState.normal)
        
        self.oldPhoneLabel.text = PhoneNumber
        
        
    }
    
    func codeAction(){
        
        self.codeGetNetData()
        
    }
    

    //右上角
    func rightAction(){
       
        
        rightBtn.setTitle("完成", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){
        
        self.getNetData()
        
    }
}

extension MeChangePhoneTableViewController{
    //点击获取验证码
    func codeGetNetData(){
        //        print(RegisterRandomSTR)
        if newPhoneTextField.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的手机号码", T: self)
            
            return
        }
        NetworkTools.requestData(type: .get, URLString: usergetRandomSTR + "?account=\(self.newPhoneTextField.text!)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.isCounting = true
            self.rightBtn.isUserInteractionEnabled = true
            self.rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
            
        }) { (error) in
            
            
        }
        
    }
    
    
    func getNetData(){
        
        if newPhoneTextField.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的手机号码", T: self)
            
            return
        }
        
        if self.codeTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            
            return
        }
        
        
        NetworkTools.requestData(type: .post, URLString:  userresetAccountSTR, parameters: ["mid":memberId,"newAccount":self.newPhoneTextField.text!,"challenge":self.codeTextField.text!], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            //两句代码删除所有userdefault缓存
            let appDomain = Bundle.main.bundleIdentifier
            
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            
            //增加这句 广告页面不自动跳转
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
            
            let logon = UIStoryboard.init(name: "LoginSB", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginTableViewController
            self.view!.window?.rootViewController = logon
            
            self.present(logon, animated: true, completion: nil)
        }) { (error) in
            
            
        }
        
    }
    
}

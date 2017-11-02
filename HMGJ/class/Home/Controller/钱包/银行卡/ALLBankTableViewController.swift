//
//  ALLBankTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class ALLBankTableViewController: TabBaseTableViewController {

    @IBOutlet weak var personLabel: UILabel!
    
    @IBOutlet weak var bankCardNoTextField: UITextField!
    
    
    @IBOutlet weak var reservedPhoneTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField1: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var assginBtn: UIButton!
    
    @IBOutlet weak var webBtn: UIButton!
    
    
    @IBOutlet weak var okBtn: UIButton!
    var personNameStr = ""
    var shopQRCodeStr = ""
    
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }
    
    
    var countdownTimer: Timer?
    var remainingSeconds: Int = 0 {
        willSet {
            
            assginBtn.setTitle("\(newValue)S", for: UIControlState.normal)
            if newValue <= 0 {
                
                assginBtn.setTitle("重获验证码", for: UIControlState.normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime(timer:)), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                assginBtn.backgroundColor = UIColor.gray
                //verfiBtn.backgroundColor = UIColor.grayColor()
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                
                assginBtn.backgroundColor = UIColor.red
            }
            
            assginBtn.isEnabled = !newValue
        }
    }
    //是否阅读
    var readStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "绑卡"
        
      self.personLabel.text = realNameID
        
        self.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        self.assginBtn.addTarget(self, action: #selector(assginAction), for: UIControlEvents.touchUpInside)
        self.webBtn.addTarget(self, action: #selector(webAction), for: UIControlEvents.touchUpInside)
        
        okBtn.isUserInteractionEnabled = false
        okBtn.backgroundColor = UIColor.gray
        
        self.tableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.readStr == "1"{
            
            //高亮状态
            self.webBtn.setImage(UIImage.init(named: "单选 (1)"), for: UIControlState.normal)
            
        }
        
    }
    
    
    //是否阅读
    func webAction(){
        self.readStr = "1"
        let mesignVC = MesignalViewController()
        
        mesignVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mesignVC, animated: true)
        
    }
    
    //验证码按钮点击
    func assginAction(){
        
        self.challengesendGetNetData()
        
    }
    
    
    func okAction(){
        self.openGetNetData()
    }

    //ALLBankVC
}

extension ALLBankTableViewController{
    
    
    //获取验证码
    func challengesendGetNetData(){
        
        if reservedPhoneTextfield.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入手机号码", T: self)
            
            return
            
        }
        
        NetworkTools.requestData(type: .post, URLString: challengesendSTR, parameters: ["source":"payment","cellphone":reservedPhoneTextfield.text!], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.isCounting = true
            self.okBtn.isUserInteractionEnabled = true
            self.okBtn.backgroundColor = UIColor.red
            print(data)
        }) { (error) in
            
            
        }
        
    }
    
    
    //E账户开通
    
    func openGetNetData(){
        
        if bankCardNoTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入持卡人本人的银行卡号", T: self)
            
            return
        }
        
        if reservedPhoneTextfield.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入银行卡对应的手机号码", T: self)
            
            return
        }
        
        if passWordTextField.text != passwordTextField1.text{
            
            ToolManger.defaultShow(Str: "两次输入的支付密码要一致", T: self)
            
            return
        }
        
        if passWordTextField.text?.characters.count != 6{
            
            ToolManger.defaultShow(Str: "请输入6位的密码", T: self)
            
            return
        }
        
        if codeTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            
            return
        }
        
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.create","version":"1.0","memberId":memberId,"passWord":passWordTextField.text!,"reservedPhone":reservedPhoneTextfield.text!,"bankCardNo":bankCardNoTextField.text!,"shopNo":shopQRCodeID,"code":codeTextField.text!], encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
            print(data)
            
            let succsVC = UIStoryboard.init(name: "PublicSuccessSB", bundle: nil).instantiateViewController(withIdentifier: "PublicSuccessVC") as! PublicSuccessTableViewController
            
            succsVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(succsVC, animated: true)
            
        }) { (error) in
            
            
        }
        
    }
    
    
}

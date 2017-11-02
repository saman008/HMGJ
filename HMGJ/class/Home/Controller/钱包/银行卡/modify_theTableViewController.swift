//
//  modify_theTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/31.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class modify_theTableViewController: UITableViewController {
    @IBOutlet weak var realNameLabel: UILabel!

    @IBOutlet weak var newBankCardNoLabel: UITextField!
    @IBOutlet weak var newReservedPhoneLabel: UITextField!
    
    @IBOutlet weak var codeLabel: UITextField!
    @IBOutlet weak var codeBtn: UIButton!
    
    @IBOutlet weak var webBtn: UIButton!
    
    @IBOutlet weak var okBtn: UIButton!
    var settleAcountStr = ""
    
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


        self.title = "换绑银行卡"
        self.realNameLabel.text = realNameID
        
        self.codeBtn.addTarget(self, action: #selector(codeAction), for: UIControlEvents.touchUpInside)
        self.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
        self.okBtn.isUserInteractionEnabled = false
        self.okBtn.backgroundColor = UIColor.gray
        
        
    }
    func codeAction(){
        self.challengesendGetNetData()
    }
    
    func okAction(){
        
        self.getNetData()
        
    }

    

}
extension modify_theTableViewController{
    
    //获取验证码
    func challengesendGetNetData(){
        
        if newReservedPhoneLabel.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的手机号码", T: self)
            
            return
            
        }
        
        NetworkTools.requestData(type: .post, URLString: challengesendSTR, parameters: ["source":"payment","cellphone":newReservedPhoneLabel.text!], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.isCounting = true
            self.okBtn.isUserInteractionEnabled = true
            self.okBtn.backgroundColor = UIColor.red
            print(data)
        }) { (error) in
            
            
        }
        
    }
    
    
    func getNetData(){
        
        if codeLabel.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入验证码", T: self)
            
            return
        }
        
        if newReservedPhoneLabel.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入手机号码", T: self)
            
            return
        }
        
        
        
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.rebind","version":"1.0","memberId":memberId,"settleAcount":settleAcountStr,"modiType":"01","newReservedPhone":newReservedPhoneLabel.text!,"code":codeLabel.text!], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            ToolManger.defaultShow(Str: "换卡成功", T: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                
                self.navigationController?.popToRootViewController(animated: true)
            })
            
        }) { (error) in
            
            
        }
        
    }
    
    
}

//
//  loginTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/14.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire

class loginTableViewController: UITableViewController {

    
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var remmberBtn: UIButton!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var webBtn: UIButton!
    
    @IBOutlet weak var forgetBtn: UIButton!
    
    
    var random = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhoneNumberTextField.becomeFirstResponder()
        
        self.touchAction()
        
    }
    
    //控件设定
    func laoutUI(){
        
        
        
        
    }
    
    //单选 (1)
    func touchAction(){
        
        
        LoginBtn.addTarget(self, action: #selector(loginAction), for: UIControlEvents.touchUpInside)
        webBtn.addTarget(self, action: #selector(webAction), for: UIControlEvents.touchUpInside)
        forgetBtn.addTarget(self, action: #selector(forgetAction), for: UIControlEvents.touchUpInside)
        
        remmberBtn.addTarget(self, action: #selector(remmberAction(btn:)), for: UIControlEvents.touchUpInside)
    }
    //登录
    func loginAction(){
        
        getNetData()
        
        
    }
    //注册
    func webAction(){
        
        let applyVC = UIStoryboard.init(name: "apply_for1SB", bundle: nil).instantiateViewController(withIdentifier: "apply_forVC") as! apply_forTableViewController
        
        self.present(applyVC, animated: true, completion: nil)
        
    }
    
    //忘记密码
    func forgetAction(){
        
        let forgetVC = UIStoryboard.init(name: "forgetSB", bundle: nil).instantiateViewController(withIdentifier: "forgetVC") as! forgetTableViewController
        
        
        
        self.present(forgetVC, animated: true, completion: nil)
        
    }
    //记住密码
    func remmberAction(btn:UIButton){
        //self.onecreat()
        
        //普通状态
        if btn.isSelected == true{
            btn.setImage(UIImage.init(named: "单选"), for: UIControlState.normal)
            btn.isSelected = false
        }else{
            //高亮状态
            btn.setImage(UIImage.init(named: "单选 (1)"), for: UIControlState.normal)
            
//            if PhoneNumber.characters.count != 0{
//                self.PhoneNumberTextField.text = PhoneNumber
//                
//            }
//            
//            if PasswordStr.characters.count != 0{
//                
//                self.passwordTextField.text = PasswordStr
//                
//            }
            
            
            btn.isSelected = true
        }
    }
    
    
    
}

extension loginTableViewController{
    
    
    //获取随机数 利用随机数进行加密
    func getNetData(){
        
        if PhoneNumberTextField.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的手机号码", T: self)
            
            return
            
        }
        
        if (passwordTextField.text?.characters.count)! < 6 || (passwordTextField.text?.characters.count)! > 12{
            
            ToolManger.defaultShow(Str: "请输入正确的密码", T: self)
            
            return
        }
        
        
        NetworkTools.requestData(type: .get, URLString: randgetRandomSTR+"?key=\(PhoneNumberTextField.text!)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.random = (data as! NSDictionary)["data"] as! String
            
            DispatchQueue.main.async(execute: {
                self.getNetData1()
                
            })
            
        }) { (error) in
            
            
        }
        
        
        
    }
    
    //登录
    func getNetData1(){
        
        
        //对密码进行加密
        let passStr = passwordTextField.text!.MD5() + random
        
        let para = aesEncryptString(passStr, self.random)
        
        
        NetworkTools.requestData(type: .post, URLString: LOGINOKSTR, parameters: ["account":PhoneNumberTextField.text!,"password":para!], encoding: "post", T: self, ShowStr: true, finishedCallback: { (json) in
            
            //PasswordStr = para!
            // PhoneNumber = self.PhoneNumberTextField.text!
            UserDefaults.standard.set(self.PhoneNumberTextField.text!, forKey: "PhoneNumb")
            UserDefaults.standard.set(self.passwordTextField.text!, forKey: "Password")
            
            PhoneNumber = UserDefaults.standard.string(forKey: "PhoneNumb")!
            
           PasswordStr = UserDefaults.standard.string(forKey: "Password")!
            
            
            if let dataDict = json.value(forKey: "data") as? NSDictionary{
                
                if let shopDict = dataDict["shop"] as? NSDictionary{
                    
                    if let dataDict1 = shopDict["data"] as? NSDictionary{
//                        var shopImgUrlID = UserDefaults.standard.string(forKey: "shopImgUrl")!
//                        var shopNameID = UserDefaults.standard.string(forKey: "shopName")!
//                        var verifyStatusID = UserDefaults.standard.string(forKey: "verifyStatus")!
                          //营业执照图片
                        if let certificateArray = dataDict1["certificate"] as? NSArray{
                            
                            if let aa = certificateArray[0] as? NSDictionary{
                                
                                if let urlStr = aa["url"] as? String{
                                    
                                    UserDefaults.standard.set(urlStr, forKey: "shopLicenseUrl")
                                    UserDefaults.standard.synchronize()
                                    
                                }
                                
                            }
                            
                        }
                        
                        if let eaccountFlagStr = dataDict1["eaccountFlag"] as? String{
                            
                            UserDefaults.standard.set(eaccountFlagStr, forKey: "eaccountFlag")
                            UserDefaults.standard.synchronize()
                            
                        }

                        
                        if let merchantCodeStr = dataDict1["shopCode"] as? String{
                            
                            UserDefaults.standard.set(merchantCodeStr, forKey: "shopCode")
                            
                            UserDefaults.standard.synchronize()
                            
                        }

                        
                        if let shopNameStr = dataDict1["shopName"] as? String{
                            
                            UserDefaults.standard.set(shopNameStr, forKey: "shopName")
                            UserDefaults.standard.synchronize()
                            
                        }
                        if let shopAliasStr = dataDict1["shopAlias"] as? String{
                            
                            UserDefaults.standard.set(shopAliasStr, forKey: "shopAlias")
                            UserDefaults.standard.synchronize()
                            
                        }
                        
                        if let industryStr = dataDict1["industry"] as? String{
                            
                            UserDefaults.standard.set(industryStr, forKey: "industry")
                            UserDefaults.standard.synchronize()
                            
                        }

                        
                        
                        //城市省市区
                        if let provinceCodeStr = dataDict1["provinceCode"] as? String{
                            
                            UserDefaults.standard.set(provinceCodeStr, forKey: "provinceCode")
                            
                            UserDefaults.standard.synchronize()

                        }
                        
                        if let cityCodeStr = dataDict1["cityCode"] as? String{
                            UserDefaults.standard.set(cityCodeStr, forKey: "cityCode")
                            
                            UserDefaults.standard.synchronize()
                            
                        }
                        
                        if let countryCodeStr = dataDict1["countryCode"] as? String{
                            
                            UserDefaults.standard.set(countryCodeStr, forKey: "countryCode")
                            
                            UserDefaults.standard.synchronize()
                            
                            
                        }
                        
                        if let shopAddressStr = dataDict1["shopAddress"] as? String{
                            
                            UserDefaults.standard.set(shopAddressStr, forKey: "shopAddress")
                            UserDefaults.standard.synchronize()
                            
                        }
                        
                        if let verifyStatusStr = dataDict1["verifyStatus"] as? String{
                            UserDefaults.standard.set(verifyStatusStr, forKey: "verifyStatus")
                            UserDefaults.standard.synchronize()
                            
                            
                        }
                        if let verifyStatusStr = dataDict1["verifyStatusDesc"] as? String{
                            UserDefaults.standard.set(verifyStatusStr, forKey: "verifyStatusDesc")
                            UserDefaults.standard.synchronize()
                            
                            
                        }
                        if let shopImgUrlStr = dataDict1["shopImgUrl"] as? String{
                            UserDefaults.standard.set(shopImgUrlStr, forKey: "shopImgUrl")
                            UserDefaults.standard.synchronize()
                            
                            shopImgUrlID = shopImgUrlStr
                            
                        }
                        
                        if let shopQRCodeStr = dataDict1["shopQRCode"] as? String{
                            
                            UserDefaults.standard.set(shopQRCodeStr, forKey: "shopQRCode")
                            UserDefaults.standard.synchronize()
                            shopQRCodeID = UserDefaults.standard.string(forKey: "shopQRCode")!
                            
                        }
                        
                        if let shopQRCodeUrlStr = dataDict1["shopQRCodeUrl"] as? String{
                            
                            UserDefaults.standard.set(shopQRCodeUrlStr, forKey: "shopQRCodeUrl")
                            
                            UserDefaults.standard.synchronize()
                            
                        }
                        
                        
                    }
                    
                }
                
                if let userDict = dataDict["user"] as? NSDictionary{
                    
                    
                    if let realName = userDict["realName"] as? String{
                        
                        //realNameID = realName
                        UserDefaults.standard.set(realName, forKey: "realName")
                        UserDefaults.standard.synchronize()
                        realNameID = UserDefaults.standard.string(forKey: "realName")!
                        
                    }
                    
                    if let role = userDict["role"] as? String{
                        
                        UserDefaults.standard.set(role, forKey: "role")
                        UserDefaults.standard.synchronize()
                        
                        
                    }
                    if let roleName = userDict["roleName"] as? String{
                        
                        UserDefaults.standard.set(roleName, forKey: "roleName")
                        
                        UserDefaults.standard.synchronize()
                        
                    }
                    
                    if let mid = userDict["mid"] as? String{
                        // memberId = mid
                        UserDefaults.standard.set("123", forKey: "isFristOpenApp")
                        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main") as! MainViewController
                        
                        UserDefaults.standard.set(mid, forKey: "memberId")
                        UserDefaults.standard.synchronize()
                        memberId = UserDefaults.standard.string(forKey: "memberId")!
                        
                        self.present(homeVC, animated: true, completion: nil)
                    }
                    
                }
                

                
                
                
                
            }
            
        }) { (error) in
            self.getNetData1()
            
        }
    }
    
    
    
}

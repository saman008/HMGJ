//
//  withdrawalViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import IQKeyboardManager
import LocalAuthentication

class withdrawalViewController: BaseViewController,UITextFieldDelegate {

    var titleItime = ""
    var tableView:UITableView!
    
    
    var settleAcountStr = ""
    var chongzhiortixianStr = ""

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    var passwordStr = ""
    //入账金额
    var validFeeStr = ""
    var withdreawnewvv:withdreawnewViewV!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "红码钱包-\(chongzhiortixianStr)"
        
        
        
        self.laoutUI()
        IQKeyboardManager.shared().isEnabled = false
       
    }
        //tableview  UI
    func laoutUI(){
        
        withdreawnewvv = UINib.init(nibName: "withdreawnewView", bundle: nil).instantiate(withOwner: self, options: nil).first as! withdreawnewViewV
        withdreawnewvv.frame = CGRect.init(x: 0, y: 64, width: ScreenW, height: 180)
        withdreawnewvv.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        withdreawnewvv.inputTextField.delegate = self
        self.view.addSubview(withdreawnewvv)
        withdreawnewvv.valueSettcountLabel.text = "钱包余额:" + self.validFeeStr + "元"
        
        if self.chongzhiortixianStr == "提现"{
           // withdreawnewvv.allSettcountBtn.isHidden = true
        }else if self.chongzhiortixianStr == "充值"{
            withdreawnewvv.allSettcountBtn.isHidden = true
        }
        
        withdreawnewvv.allSettcountBtn.addTarget(self, action: #selector(allSettcountAction), for: UIControlEvents.touchUpInside)
        self.view.backgroundColor = UIColor.white
        
    }
    
    //全部提现
    func allSettcountAction(){

        self.withdreawnewvv.inputTextField.text =  self.validFeeStr
        
        
    }
    
    
    //银行卡
    func bankAction(){
        
        let bankVC = BankViewController()
        
        
        self.navigationController?.pushViewController(bankVC, animated: true)
        
        
    }
    
    //指纹解锁
    func okAction(){
        
        //self.touchID()
        print("指纹")
        
        if self.withdreawnewvv.inputTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入金额", T: self)
            
            return
        }

        
//        if textStr.characters.count == 0{
//            
//            ToolManger.defaultShow(Str: "请输入金额", T: self)
//            
//            return
//        }
       // self.touchID()
        //self.tableView.endEditing(true)
       //2.[self.textField  resignFirstResponder];
        self.click()
    }
    func click(){
        
        
        
        let payAlert = PayAlert(frame: UIScreen.main.bounds)
        payAlert.show(view: self.view)
        payAlert.contentView?.backgroundColor = UIColor.white
       payAlert.mony.text = "金额:" + self.withdreawnewvv.inputTextField.text! + "元"
        //payAlert.backgroundColor = UIColor.RGBA(0, 0, 0, 0.4)
        payAlert.completeBlock = ({(password:String) -> Void in
            print("输入的密码是:" + password)
            self.passwordStr = password
            if self.chongzhiortixianStr == "提现"{
                self.getNetData1(pwdStr: password)
            }else if self.chongzhiortixianStr == "充值"{
                self.getNetData2(pwdStr: password)
            }
        })
    }

    

}
//MARK -键盘代理
extension withdrawalViewController{

    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^([0-9]{0,100})((\\.)[0-9]{0,2})?$"//"^[0-9]*((\\\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
        
    }

    
    
}



extension withdrawalViewController:UITableViewDelegate,UITableViewDataSource{

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            
            return self.dataArray.count
       
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "withmonyDetailTableViewCell", for: indexPath) as! withmonyDetailTableViewCell
            
            cell.model = self.dataArray[indexPath.row] as? widthCheckModel
            
            return cell
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        
        return 60
        
        
    }
    
    
    
}
//MARK - 指纹解锁
extension withdrawalViewController{
    func touchID(){
        
        let context = LAContext()
        
        var error:NSError?
        
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            // 开始进入识别状态，以闭包形式返回结果。闭包的 success 是布尔值，代表识别成功与否。error 为错误信息。
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "请用指纹支付", reply: {success, error in
                //                dispatch_async(dispatch_get_main_queue(), { () -> Voidin //放到主线程执行，这里特别重要
                //                    if success
                //                    {
                //                        //调用成功后你想做的事情
                //                    }
                //                    else
                //                    {
                //                        // If authentication failed then show a message to the console with a short description.
                //                        // In case that the error is a user fallback, then show the password alert view.
                //
                //                    }
                //                })
                if success {
                    // 成功之后的逻辑， 通常使用多线程来实现跳转逻辑。////必须回到主线程中 ////
                    OperationQueue.main.addOperation
                        {
                            
                            if self.chongzhiortixianStr == "提现"{
                                self.getNetData1(pwdStr: self.passwordStr)
                            }else if self.chongzhiortixianStr == "充值"{
                                self.getNetData2(pwdStr: self.passwordStr)
                            }
                    }
                    return
                }else {
                    if let error = error as NSError? {
                        // 获取错误信息
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        print(message)
                        if message == "The user chose to use the fallback"{
                            self.click()
                        }
                        
                    }
                }
                
            })
        }
        
        
        
    }
    
    //指纹解锁每个情况
    func errorMessageForLAErrorCode(errorCode: Int) -> String {
        var message = ""
        
        if #available(iOS 9.0, *) {
            switch errorCode {
            case LAError.appCancel.rawValue:
                message = "Authentication was cancelled by application"
                
            case LAError.authenticationFailed.rawValue:
                message = "The user failed to provide valid credentials"
                
            case LAError.invalidContext.rawValue:
                message = "The context is invalid"
                
            case LAError.passcodeNotSet.rawValue:
                message = "Passcode is not set on the device"
                
            case LAError.systemCancel.rawValue:
                message = "Authentication was cancelled by the system"
                
            case LAError.touchIDLockout.rawValue:
                message = "Too many failed attempts."
                
            //不具有指纹的功能的手机
            case LAError.touchIDNotAvailable.rawValue:
                message = "TouchID is not available on the device"
                //            showPassWordInput()
                
            case LAError.userCancel.rawValue:
                message = "The user did cancel"
                
            //输入密码
            case LAError.userFallback.rawValue:
                message = "The user chose to use the fallback"
                
            default:
                message = "Did not find error code on LAError object"
            }
        } else {
            // Fallback on earlier versions
        }
        return message
    }
}
extension withdrawalViewController{
    
    //提现
    func getNetData1(pwdStr:String){
        
        if Double(self.withdreawnewvv.inputTextField.text!)! > Double(self.validFeeStr)!{
            
            ToolManger.defaultShow(Str: "提现金额超过可用余额", T: self)
            
            return
        }
        //ToolManger.yanchiShow(T: self, Str: "正在加载")
        NetworkTools.requestData(type: .post, URLString: transapplySTR, parameters: ["service":"pay.acount.cashout","version":"1.0","memberId":memberId,"amount":self.withdreawnewvv.inputTextField.text!,"passWord":pwdStr], encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            //ToolManger.hideShow(T: self)
            if let msgStr = data.value(forKey: "msg") as? String{
                
                ToolManger.defaultShow(Str: msgStr, T: self)
            }
            
            
            
            
        }) { (error) in
            
            
        }
        
    }
    
    //充值
    func getNetData2(pwdStr:String){
       
        NetworkTools.requestData(type: .post, URLString: transapplySTR, parameters: ["service":"pay.acount.cashin","version":"1.0","memberId":memberId,"amount":self.withdreawnewvv.inputTextField.text!,"passWord":pwdStr], encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
           
            
            if let msgStr = data.value(forKey: "msg") as? String{
                
                ToolManger.defaultShow(Str: msgStr, T: self)
                
                
            }
        }) { (error) in
          
            
        }
        
    }
    
    
}

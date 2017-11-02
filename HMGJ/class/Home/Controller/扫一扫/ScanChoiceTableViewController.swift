//
//  ScanChoiceTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class ScanChoiceTableViewController: TabBaseTableViewController,UITextFieldDelegate {

    @IBOutlet weak var zhifubaoBtn: UIButton!
    
    @IBOutlet weak var zhifubaoImageView: UIImageView!
    
    @IBOutlet weak var weixinBtn: UIButton!
    
    @IBOutlet weak var weixinImageView: UIImageView!
    
    @IBOutlet weak var yizhifuBtn: UIButton!
    
    @IBOutlet weak var yizhifuImageVIew: UIImageView!
    
    @IBOutlet weak var jingdongBtn: UIButton!
    
    @IBOutlet weak var jingdongImageView: UIImageView!
    
    @IBOutlet weak var huodongmaBtn: UIButton!
    
    @IBOutlet weak var huodongmaImageView: UIImageView!
    
    @IBOutlet weak var putIntoTextField: UITextField!
    
    @IBOutlet weak var okBtn: UIButton!
    
    
    @IBOutlet weak var yizhifuView: UIView!
    
    @IBOutlet weak var jnigdongView: UIView!
    
    @IBOutlet weak var huodongmaView: UIView!
    var zhifubaoStr = "1"
    var weixinStr = "1"
    var yizhifuStr = "1"
    var jingdongStr = "1"
    var huodongmaStr = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "选择二维码类型"
        

        self.yizhifuView.isHidden = true
        self.jnigdongView.isHidden = true
        self.huodongmaView.isHidden = true
        
        //self.btnAction()
        
        putIntoTextField.delegate = self
        self.putIntoTextField.becomeFirstResponder()
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
    }
    func btnAction(){
        
        
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
        zhifubaoBtn.addTarget(self, action: #selector(zhifubaoAction(btn:)), for: UIControlEvents.touchUpInside)
        weixinBtn.addTarget(self, action: #selector(weixinAction(btn:)), for: UIControlEvents.touchUpInside)
        yizhifuBtn.addTarget(self, action: #selector(yizhifuAction), for: UIControlEvents.touchUpInside)
        jingdongBtn.addTarget(self, action: #selector(jingdongAction), for: UIControlEvents.touchUpInside)
        huodongmaBtn.addTarget(self, action: #selector(huodongmaAction), for: UIControlEvents.touchUpInside)
    }
    func okAction(){
        
        if putIntoTextField.text?.characters.count == 0{
            
            UIAlertController.addNornalAlertController(target: self, title: "请输入金额")
            
            return
        }
        
        
        let pricea = (self.putIntoTextField.text! as NSString).doubleValue
        
        let priceb = pricea * 100
        let vc = QQScanViewController();
        var style = LBXScanViewStyle()
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        vc.scanStyle = style
        vc.label2Str = self.putIntoTextField.text!
        vc.amountStr = "\(Int(priceb))"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func zhifubaoAction(btn:UIButton){

        
        
        if zhifubaoStr == "1"{
            zhifubaoImageView.image = UIImage.init(named: "支付宝1@2x")
            weixinImageView.image = UIImage.init(named: "微信1")
            yizhifuImageVIew.image = UIImage.init(named: "翼支付1")
            jingdongImageView.image = UIImage.init(named: "京东钱包1")
            huodongmaImageView.image = UIImage.init(named: "活动码1")
            self.btnstr(str1: "2", str2: "1", str3: "1", str4: "1", str5: "1")
        }else if zhifubaoStr == "2"{

            zhifubaoImageView.image = UIImage.init(named: "支付宝1")
            
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "1")
        }
        

    }
    
    func weixinAction(btn:UIButton){
        
        
        if weixinStr == "1"{
            weixinImageView.image = UIImage.init(named: "微信")
            zhifubaoImageView.image = UIImage.init(named: "支付宝1")
            yizhifuImageVIew.image = UIImage.init(named: "翼支付1")
            jingdongImageView.image = UIImage.init(named: "京东钱包1")
            huodongmaImageView.image = UIImage.init(named: "活动码1")
            self.btnstr(str1: "1", str2: "2", str3: "1", str4: "1", str5: "1")
            
        }else if weixinStr == "2"{
            weixinImageView.image = UIImage.init(named: "微信1")
            
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "1")

        }
    }
    func yizhifuAction(){
        if yizhifuStr == "1"{
            weixinImageView.image = UIImage.init(named: "微信1")
            zhifubaoImageView.image = UIImage.init(named: "支付宝1")
            yizhifuImageVIew.image = UIImage.init(named: "翼支付")
            jingdongImageView.image = UIImage.init(named: "京东钱包1")
            huodongmaImageView.image = UIImage.init(named: "活动码1")
            self.btnstr(str1: "1", str2: "1", str3: "2", str4: "1", str5: "1")
            
        }else if yizhifuStr == "2"{
            yizhifuImageVIew.image = UIImage.init(named: "翼支付1")
            
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "1")
            
        }
    }
    func jingdongAction(){
        
        if jingdongStr == "1"{
            weixinImageView.image = UIImage.init(named: "微信1")
            zhifubaoImageView.image = UIImage.init(named: "支付宝1")
            yizhifuImageVIew.image = UIImage.init(named: "翼支付1")
            jingdongImageView.image = UIImage.init(named: "京东钱包")
            huodongmaImageView.image = UIImage.init(named: "活动码1")
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "2", str5: "1")
            
        }else if jingdongStr == "2"{
            
            jingdongImageView.image = UIImage.init(named: "京东钱包1")
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "1")
            
        }
    }
    
    func huodongmaAction(){
        if huodongmaStr == "1"{
            weixinImageView.image = UIImage.init(named: "微信1")
            zhifubaoImageView.image = UIImage.init(named: "支付宝1")
            yizhifuImageVIew.image = UIImage.init(named: "翼支付1")
            jingdongImageView.image = UIImage.init(named: "京东钱包1")
            huodongmaImageView.image = UIImage.init(named: "活动码")
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "2")
            
        }else if huodongmaStr == "2"{
            
            huodongmaImageView.image = UIImage.init(named: "活动码1")
            self.btnstr(str1: "1", str2: "1", str3: "1", str4: "1", str5: "1")
            
        }
        
        
        
    }

    
    func btnstr(str1:String,str2:String,str3:String,str4:String,str5:String){
        zhifubaoStr = str1
        weixinStr = str2
        yizhifuStr = str3
        jingdongStr = str4
        huodongmaStr = str5
    }
    

}

//MARK -键盘代理
extension ScanChoiceTableViewController{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^([0-9]{0,100})((\\.)[0-9]{0,2})?$"//"^[0-9]*((\\\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
        
    }
    
    
    
}



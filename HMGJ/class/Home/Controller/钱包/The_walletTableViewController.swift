//
//  The_walletTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class The_walletTableViewController: TabBaseTableViewController {

    @IBOutlet weak var label1: UILabel!
    //是否开通
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    //提现
    @IBOutlet weak var withdrawalBtn: UIButton!
    //充值
    @IBOutlet weak var top_upBtn: UIButton!
    //银行卡
    @IBOutlet weak var Bank_cardBtn: UIButton!
    //卡卷
    @IBOutlet weak var Card_volumeBtn: UIButton!
    
    @IBOutlet weak var view111: UIView!

    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBOutlet weak var cangetMoneyLabel: UILabel!
    
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
    
    var settleAcountS = ""
    //为1的时候才是开通了
    var eaccountFlagS = ""
    
    //入账金额
    var validFeeStr = ""
    
    //是否绑定了
    var bank_trueStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "红码钱包"
        
        self.nav2Btn()
        self.allBtn()
        self.btnWC()
        
        self.layoutAction()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.checkGeNetData()
    }
    
    //界面控件设置
    func layoutAction(){
        self.cardImageView.isHidden = true
        self.label1.isHidden = true
        self.label2.isHidden = true
        self.cangetMoneyLabel.isHidden = true
        
        self.headerLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(openAcountCard))
        
        self.headerLabel.addGestureRecognizer(tap)
        
    }
    //是否开通账户
    func openAcountCard(){

        
        let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
    //certVC.okornoStr = "1"
        self.navigationController?.pushViewController(certVC, animated: true)
        
    }
    
    //所有button边角颜色宽度
    func btnWC(){
        laer(btn: withdrawalBtn)
        laer(btn: top_upBtn)
        laer(btn: Bank_cardBtn)
        

        
    }
    
    func laer(btn:UIButton){

        
        
        btn.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        btn.layer.borderWidth = 0.5

        
    }
    
    func allBtn(){
        
        withdrawalBtn.addTarget(self, action: #selector(withdrawalAction), for: UIControlEvents.touchUpInside)
        top_upBtn.addTarget(self, action: #selector(top_upAction), for: UIControlEvents.touchUpInside)
        Bank_cardBtn.addTarget(self, action: #selector(Bank_cardAction), for: UIControlEvents.touchUpInside)
        
        
        
    }
    
    //提现
    func withdrawalAction(){

        if self.bank_trueStr == "1"{
            let withDVC = withdrawalViewController()
            
            withDVC.settleAcountStr = self.settleAcountS
            withDVC.validFeeStr = self.validFeeStr
            withDVC.chongzhiortixianStr = "提现"
            self.navigationController?.pushViewController(withDVC, animated: true)
        }else{
            let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
            //certVC.okornoStr = "1"
            self.navigationController?.pushViewController(certVC, animated: true)
        }
        
    }
    //充值
    func top_upAction(){


        if self.bank_trueStr == "1"{
            let withDVC = withdrawalViewController()
            
            withDVC.settleAcountStr = self.settleAcountS
            withDVC.validFeeStr = self.validFeeStr
            withDVC.chongzhiortixianStr = "充值"
            self.navigationController?.pushViewController(withDVC, animated: true)
        }else{
            let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
            //certVC.okornoStr = "1"
            self.navigationController?.pushViewController(certVC, animated: true)
        }
        

    }
    //交易流水
    func Bank_cardAction(){
        
        if self.bank_trueStr == "1"{
            let withVC = withdrawalDetailViewController()
            
            withVC.settleAcountStr = self.settleAcountS
            
            self.navigationController?.pushViewController(withVC , animated: true)
        }else{
            let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
            //certVC.okornoStr = "1"
            self.navigationController?.pushViewController(certVC, animated: true)
        }
    }


    
    //右上角
    func nav2Btn(){
        
        rightBtn.setImage(UIImage.init(named: "location"), for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.setTitle("换卡", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.contentHorizontalAlignment = .right
        //        let attributeString = NSMutableAttributedString(string: "44678")
        //        attributeString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "成都市", size: 12), range: NSMakeRange(0, 1))
        //        attributeString.addAttribute(NSFontAttributeName, value: RColor, range: NSMakeRange(0, 1))
        //        leftBtn.setAttributedTitle(attributeString, for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(leftAction), for: UIControlEvents.touchUpInside)
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    //方法实现右上角
    func leftAction(){
        
        let bankVC = BankViewController()
        bankVC.settleAcountStr = self.settleAcountS
        
        self.navigationController?.pushViewController(bankVC, animated: true)
        
    }
    

}

extension The_walletTableViewController{
    
    //1.1.1	E账户详细信息查询******************
    func checkGeNetData(){

        NetworkTools.requestAnyData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.info","version":"1.0","memberId":memberId], encoding: "post", T: self, ShowStr: false, error: false, finishedCallback: { (data) in
            self.bank_trueStr = "1"
            self.headerLabel.isUserInteractionEnabled = false
            
            self.cardImageView.isHidden = false
            self.label1.isHidden = false
            self.label2.isHidden = false
            self.cangetMoneyLabel.isHidden = false
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                //银行卡数字
                if let bankNameStr = dataDict["bankName"] as? String{
                    
                    if let bankCardNoStr = dataDict["bankCardNo"] as? String{
                        
                        let ns1 = bankCardNoStr.index(bankCardNoStr.startIndex, offsetBy: bankCardNoStr.lengthOfBytes(using: .utf8) - 4)
                        let result = bankCardNoStr.substring(from: ns1)
                        self.label1.text = bankNameStr + "(\(result))"
                    }
                }
                
                
                //金额 钱
                //入账金额
                if let validFeeStr = dataDict["validFee"] as? String{
                    
                    self.headerLabel.text = validFeeStr
                    self.validFeeStr = validFeeStr
                }
                //未入账金额
                if let invalidFeeStr = dataDict["invalidFee"] as? String{
                    
                    self.label2.text = "未入账金额(元):" + invalidFeeStr
                    
                }
                
                
            }
            self.tableView.reloadData()
            
        }) { (error) in
            
            
        }

        
    }

    
    
}

//
//  QQScanSucTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/13.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit


class QQScanSucTableViewController: TabBaseTableViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var stateMsgLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    

    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    //商品信息

    
    @IBOutlet weak var goodsNameLabel: UILabel!
    
    
    //交易时间
    @IBOutlet weak var transTimeLabel: UILabel!
    //交易号
    @IBOutlet weak var thirdTrascationIdLabel: UILabel!
    //商户订单号
    @IBOutlet weak var outTradeNoLabel: UILabel!
    
    var outTradeNoStr = ""
    
    @IBOutlet weak var checkResultBtn: UIButton!

    @IBOutlet weak var randomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "收款结果"

        self.randomView.isHidden = true
        
        let leftbtn = UIBarButtonItem.init(title: "", style: .plain, target: self, action: #selector(rightActi))
        
        leftbtn.image = UIImage.init(named: "返回")
        
        let spacer = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        
        
        spacer.width = -10
        // 返回按钮设置成功
        self.navigationItem.leftBarButtonItems = [spacer,leftbtn]
        self.getNetData()
        
        
        self.checkResultBtn.addTarget(self, action: #selector(checkAction), for: UIControlEvents.touchUpInside)
    }
    func checkAction(){
        
        self.getNetData()
        
    }


    
    func rightActi(){
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
extension QQScanSucTableViewController{
    
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: payqueryStr, parameters: ["outTradeNo":outTradeNoStr,"qrCode":shopQRCodeID], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let goodsNameStr = dataDict["goodsName"] as? String{
                    self.goodsNameLabel.text = goodsNameStr
                }else{
                    self.goodsNameLabel.text = "暂无"
                }
                if let transTimeStr = dataDict["transTime"] as? String{
                    self.transTimeLabel.text = transTimeStr
                    
                }else{
                    self.transTimeLabel.text = "暂无"
                }
                if let thirdTrascationIdStr = dataDict["thirdTrascationId"] as? String{
                    
                    self.thirdTrascationIdLabel.text = thirdTrascationIdStr
                    
                }else{
                    self.thirdTrascationIdLabel.text = "暂无"
                }
                
                if let outTradeNoStr = dataDict["outTradeNo"] as? String{
                    self.outTradeNoLabel.text = outTradeNoStr
                }else{
                    self.outTradeNoLabel.text = "暂无"
                }
                
                if let stateMsgStr = dataDict["stateMsg"] as? String{
                    
                    if stateMsgStr.contains("成功"){
                        self.stateMsgLabel.text = stateMsgStr
                        self.headerImageView.image = UIImage.init(named: "成功")
                        
                    }else if stateMsgStr.contains("失败"){
                        self.stateMsgLabel.text = stateMsgStr
                        self.headerImageView.image = UIImage.init(named: "失败")
                    }else if stateMsgStr.contains("待支付"){
                        self.stateMsgLabel.text = stateMsgStr
                        self.headerImageView.image = UIImage.init(named: "wait")
                        
                    }
                    
                }else{
                    
                }
                if let amountStr = dataDict["amount"] as? Int{
                    let pricea = CGFloat(amountStr)
                    let priceb = pricea / 100
                    self.amountLabel.text = "+" + "\(priceb)"
                }
                
                if let randomStr = dataDict["random"] as? String{
                    
                    let a = randomStr
                    
                    for (i,j) in a.characters.enumerated(){
                        
                        if i == 0{
                            self.label1.text = "\(j)"
                        }else if i == 1{
                            self.label2.text = "\(j)"
                        }else if i == 2{
                            self.label3.text = "\(j)"
                        }else if i == 3{
                            self.label4.text = "\(j)"
                        }
                        
                    }
                    
                }
                
            }
            
            self.tableView.reloadData()
        }) { (error) in
            
            
        }
        
    }
    
}

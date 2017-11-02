//
//  RunningDetailTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/28.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class RunningDetailTableViewController: TabBaseTableViewController {


    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var actualAmtLabel: UILabel!
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var goodsDetailLabel: UILabel!
    
    @IBOutlet weak var payAccountLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var thirdTradeNoLabel: UILabel!
    
    @IBOutlet weak var tradeNoLabel: UILabel!
    
    @IBOutlet weak var rewardLabel: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var remarkLabel: UILabel!
    
    var trandeNoStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单详情"
        
        self.getNetData()
        //
        self.rightBtn()
    }
    //右上角
    func rightBtn(){
        let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        
        rightBtn.setTitle("修改备注", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){
        let alertController = UIAlertController(title: "请输入订单备注",
                                                message: "", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "请输入订单备注"
        }
        let okAction = UIAlertAction(title: "确定", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let login = alertController.textFields!.first!
            
            self.remarkLabel.text = login.text!
            self.reamkGetNetData(Str: self.remarkLabel.text!)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    

}

extension RunningDetailTableViewController{
    
    
    //添加订单备注
    func reamkGetNetData(Str:String){
        
        
        NetworkTools.requestData(type: .post, URLString: orderremarkSTR, parameters: ["memberId":memberId,"remark":Str,"tradeNo":trandeNoStr], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            
            print(data)
            self.tableView.reloadData()
        }) { (eror) in
            
            
        }
        
        
    }
    
    
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: tradedetailSTR, parameters: ["workNo":memberId,"tradeNo":trandeNoStr], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let actualAmtStr = dataDict["actualAmt"] as? String{
                    if let billsMarkStr = dataDict["billsMark"] as? String{
                        if billsMarkStr == "1"{
                            self.actualAmtLabel.text = "+" + actualAmtStr
                        }else if billsMarkStr == "0"{
                            self.actualAmtLabel.text = "-" + actualAmtStr
                        }
                        
                    }
                    
                }
                if let statusStr = dataDict["status"] as? String{
                    
                    self.statusLabel.text = statusStr
                    if statusStr == "成功"{
                        self.headerImageView.image = UIImage.init(named: "成功")
                    }else{
                        self.headerImageView.image = UIImage.init(named: "失败")
                    }
                    
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
                
                if let goodsDetailStr = dataDict["goodsDetail"] as? String{
                    
                    self.goodsDetailLabel.text = goodsDetailStr
                }
                
                if let payAccountStr = dataDict["payAccount"] as? String{
                    
                    self.payAccountLabel.text = payAccountStr
                    
                }
               
                if let timeStr = dataDict["time"] as? Int{
                    
                    self.timeLabel.text = ToolManger.transtimeStr(timeStamp: "\(timeStr/1000)", Str: "yyyy年MM月dd日 HH:mm")
                    
                }
                
                if let thirdTradeNoStr = dataDict["thirdTradeNo"] as? String{
                    
                    self.thirdTradeNoLabel.text = thirdTradeNoStr
                    
                }
                
                if let tradeNoStr = dataDict["tradeNo"] as? String{
                    
                    self.tradeNoLabel.text = tradeNoStr
                }
                
                if let rewardStr = dataDict["reward"] as? String{
                    
                    
                    self.rewardLabel.text = rewardStr
                }
                
                if let remarkStr = dataDict["remark"] as? String{
                    
                    
                    self.remarkLabel.text = remarkStr
                }
                
                if let activityArray = dataDict["activity"] as? NSArray{
                    var bb = ""
                    for i in activityArray{
                        bb = bb + "\(i) "
                    }
                    self.activityLabel.text = bb
                }
                
                
               self.tableView.reloadData()
                
                
            }
            
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
}

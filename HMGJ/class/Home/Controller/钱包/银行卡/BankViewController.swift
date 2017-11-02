//
//  BankViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class BankViewController:BaseViewController {

    
    var tableView:UITableView!
    
    var addFootView:footView!
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    let choiceArray = ["修改支付密码","更换预留手机号","换绑银行卡"]
    
    var settleAcountStr = ""
     let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "银行卡"
        
        tableView = UITableView(frame: self.view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "BankTableViewCell", bundle: nil), forCellReuseIdentifier: "BankTableViewCell")
       
        tableView.rowHeight = 140
        addFootView = UINib.init(nibName: "bankFootView", bundle: nil).instantiate(withOwner: self, options: nil).first as! footView
        addFootView.addBtn.addTarget(self, action: #selector(addAction), for: UIControlEvents.touchUpInside)
        tableView.tableFooterView = UIView()
         self.view.addSubview(tableView)
        self.getNetData()
    }
    
    func addAction(){
        
        print("点击")
    }

    func choiceAction(){
        let alert = UIAlertController(title: nil, message: "请选择", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        for (j,i) in choiceArray.enumerated(){
            let okAction = UIAlertAction(title: i, style: .default, handler: { (action:UIAlertAction) -> Void in
                
                print(i)
                //修改支付密码
                if j == 0{
                    let changeBankVC = UIStoryboard.init(name: "changeBankSB", bundle: nil).instantiateViewController(withIdentifier: "changeBankVC") as! changeBankTableViewController
                    
                    
                    self.navigationController?.pushViewController(changeBankVC, animated: true)
                }
                //换卡对应的手机号
                else if j == 1{
                    
                    let forgetBankVC = UIStoryboard.init(name: "forgetBankSB", bundle: nil).instantiateViewController(withIdentifier: "forgetBankVC") as! forgetBankTableViewController
                    
                    forgetBankVC.settleAcountStr = self.settleAcountStr
                    
                    self.navigationController?.pushViewController(forgetBankVC, animated: true)
                    
                }
                //换卡
                
                else if j == 2{
                    
                    let modify_theVC = UIStoryboard.init(name: "Modify_theSB", bundle: nil).instantiateViewController(withIdentifier: "modify_theVC") as! modify_theTableViewController
                    
                    modify_theVC.settleAcountStr = self.settleAcountStr
                    
                    self.navigationController?.pushViewController(modify_theVC, animated: true)
                    
                }
                
                
            })
            alert.addAction(okAction)
        }
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension BankViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankTableViewCell", for: indexPath) as! BankTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? acountcardlistModel
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.choiceAction()
        
    }
    
    
}
extension BankViewController{
    
    //获取银行卡列表
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.cardlist","version":"1.0","memberId":memberId], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            
//            bankCardNo = 40551220833740609;
//            bankName = "\U4ea4\U901a\U94f6\U884c";
//            cardName = "\U592a\U5e73\U6d0b\U4e92\U8fde\U5361(\U94f6\U8054\U5361)";
//            cardType = "\U501f\U8bb0\U5361";
//            custName = "\U6768\U4fca\U4f1f";
//            idNo = 610103196602073617X;
//            reservedPhone = 13937998675;
            
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: acountcardlistModel.self, json: data1Array){
                    
                    
                    self.dataArray.addObjects(from: modelArray)
                    
                    self.tableView.reloadData()
                    if self.dataArray.count > 0{
                        
                        self.view.addSubview(self.tableView)
                        self.label.removeFromSuperview()
                    }else{
                        self.tableView.removeFromSuperview()
                        
                        //                        let imageview = UIImageView.init(image: UIImage.init(named: "activity213456"))
                        //                        //imageview.contentMode = .scaleAspectFill
                        //                        imageview.frame = CGRect.init(x: 100, y: 100, width: ScreenW/2, height: ScreenH/2)
                        //                        //self.view.center = imageview.center
                        
                        self.view.backgroundColor = UIColor.white
                        self.label.text = "暂无数据"
                        self.label.textAlignment = .center
                        self.view.addSubview(self.label)
                        
                    }
                }
                
            }
            
            
        }) { (error) in
            
            
            
        }
        
    }
    
    
}

//
//  waitTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/11/1.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class waitTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var waitView: UIView!
    
    var Str = ""
    var amountStr = ""
    var waitV:ZZCACircleProgress!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "正在查询"
        
        self.initCircles()
        self.getNetData(authCode: Str)
    }


    func initCircles(){
        
        let itemWidth:CGFloat = 150
        //隐藏文字

        let circle = ZZCACircleProgress.init(frame: CGRect.init(x: ScreenW/2-75, y: ScreenH/2-150, width: itemWidth, height: itemWidth), pathBack:nil, pathFill: UIColor.red, startAngle: 0, strokeWidth: 10)
        
        circle?.showProgressText = true
        
        circle?.duration = 20//动画时长
        
        circle?.prepareToShow = true//设置好属性，准备好显示了，显示之前必须调用一次
        
        circle?.progress = 1
        
        self.waitView.addSubview(circle!)
    }
    

}
extension waitTableViewController{
    
    func getNetData(authCode:String){
        
        NetworkTools.requestData(type: .post, URLString: scancodepayStr, parameters: ["amount":amountStr,"authCode":authCode,"shopQRCode":shopQRCodeID,"staffMId":memberId], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let outTradeNoStr = dataDict["outTradeNo"] as? String{
                    
                    let QQScanSBVC = UIStoryboard.init(name: "QQScanSB", bundle: nil).instantiateViewController(withIdentifier: "QQScanSB") as! QQScanSucTableViewController
                    
                    QQScanSBVC.outTradeNoStr = outTradeNoStr
                    QQScanSBVC.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(QQScanSBVC, animated: true)
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
        
    }
    
    
}

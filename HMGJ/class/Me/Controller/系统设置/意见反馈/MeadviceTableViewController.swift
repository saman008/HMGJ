//
//  MeadviceTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeadviceTableViewController: UITableViewController {

    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var errorBtn: UIButton!
    var choiceArray = ["系统异常退出","黑屏","登陆太长"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "意见反馈"
        
        
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.RGB(60, 40, 129).cgColor
        
        self.rightBtn()
        errorBtn.addTarget(self, action: #selector(choiceAction), for: UIControlEvents.touchUpInside)
    }
    //右上角
    func rightBtn(){
        let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        
        rightBtn.setTitle("完成", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){
        
        ToolManger.defaultShow(Str: "我们已收到你的反馈", T: self)
        
    }
    

    func choiceAction(){
        let alert = UIAlertController(title: nil, message: "请选择", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        for (j,i) in choiceArray.enumerated(){
            let okAction = UIAlertAction(title: i, style: .default, handler: { (action:UIAlertAction) -> Void in
                
                print(i)
                
                if j == 0{
                    self.errorBtn.setTitle(i, for: UIControlState.normal)
                    
                }
                   
                else if j == 1{
                    self.errorBtn.setTitle(i, for: UIControlState.normal)
                }
                    
                else if j == 2{
                    self.errorBtn.setTitle(i, for: UIControlState.normal)
                    
                }
                
                
            })
            alert.addAction(okAction)
        }
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

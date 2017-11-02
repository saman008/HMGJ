//
//  MeAddshopTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeAddshopTableViewController: TabBaseTableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var sexBtn: UIButton!
    var sexnumber = ""
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "添加员工"
        
        //self.tableView.isScrollEnabled = false
        self.rightBtn()
        sexBtn.addTarget(self, action: #selector(remmberAction(btn:)), for: UIControlEvents.touchUpInside)
    }
    
    //
    func remmberAction(btn:UIButton){

        
        //普通状态
        if sexnumber == ""{
            btn.setTitle("女", for: UIControlState.normal)
            sexnumber = "1"
        }else{
            //高亮状态
            btn.setTitle("男", for: UIControlState.normal)
            sexnumber = ""
        }
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
        
        self.getNetData()
        
    }
    
}

extension MeAddshopTableViewController{
    
    
    
    
    func getNetData(){
        
        if self.nameTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入真实姓名", T: self)
            
            return
        }
        
        
        if self.phoneTextField.text?.characters.count != 11{
            
            ToolManger.defaultShow(Str: "请输入正确的手机号码", T: self)
            
            return
        }
       
        let para = ["masterMId":memberId,"shopQRCode":shopQRCodeID,"realName":self.nameTextField.text!,"gender":self.sexBtn.titleLabel!.text!,"cellphone":self.phoneTextField.text!]
        NetworkTools.requestData(type: .post, URLString: employeecreateSTR, parameters: para, encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
            ToolManger.defaultShow(Str: "添加员工成功", T: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: { 
                //self.navigationController?.popViewController(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
            })
            
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
}

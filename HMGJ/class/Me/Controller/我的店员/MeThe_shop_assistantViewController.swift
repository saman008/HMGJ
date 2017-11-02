//
//  MeThe_shop_assistantViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeThe_shop_assistantViewController: BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        return NSMutableArray()
        
    }()
    
    var firedMId = ""
    
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的店员"
        
        tableView = UITableView(frame: self.view.bounds)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.rowHeight = 200
        tableView.register(UINib.init(nibName: "MeshopassiantTableViewCell", bundle: nil), forCellReuseIdentifier: "MeshopassiantTableViewCell")
        
        tableView.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        self.view.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        self.tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.rightBtn()
        
        self.getNetData()
    }
    //右上角
    func rightBtn(){
        let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 60, height: 30))
        
        rightBtn.setTitle("添加", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){

        let MeAddshopVC = UIStoryboard.init(name: "MeAddshopSB", bundle: nil).instantiateViewController(withIdentifier: "MeAddshopVC") as! MeAddshopTableViewController
        
        
        self.navigationController?.pushViewController(MeAddshopVC, animated: true)
        
        
    }
    
    //重新发送短信
    func sendAction(btn:UIButton){
        

        
       
        let alert = UIAlertController(title: "重发短信", message: "你确定要吗?", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            let model = self.dataArray[btn.tag - 100] as? MenewempoyModel
            
            if let aa = model?.cellphone{
                if let bb = model?.memberId{
                    self.resendsmsGetNetData(phone: aa, employeeMId: bb)
                }
                
            }
            
            
        }
        let noAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }

    //解雇员工
    func noAction(btn:UIButton){
        
        let alert = UIAlertController(title: "解雇员工", message: "你确定要解雇该员工", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (action) in
            let model = self.dataArray[btn.tag - 100] as? MenewempoyModel
            if let aa = model?.memberId{
                self.firedMId = aa
            }
            self.fireGetNetData()
            
            
        }
        let noAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension MeThe_shop_assistantViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeshopassiantTableViewCell", for: indexPath) as! MeshopassiantTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? MenewempoyModel
        
        cell.noBtn.addTarget(self, action: #selector(noAction), for: UIControlEvents.touchUpInside)
        cell.noBtn.tag = 100 + indexPath.row
        
        cell.sendBtn.addTarget(self, action: #selector(sendAction), for: UIControlEvents.touchUpInside)
        cell.sendBtn.tag = 100 + indexPath.row
        
        return cell
    }
    
    
}
extension MeThe_shop_assistantViewController{
    
    //重发短信
    func resendsmsGetNetData(phone:String,employeeMId:String){
        
        NetworkTools.requestData(type: .get, URLString: employeeresendsmsSTR, parameters: ["masterMId":memberId,"shopQRCode":shopQRCodeID,"cellphone":phone,"employeeMId":employeeMId], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            ToolManger.defaultShow(Str: "发送成功", T: self)
            
        }) { (erro) in
            
            
        }
        
    }
    
    
    
    //获取所有员工
    func getNetData(){
        //["masterMId":memberId,"shopQRCode":shopQRCodeID]
        let aa = employeelistSTR+"?masterMId=\(memberId)&shopQRCode=\(shopQRCodeID)"
        
        NetworkTools.requestData(type: .get, URLString: aa, parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            self.dataArray.removeAllObjects()
            if let dataDict = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: MenewempoyModel.self, json: dataDict){
                    
                    
                    self.dataArray.addObjects(from: modelArray)
                    
                    if self.dataArray.count > 0{
                        
                        self.view.addSubview(self.tableView)
                    }else{
                        self.tableView.removeFromSuperview()
                        
                        //                        let imageview = UIImageView.init(image: UIImage.init(named: "activity213456"))
                        //                        //imageview.contentMode = .scaleAspectFill
                        //                        imageview.frame = CGRect.init(x: 100, y: 100, width: ScreenW/2, height: ScreenH/2)
                        //                        //self.view.center = imageview.center
                        
                        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
                        
                        label.text = "暂无数据"
                        label.textAlignment = .center
                        self.view.backgroundColor = UIColor.white
                        self.view.addSubview(label)
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
    //解雇员工
    func fireGetNetData(){
        
        NetworkTools.requestData(type: .post, URLString: relationshipfireSTR, parameters: ["masterMId":memberId,"firedMId":firedMId,"shopQRCode":shopQRCodeID], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.getNetData()
            
        }) { (error) in
            
            
        }
        
    }
    
    
}

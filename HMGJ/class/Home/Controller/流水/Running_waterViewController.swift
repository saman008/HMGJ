//
//  Running_waterViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class Running_waterViewController: BaseViewController{
    
    var headerView:Running_waterView!
    var tableView:UITableView!
    
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    lazy var headerdataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    var indexArray = [NSIndexPath]()
    
    //二维数组
    
    var TWOdataArray = [[newRunningModel]]()
    var pushView:pushtotailView!
    
    
    //流水列表
    lazy var listdaysdataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    lazy var listrowsdataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    var ALLdataArray = [[newlistRunningModel]]()
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    
    var timeStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = UserDefaults.standard.string(forKey: "shopName")
        headerView = UINib.init(nibName: "Running_waterHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as! Running_waterView
        
        headerView.frame = CGRect.init(x: 0, y: 64, width: ScreenW, height: 80)
        self.view.addSubview(headerView)
        
        self.laoutUI()
        self.shuaxuanUI()
        self.rightAction()
        
        self.listGetNetData(ppara: ["":""])
        self.headerGetNetData(ppara: ["":""])
        self.getNetData()
        
    }
    
    //基础tabview
    func laoutUI(){
        tableView = UITableView(frame: CGRect.init(x: 0, y: 144, width: ScreenW, height: ScreenH - 144), style: UITableViewStyle.grouped)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "RunningContentDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "RunningContentDetailTableViewCell")
        tableView.register(UINib.init(nibName: "newRunningDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "newRunningDetailTableViewCell")
        tableView.register(UINib.init(nibName: "liushuifooterTableViewCell", bundle: nil), forCellReuseIdentifier: "liushuifooterTableViewCell")
        tableView.rowHeight = 80
        
        self.view.addSubview(tableView)
    }
    
    //刷选
    func shuaxuanUI(){
        
        pushView = UINib.init(nibName: "pushtotailV", bundle: nil).instantiate(withOwner: self, options: nil).first as! pushtotailView
        
        pushView.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        
        self.pushView.backgroundColor = UIColor.RGBA(0, 0, 0, 0.4)
        
        
        self.pushView.delegate = self as ToolBtnProrocol
        self.pushView.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
    }
    
    func okAction(){
        
       // self.indexArray.removeAll()
        var cc = [String]()
        var Str = ""
        var Str1 = ""
        var Str2 = ""
        
        var para = ["shopQRCode":shopQRCodeID,"pageSize":"50","pageNum":"1"]
       
        for i in indexArray{
            print(i.row)
            print(i.section)
            
            let model = self.headerdataArray[i.section] as? newRunningModel
            let model1 = self.TWOdataArray[i.section][i.row] as? newRunningModel
            
            

            
            if let aa = model?.value{
                if aa == "payway"{
                    if let dd = model1?.value{
                        Str = "\(dd)," + Str
                    }
                }
                if aa == "status"{
                    if let dd = model1?.value{
                        Str1 = "\(dd)," + Str1
                    }
                }
                if aa == "cashier"{
                    if let dd = model1?.value{
                        Str2 = "\(dd)," + Str2
                    }
                }
            }

        }
        
        if Str.characters.count != 0{
            para["payway"] = Str
        }
        if Str1.characters.count != 0{
            para["status"] = Str1
        }
        if Str2.characters.count != 0{
            para["cashier"] = Str2
        }

        //"time":"2017-06-16 00:00:00,2017-09-16 23:59:59"
        if self.pushView.value4.characters.count != 0{
            para["time"] = self.pushView.value3 + "," + self.pushView.value4
        }
        
        
        self.listGetNetData(ppara: para)
        self.headerGetNetData(ppara: para)
        self.pushView.removeFromSuperview()
        
    }
    
    //右上角
    func rightAction(){

        rightBtn.setImage(UIImage.init(named: "筛选"), for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(){
        
        UIApplication.shared.keyWindow?.addSubview(pushView)
        
    }
    
}

extension Running_waterViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.listdaysdataArray.count//3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rowNumber = (self.ALLdataArray[section] as AnyObject).count
        
        return rowNumber!//self.listrowsdataArray.count//self.dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newRunningDetailTableViewCell", for: indexPath) as! newRunningDetailTableViewCell
        
        cell.model = self.ALLdataArray[indexPath.section][indexPath.row] as? newlistRunningModel//self.listrowsdataArray[indexPath.row] as? newlistRunningModel
        
         return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.listrowsdataArray[indexPath.row] as? newlistRunningModel

        
        let sucVC = UIStoryboard.init(name: "RunningDetailSB", bundle: nil).instantiateViewController(withIdentifier: "RunningDetailVC") as! RunningDetailTableViewController
        if let aa = model?.tradeNo{
            sucVC.trandeNoStr = aa
        }
        
        sucVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(sucVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableCell(withIdentifier: "liushuifooterTableViewCell") as! liushuifooterTableViewCell
        
        headerView.model = self.listdaysdataArray[section] as? newlistRunningModel
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.01
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        return 30
        
    }
    
    
}

extension Running_waterViewController{
    
    //流水头 统计
    
    func headerGetNetData(ppara:[String:String]){
        
        var para = ["shopQRCode":shopQRCodeID]
        if ppara != ["":""]{
            para = ppara
        }
        NetworkTools.requestData(type: .post, URLString: tradedaySTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataarray1 = data.value(forKey: "data") as? NSArray{
                
                for (i,j) in dataarray1.enumerated(){
                    
                    if let aa = j as? NSDictionary{
                        
                        
                        if let bb = aa["key"] as? String{
                            if let cc = aa["value"] as? String{
                                if i == 0{
                                    self.headerView.key1Label.text = bb
                                    self.headerView.value1Label.text = cc
                                }
                                if i == 1{
                                    self.headerView.key2Label.text = bb
                                    self.headerView.value2Label.text = cc
                                }
                                if i == 2{
                                    self.headerView.key3Label.text = bb
                                    self.headerView.value3Label.text = cc
                                }
                            }

                        }

                    }
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
    //流水列表
    func listGetNetData(ppara:[String:String]){
        
        
        var para = ["shopQRCode":shopQRCodeID,"pageSize":"50","pageNum":"1"]
        
        if ppara != ["":""]{
            para = ppara
        }
        print(para)
        self.listrowsdataArray.removeAllObjects()
        self.listdaysdataArray.removeAllObjects()
        self.ALLdataArray.removeAll()
        NetworkTools.requestData(type: .post, URLString: tradesearchSTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKeyPath: "data") as? NSDictionary{
                
                if let daysArray = dataDict["days"] as? NSArray{
                    
                    if let daysModelArray = NSArray.yy_modelArray(with: newlistRunningModel.self, json: daysArray){
                        
                        self.listdaysdataArray.addObjects(from: daysModelArray)
                        

                        
                    }
                    
                }
                if let rowsarray = dataDict["rows"] as? NSArray{
                    
                    if let rowsModelArray = NSArray.yy_modelArray(with: newlistRunningModel.self, json: rowsarray){
                        
                        self.listrowsdataArray.addObjects(from: rowsModelArray)
                        
                        
                    }
                    
                }
                
                for j in 0..<self.listdaysdataArray.count{
                    var nnnnarray = NSMutableArray()
                    let model1 = self.listdaysdataArray[j] as? newlistRunningModel
                    let a = ToolManger.transtimeStr(timeStamp: "\((model1?.time)!/1000)", Str: "yy年MM月dd日")
                    for i in 0..<self.listrowsdataArray.count{
                        let model = self.listrowsdataArray[i] as? newlistRunningModel
                        let b = ToolManger.transtimeStr(timeStamp: "\((model?.time)!/1000)", Str: "yy年MM月dd日")
                        
                        if a == b{
                            nnnnarray.addObjects(from: [self.listrowsdataArray[i]])
                        }
                        
                        //                    var sameNumber = 0
                        //                    for j in (i+1)..<self.listrowsdataArray.count{
                        //
                        //
                        //
                        //                    }
                        
                    }
                    self.ALLdataArray.append(nnnnarray as! [newlistRunningModel])
                }
                

                
            }

            if self.listdaysdataArray.count > 0{
                
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
            print(data)
        }) { (error) in
            
            
        }
        
    }
    
    //刷选
    func getNetData(){
        //"9A47A91EEDF735C034C58692E005DB9F"
        NetworkTools.requestData(type: .post, URLString: tradescreeningSTR, parameters: ["shopQRCode":shopQRCodeID,"param":"trade"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            
            if let dataArray1 = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: newRunningModel.self, json: dataArray1){
                    
                    self.headerdataArray.addObjects(from: modelArray)
                    self.pushView.headerdataArray = self.headerdataArray
                    for (i,item) in dataArray1.enumerated(){
                        print(item)
                        if let option = item as? NSDictionary{
                            print(option)
                            if let ModelArray = option["child"] as? NSArray{
                                print("=======\(ModelArray.count)")
                                if let optionArray = NSArray.yy_modelArray(with: newRunningModel.self, json: ModelArray){
                                    
                                    
//                                    self.MindataArray.removeAllObjects()
//                                    self.MindataArray.addObjects(from: optionArray)
                                    var tempArray = [newRunningModel]()
                                    
                                    for j in optionArray{
                                        tempArray.append(j as! newRunningModel)
                                        
//                                        self.TWOdataArray[i].append(j as! newRunningModel)
                                        
                                    }
                                    self.TWOdataArray.append(tempArray)
                                    
                                }
                            
                            }else{
                                 var tempArray = [newRunningModel]()
                                self.TWOdataArray.append(tempArray)
                            }
                            
                        }
                        
                    }
                    self.pushView.twodataArray = self.TWOdataArray

                }
                
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
}


//MARK - 代理
extension Running_waterViewController:ToolBtnProrocol{
    
    func didAction(index:[NSIndexPath]){
        
        print("代理实现")
        print(index)
        self.indexArray = index
        for i in index{
           
            if let item = i as? NSIndexPath{
                
                print(item.row)
                print(item.section)
            }
        }

    }
}


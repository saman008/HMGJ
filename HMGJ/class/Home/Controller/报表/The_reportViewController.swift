//
//  The_reportViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/14.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class The_reportViewController: BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    lazy var headerdataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    var TWOdataArray = [[newRunningModel]]()
    
    var headerreportV:The_reportView!
    var pushView:pushtotailView!
    var tableView:UITableView!
    
    var collectionView:UICollectionView!
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    var indexArray = [NSIndexPath]()
    var timeStr = ""
    var nowDate = NSDate()
    
    
    var value1 = ""
    var value2 = ""
    
    var para = ["shopQRCode":shopQRCodeID]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "报表"
        
        self.headerUI()
        
        self.view.backgroundColor = UIColor.RGBA(242, 242, 242, 0.95)
        
        self.rightAction()
        
        self.shuaxuanUI()
        
       // self.tabUI()
        self.collecUI()
        //获取当前时间
        let now = NSDate()
        self.nowDate = now
        
        self.getNetData()
        self.listgetNetData(ppara: ["":""])
        self.pushView.liushuiorbaobiaoStr = "2"
    }
    
    //头视图
    func headerUI(){
        
        headerreportV = UINib.init(nibName: "The_reportV", bundle: nil).instantiate(withOwner: self, options: nil).first as! The_reportView
        
        headerreportV.frame = CGRect.init(x: 0, y:64, width: ScreenW, height: 216)
        
        headerreportV.cutBtn.addTarget(self, action: #selector(cutAction), for: UIControlEvents.touchUpInside)
        
        headerreportV.addBtn.addTarget(self, action: #selector(addAction), for: UIControlEvents.touchUpInside)
        
        let date = NSDate()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd"
        self.headerreportV.titleLabel.text = "\(dformatter.string(from: date as Date))"
        
        self.view.addSubview(headerreportV)
        
    }
    //tabview
    func tabUI(){
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 280, width: ScreenW, height: ScreenH-280))
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "newRunningDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "newRunningDetailTableViewCell")
        
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        
        self.view.addSubview(tableView)
    }
    //collectionview
    func collecUI(){
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 280, width: ScreenW, height: ScreenH-280), collectionViewLayout: layout)
        // 注册一个cell
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView.register(UINib.init(nibName:"reportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reportCollectionViewCell")

//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.register(UINib.init(nibName: "reportFooterCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reportFooterCollectionViewCell")

        //消除滚动条
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        //设置每一个cell的宽高
        
        collectionView.backgroundColor = UIColor.white
        layout.itemSize = CGSize.init(width: ScreenW/2, height: 140)
        self.view.addSubview(collectionView)
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
    //刷选
    func shuaxuanUI(){
        
        pushView = UINib.init(nibName: "pushtotailV", bundle: nil).instantiate(withOwner: self, options: nil).first as! pushtotailView
        
        pushView.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        
        self.pushView.backgroundColor = UIColor.RGBA(0, 0, 0, 0.4)
        
        self.pushView.delegate = self
        self.pushView.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
    }
    func okAction(){
        
        var Str = ""
        var Str1 = ""
        var Str2 = ""
        for i in indexArray{
            let model = self.headerdataArray[i.section] as? newRunningModel
            let model1 = self.TWOdataArray[i.section][i.row] as? newRunningModel
            
            if let aa = model?.value{
//                if aa == "time"{
//                    if let dd = model1?.value{
//                        Str = "\(dd)," + Str
//                    }
//                }
                if aa == "activity"{
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
        
        if Str1.characters.count != 0{
            para["activity"] = Str1
        }
        
        //员工的参数
        if Str2.characters.count != 0{
            para["cashier"] = Str2
        }
        
        
        if self.pushView.reportAllValue.characters.count != 0{
            para["time"] = self.pushView.reportAllValue
        }
        
        
        self.listgetNetData(ppara: para)
        
//        self.tableView.removeFromSuperview()
//        self.collecUI()
        
        self.pushView.removeFromSuperview()
    }
    
    func cutAction(){
                let dformatter = DateFormatter()
        if self.pushView.reportValue3 == "2"{
            nowDate = self.dateToString(Str: self.headerreportV.titleLabel.text!, Str1: "yyyy-MM")
            nowDate = ToolManger.monthTime(currentDate: nowDate as Date, ii: -1) as NSDate
            dformatter.dateFormat = "yyyy-MM"
        }else{
            nowDate = self.dateToString(Str: self.headerreportV.titleLabel.text!, Str1: "yyyy-MM-dd")
            nowDate = ToolManger.dateTime(currentDate: nowDate as Date, ii: -1) as NSDate
            dformatter.dateFormat = "yyyy-MM-dd"
        }
        
        self.headerreportV.titleLabel.text = "\(dformatter.string(from: nowDate as Date))"
        
        para["time"] = "\(dformatter.string(from: nowDate as Date))"
        self.listgetNetData(ppara: para)
    }
    
    func addAction(){
        
        let dformatter = DateFormatter()
        if self.pushView.reportValue3 == "2"{
            nowDate = self.dateToString(Str: self.headerreportV.titleLabel.text!, Str1: "yyyy-MM")
            nowDate = ToolManger.monthTime(currentDate: nowDate as Date, ii: 1) as NSDate
            dformatter.dateFormat = "yyyy-MM"
        }else{
            nowDate = self.dateToString(Str: self.headerreportV.titleLabel.text!, Str1: "yyyy-MM-dd")
            nowDate = ToolManger.dateTime(currentDate: nowDate as Date, ii: 1) as NSDate
            dformatter.dateFormat = "yyyy-MM-dd"
        }
        self.headerreportV.titleLabel.text = "\(dformatter.string(from: nowDate as Date))"
        para["time"] = "\(dformatter.string(from: nowDate as Date))"
        self.listgetNetData(ppara: para)
//        nowDate = ToolManger.dateTime(currentDate: nowDate as Date, ii: 1) as NSDate
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "yyyy-MM-dd"
//        self.headerreportV.titleLabel.text = "\(dformatter.string(from: nowDate as Date))"
    }
    func dateToString(Str:String,Str1:String) -> NSDate{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Str1
        return dateFormatter.date(from: Str)! as NSDate
       
    }
    
}
extension The_reportViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportCollectionViewCell", for: indexPath) as! reportCollectionViewCell
        
        cell.model = self.dataArray[indexPath.row] as? the_reportModel
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize.init(width: ScreenW, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        
        return CGSize.init(width: ScreenW, height: 0.01)
    }
     //返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reportFooterCollectionViewCell", for: indexPath)
        
        return reusableview
    }
    
}

extension The_reportViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 5//self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newRunningDetailTableViewCell", for: indexPath) as! newRunningDetailTableViewCell
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
}
extension The_reportViewController{
    
    //报表列表
    
    func listgetNetData(ppara:[String:String]){
        var para = ["shopQRCode":shopQRCodeID]
        if ppara != ["":""]{
            para = ppara
        }
        NetworkTools.requestData(type: .post, URLString: reportsearchSTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            self.dataArray.removeAllObjects()
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let timeNum = dataDict["time"] as? Int{
                    if self.pushView.reportValue3 == "2"{
                        self.headerreportV.titleLabel.text = ToolManger.transtimeStr(timeStamp: "\(timeNum/1000)", Str: "yyyy-MM")
                    }else{
                        self.headerreportV.titleLabel.text = ToolManger.transtimeStr(timeStamp: "\(timeNum/1000)", Str: "yyyy-MM-dd")
                    }

                }
                
                if let totalArray = dataDict["total"] as? NSArray{
                    
                    for (i,j) in totalArray.enumerated(){
                        
                        if let aa = j as? NSDictionary{
                            
                            if let bb = aa["key"] as? String{
                                if let cc = aa["value"] as? String{
                                    if i == 0{
                                        self.headerreportV.getMonyLabel1.text = bb
                                        self.headerreportV.getMonyLabel2.text = cc
                                        
                                        
                                    }
                                    if i == 1{
                                        self.headerreportV.sendMonyLabel1.text = bb
                                        self.headerreportV.sendMonyLabel2.text = cc
                                        
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                if let rewardArray = dataDict["reward"] as? NSArray{
                    for (i,j) in  rewardArray.enumerated(){
                        
                        if let aa = j as? NSDictionary{
                            if let bb = aa["key"] as? String{
                                if let cc = aa["value"] as? String{
                                    if i == 0{
                                        self.headerreportV.tradingLabel1.text = bb
                                        self.headerreportV.tradingLabel2.text = cc

                                        
                                    }
                                    if i == 1{
                                        self.headerreportV.rewardLabel1.text = bb
                                        self.headerreportV.rewardLabel2.text = cc

                                        
                                    }
                                    if i == 2{
                                        self.headerreportV.accountLabel1.text = bb
                                        self.headerreportV.accountLabel2.text = cc

                                        
                                    }
                                }
                                
                            }
                        }
                        
                    }
                }
                
                if let payWayDataArray = dataDict["payWayData"] as? NSArray{
                    
                    if let modelpayWayDataArray = NSArray.yy_modelArray(with: the_reportModel.self, json: payWayDataArray){
                        
                        self.dataArray.addObjects(from: modelpayWayDataArray)
                        
                        
                        
                    }
                    
                    
                }
                
            }
            
            
            self.collectionView.reloadData()
            
        }) { (eroor) in
            
            
        }
        
    }
    
    //头文件
    
    //筛选
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: tradescreeningSTR, parameters: ["shopQRCode":shopQRCodeID,"param":"report"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            
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
extension The_reportViewController:PickerDateViewDelegate{
    
    func pick(){
        let pickerDate = WXZPickDateView()
        pickerDate.isAddYetSelect = false
        pickerDate.isShowDay = true
        pickerDate.setDefaultTSelectYear(2017, defaultSelectMonth: 8, defaultSelectDay: 29)
        pickerDate.delegate = self
        pickerDate.show()
    }
    
    func pickerDateView(_ pickerDateView: WXZBasePickView!, selectYear year: Int, selectMonth month: Int, selectDay day: Int) {
        let value = "\(year)-\(month)-\(day)"
        
        if self.value1 == "1"{
            self.headerreportV.titleLabel.text = "\(year)-\(month)-\(day)"
            value2 = "\(year)-\(month)-\(day)"
        }
        if self.value1 == "2"{
            self.headerreportV.titleLabel.text = "\(year)-\(month)"
            value2 = "\(year)-\(month)"
        }
        
        print(year)
        print(month)
        print(day)
        
    }
    
    
    
}
extension The_reportViewController:ToolBtnProrocol{
    
    //    cell.startTimeBtn.addTarget(self, action: #selector(startTimeAction), for: UIControlEvents.touchUpInside)
    //    cell.endTimeBtn.addTarget(self, action: #selector(endTimeAction), for: <#T##UIControlEvents#>)
    func didAction(index:[NSIndexPath]){
         self.indexArray = index
        for i in index{
            
            if i.section == 0{
                
                self.pick()
                if i.row == 0{
                    
                    self.value1 = "1"
                   
                }
                if i.row == 1{
                    
                    self.value1 = "2"
                }
                
            }
            
        }
        print("代理实现")
        print(index)
    }
}


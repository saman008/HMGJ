//
//  messageDetailViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/19.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh


class messageDetailViewController:BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    lazy var MindataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    //二维数组
    
    var TWOdataArray = [[optionsModel]]()

    lazy var aadataArray:NSMutableArray = {
        
       
        
        return NSMutableArray()
    }()
    
    
    var tableView:UITableView!
    var source = ""
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "消息详情"
        
        tableView = UITableView.init(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.register(UINib.init(nibName: "messageDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "messageDetailTableViewCell")
       tableView.register(UINib.init(nibName: "messageDetailstyle1TableViewCell", bundle: nil), forCellReuseIdentifier: "messageDetailstyle1TableViewCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        self.getNetData(page: self.page)
        self.addRefreshView()
        
    }


    
}

extension messageDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.dataArray[indexPath.row] as? messageDetailModel
        
        if model?.style == "1"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageDetailstyle1TableViewCell", for: indexPath) as! messageDetailstyle1TableViewCell
            cell.messageDetailstyle1delegate = self
            cell.model = model
            //cell.titleLabel.text = model?.title
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageDetailTableViewCell", for: indexPath) as! messageDetailTableViewCell
            
            cell.model = model
            cell.messageDetaildelegate = self
            //cell.dataArray = self.MindataArray
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row] as? messageDetailModel
        
        if model?.style == "1"{
            
            
            
        }else{

            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        let model = self.dataArray[indexPath.row] as? messageDetailModel
        if model?.style == "1"{
            
            return 150
        }else{
            let height = 60 * self.TWOdataArray[indexPath.row].count
            
            return CGFloat(200 + height)
        }
        

    }
    
    //添加编辑模式
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    //左滑动出现的文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "删除"
    }
    //删除所做的动作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let model = self.dataArray[indexPath.row] as? messageDetailModel
            
            deleGeteNetData(muid: model!.muid)
            self.dataArray.removeObject(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        
    }
    
    
    
}
//MARK: - 刷新空间
extension messageDetailViewController{
    
    func addRefreshView(){
        
        //1.添加header
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.page = 1
            self.getNetData(page: self.page)
            
        })
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            
            
            self.getNetData(page: self.page)
            
        })
    }
}

extension messageDetailViewController{
    
    func getNetData(page:Int){
        print("============================================\(page)")
        NetworkTools.requestData(type: .post, URLString: searchSourcelSTR, parameters: ["memberId":memberId,"source":source,"pageNumber":"\(page)","pageSize":"10"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            if self.tableView.mj_header.isRefreshing(){
                self.dataArray.removeAllObjects()
                self.TWOdataArray.removeAll()
            }
            self.TWOdataArray.removeAll()
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let modelArray = dataDict["rows"] as? NSArray{
                    
                    
                    if let rowsArray = NSArray.yy_modelArray(with: messageDetailModel.self, json: modelArray){
                        //self.dataArray.removeAllObjects()
                        if let pageNumberStr = dataDict["pageNumber"] as? Int{
                            
                            if self.page == pageNumberStr{
                                 self.dataArray.addObjects(from: rowsArray)
                            }
                            
                        }
                       
                        DispatchQueue.main.async(execute: {
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.mj_footer.endRefreshing()
                            self.tableView.reloadData()
                            self.page += 1
                        })
                        for (i,item) in modelArray.enumerated(){
                            print(item)
                            if let option = item as? NSDictionary{
                                
                                if let ModelArray = option["option"] as? NSArray{
                                    print("=======\(ModelArray.count)")
                                    if let optionArray = NSArray.yy_modelArray(with: optionsModel.self, json: ModelArray){
                                        
                                        self.MindataArray.removeAllObjects()
                                        self.MindataArray.addObjects(from: optionArray)
                                        var tempArray = [optionsModel]()
                                       
                                        for j in optionArray{
                                            tempArray.append(j as! optionsModel)
                                            self.TWOdataArray.append(tempArray)
                                            self.TWOdataArray[i].append(j as! optionsModel)
//                                            self.aadataArray.addObjects(from: tempArray)
//                                            (self.aadataArray[i] as AnyObject).addObjects(from: [j])
                                            //self.aadataArray.addObjects(from: tempArray)
                                            
                                        }
                                        
                                        
                                        
                                    }
                                    
                                }
                                
                            }
                            

                            
                            
                        }

                       // self.tableView.reloadData()

                    }
                    

                    
                }
                
            }
//            DispatchQueue.main.async(execute: {
//                self.tableView.mj_header.endRefreshing()
//                self.tableView.mj_footer.endRefreshing()
//                self.tableView.reloadData()
//                self.page += 1
//            })
            
        }) { (error) in
            
            
        }
        
    }
    
    //删除列表内容
    func deleGeteNetData(muid:String){
        
        NetworkTools.requestData(type: .post, URLString: deleteMessageSTR, parameters: ["memberId":memberId,"muid":muid], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let code = data.value(forKey: "code") as? String{
                
                if code == "0000"{
                    
                    if let msg = data.value(forKey: "msg") as? String{
                        ToolManger.defaultShow(Str: msg, T: self)
                    }
                    
                    // self.tableView.reloadData()
                }
                
            }
            
            
        }) { (eror) in
            
            
        }
        
    }
    
    
}
extension messageDetailViewController:messageDetailstyle1Prorocol,messageDetailProrocol{
    func messageDetailstyle1(url:String){
        
        let webVC = AllWebViewController()
        
        webVC.url = url
        
        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    func messageDetail(url:String){
        let webVC = AllWebViewController()
        
        webVC.url = url
        
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}

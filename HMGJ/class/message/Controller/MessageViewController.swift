//
//  MessageViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh


class MessageViewController:BaseViewController {

    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    var page = 1
    
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        
        tableView = UITableView.init(frame: self.view.bounds)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "messageTableViewCell", bundle: nil), forCellReuseIdentifier: "messageTableViewCell")
        
        tableView.rowHeight = 100
        
        tableView.tableFooterView = UIView()
        
        self.view.addSubview(tableView)

        
        //self.navigationController?.tabBarItem.badgeValue = "11"
       
        
        self.addRefreshView()
        
//        if #available(iOS 10.0, *) {
//            self.navigationController?.tabBarItem.badgeColor = UIColor.red
//        } else {
//            self.navigationController?.tabBarItem.badgeValue = nil
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.getNetData(page: 1)
        
        
    }
    
}

extension MessageViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell", for: indexPath) as! messageTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? messageModel
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.dataArray[indexPath.row] as? messageModel
        
        let messageDetailVC = messageDetailViewController()
        
        messageDetailVC.hidesBottomBarWhenPushed = true
        messageDetailVC.source = model!.source
        self.navigationController?.pushViewController(messageDetailVC, animated: true)
        
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
            
            let model = self.dataArray[indexPath.row] as? messageModel
            
            deleGeteNetData(source: (model?.source)!)
            
            self.dataArray.removeObject(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
        
    }

    
    
}

//MARK: - 刷新空间
extension MessageViewController{
    
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



extension MessageViewController{
    
    func getNetData(page:Int){
        
        
        NetworkTools.requestData(type: .post, URLString: messageSTR, parameters: ["memberId":memberId,"pageNumber":"\(page)"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if self.tableView.mj_header.isRefreshing(){
                self.dataArray.removeAllObjects()
            }
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let rowsArray = dataDict["rows"] as? NSArray{
                    if let array = NSArray.yy_modelArray(with: messageModel.self, json: rowsArray){
                        
                        DispatchQueue.main.async(execute: { 
                            
                            if let pageNumberStr = dataDict["pageNumber"] as? Int{
                                
                                if self.page == pageNumberStr{
                                    self.dataArray.addObjects(from: array)
                                }
                                
                            }
                            
                            self.tableView.mj_header.endRefreshing()
                            self.tableView.mj_footer.endRefreshing()
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
                                self.view.addSubview(label)
                                
                            }
                            
                            self.tableView.reloadData()
                            self.page += 1
                            
                        })
                        
                        
                    }
                }
                
                
            }
            
            
            
            
        }) { (error) in
            
            
            
        }
        
    }
    
    //删除列表内容
    func deleGeteNetData(source:String){
        
        NetworkTools.requestData(type: .post, URLString: deleteSourceSTR, parameters: ["memberId":memberId,"source":source], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
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

//
//  Service_CenterViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class Service_CenterViewController: BaseViewController {

    lazy var dataArray:NSMutableArray={
        
        
        return NSMutableArray()
    }()
    
    var tableView:UITableView!
    let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "天天活动"
        
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH - 40))

        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "daydayActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "daydayActivityTableViewCell")
        
        tableView.rowHeight = 250
//        self.tableView.estimatedRowHeight = 300
//        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.RGBA(242, 242, 242, 0.95)
        self.view.backgroundColor = UIColor.RGBA(242, 242, 242, 0.95)
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         self.getNetData()
        
    }
    
}

extension Service_CenterViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "daydayActivityTableViewCell", for: indexPath) as! daydayActivityTableViewCell
        
        cell.model = self.dataArray[indexPath.row] as? activitychannnelModel
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = self.dataArray[indexPath.row] as? activitychannnelModel
        
        let webVC = AllWebViewController()
        
        if let urlStr = model?.jumpUrl{
            
            
            webVC.url = urlStr
            
            
        }
        webVC.hidesBottomBarWhenPushed = true
        

        self.navigationController?.pushViewController(webVC, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        
//        return UITableViewAutomaticDimension
//        
//    }
    
    
}

extension Service_CenterViewController{
    
    func getNetData(){

        
        NetworkTools.requestData(type: .get, URLString: activitylistSTR, parameters: ["shopQRCode":shopQRCodeID], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.dataArray.removeAllObjects()
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: activitychannnelModel.self, json: data1Array){
                    
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

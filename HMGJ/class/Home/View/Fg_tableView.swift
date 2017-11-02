//
//  Fg_tableView.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/28.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD
import Alamofire


protocol FG_tableviewProrocol : class{
    func didRecleve(index:Int,Str:String)
    
}
protocol The_latest_activityProrocol : class{
    func The_latest_activity()
    
}

class Fg_tableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()

    var No_activity_informationV:No_activity_informationViewView!
    var No_activity_informationV1:No_activity_informationViewView!
    var FGdelegate:FG_tableviewProrocol? = nil
    var The_latest_activitydelegate:The_latest_activityProrocol? = nil
    
    override init(frame: CGRect, style: UITableViewStyle) {
        
        super.init(frame: frame, style: style)
        
        self.dataSource = self
        
        self.delegate = self
        
        self.rowHeight = (ScreenH * 5 - 310) / 20
        
        self.mj_header = MJRefreshHeader.init(refreshingBlock: nil)
        
       //self.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.register(UINib.init(nibName: "The_latest_activityTableViewCell", bundle: nil), forCellReuseIdentifier: "The_latest_activityTableViewCell")
        self.register(UINib.init(nibName: "shopHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "shopHomeTableViewCell")
        No_activity_informationV = UINib.init(nibName: "No_activity_informationView", bundle: nil).instantiate(withOwner: self, options: nil).first as! No_activity_informationViewView
        No_activity_informationV1 = UINib.init(nibName: "No_activity_informationView", bundle: nil).instantiate(withOwner: self, options: nil).first as! No_activity_informationViewView
        
        self.tableFooterView = UIView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContentOffsetY(contentOffsetY:CGFloat){
        
        if self.mj_header.isRefreshing() != false{
            self.contentOffset = CGPoint.init(x: 0, y: contentOffsetY)
        }
        
    }
    
    
    func startRefreshing(){
       
        mj_header.beginRefreshing()
       
        
        
    }
    
    func endRefreshing(){
        self.mj_header.endRefreshing()
    }
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            
            return 1
        }
        
        if self.dataArray.count == 0{
            return 1
        }else{
            return self.dataArray.count
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "The_latest_activityTableViewCell", for: indexPath) as! The_latest_activityTableViewCell
            
            cell.The_latest_activityBtn.addTarget(self, action: #selector(The_latest_activityAction), for: UIControlEvents.touchUpInside)
//            No_activity_informationV.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 200)
//           No_activity_informationV.titleLabel.text = "暂无活动信息"
//            cell.addSubview(No_activity_informationV)
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopHomeTableViewCell", for: indexPath) as! shopHomeTableViewCell
        if self.dataArray.count == 0{
            No_activity_informationV1.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 200)
            No_activity_informationV1.isHidden = false
            cell.addSubview(No_activity_informationV1)
        }else {
            
            No_activity_informationV1.isHidden = true
            
            cell.model = self.dataArray[indexPath.row] as? homeliushuiDetailModel
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 1{
            if self.dataArray.count != 0{
                let model = self.dataArray[indexPath.row] as? homeliushuiDetailModel
                FGdelegate?.didRecleve(index: indexPath.row, Str: model!.tradeNo)
            }
        }
        
        
       

        
        print("点击")
//        let viewVC = touchidViewController()
//        
//        viewVC.hidesBottomBarWhenPushed = true
//
//        let rootViewVC = UIApplication.shared.keyWindow?.rootViewController
//        
//        rootViewVC?.navigationController?.pushViewController(rootViewVC!, animated: true)
//
//        rootViewVC?.present(viewVC, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            
            return 200
        }else{
            
            return 80
        }
        
    }

    
}

extension Fg_tableView{
    
    func The_latest_activityAction(){
        
        The_latest_activitydelegate?.The_latest_activity()
        
    }
    
    
    
}

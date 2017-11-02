//
//  The_latest_activityViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class The_latest_activityViewController: BaseViewController {

    
    var tableView:UITableView!
    var choiceArray = ["全部活动","已加入活动","已结束活动","未加入活动"]
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.title = "活动列表"
        
        tableView = UITableView.init(frame: self.view.bounds)
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableView.rowHeight = 150
        tableView.register(UINib.init(nibName: "The_latest_activityDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "The_latest_activityDetailTableViewCell")
        self.nav2Btn()
    }
    func nav2Btn(){
        
        rightBtn.setImage(UIImage.init(named: "location"), for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.setTitle("刷选", for: UIControlState.normal)
        //rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        rightBtn.contentHorizontalAlignment = .right
        //        let attributeString = NSMutableAttributedString(string: "44678")
        //        attributeString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "成都市", size: 12), range: NSMakeRange(0, 1))
        //        attributeString.addAttribute(NSFontAttributeName, value: RColor, range: NSMakeRange(0, 1))
        //        leftBtn.setAttributedTitle(attributeString, for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    
    func rightActi(){
        let alert = UIAlertController(title: nil, message: "请选择", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        for (_,i) in choiceArray.enumerated(){
            let okAction = UIAlertAction(title: i, style: .default, handler: { (action:UIAlertAction) -> Void in
                
                
                print(i)
                
            })
            alert.addAction(okAction)
        }
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}


extension The_latest_activityViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "The_latest_activityDetailTableViewCell", for: indexPath) as! The_latest_activityDetailTableViewCell
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
}

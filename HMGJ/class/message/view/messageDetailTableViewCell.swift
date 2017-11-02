//
//  messageDetailTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/21.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

protocol messageDetailProrocol : class{
    func messageDetail(url:String)
    
}

class messageDetailTableViewCell: UITableViewCell {

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageDetailMinTableView: UITableView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var view1: UIView!
    
    var messageDetaildelegate:messageDetailProrocol? = nil
    var style = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        messageDetailMinTableView.delegate = self
        messageDetailMinTableView.dataSource = self
        messageDetailMinTableView.register(UINib.init(nibName: "messageDetail2TableViewCell", bundle: nil), forCellReuseIdentifier: "messageDetail2TableViewCell")
        messageDetailMinTableView.register(UINib.init(nibName: "message3TableViewCell", bundle: nil), forCellReuseIdentifier: "message3TableViewCell")
        messageDetailMinTableView.register(UINib.init(nibName: "messageStyleTableViewCell", bundle: nil), forCellReuseIdentifier: "messageStyleTableViewCell")
        messageDetailMinTableView.separatorStyle = .none
        self.view1.layer.borderWidth = 0.5
        self.view1.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        
    }
    var model:messageDetailModel? = nil{
        
        didSet{
            self.titleLabel.text = model?.title
            self.timeLabel.text = model?.time
            self.dataArray = model?.option as! NSMutableArray
            
            self.style = (model?.style)!
            
        }
        
    }

    
    
}

extension messageDetailTableViewCell:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        if self.style == "2"{
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "messageStyleTableViewCell", for: indexPath) as! messageStyleTableViewCell
//            
//            cell.model = self.dataArray[indexPath.row] as? optionsModel
//            
//            return cell
//            
//        }else{
//
//        }
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageDetail2TableViewCell", for: indexPath) as! messageDetail2TableViewCell
            cell.model = self.dataArray[indexPath.row] as? optionsModel
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "message3TableViewCell", for: indexPath) as! message3TableViewCell
        cell.model = self.dataArray[indexPath.row] as? optionsModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row] as? optionsModel
        
        if let url = model?.url{
            
            messageDetaildelegate?.messageDetail(url: url)
        }
        
        
    }

    
    
    
}

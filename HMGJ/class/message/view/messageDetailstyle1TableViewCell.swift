//
//  messageDetailstyle1TableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/23.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

protocol messageDetailstyle1Prorocol : class{
    func messageDetailstyle1(url:String)
    
}

class messageDetailstyle1TableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var minmessagetableView: UITableView!
    
    @IBOutlet weak var view1: UIView!
    
    var messageDetailstyle1delegate:messageDetailstyle1Prorocol? = nil
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        minmessagetableView.delegate = self
        minmessagetableView.dataSource = self

        
        minmessagetableView.register(UINib.init(nibName: "messageStyleTableViewCell", bundle: nil), forCellReuseIdentifier: "messageStyleTableViewCell")
        minmessagetableView.separatorStyle = .none
        
        self.view1.layer.borderWidth = 0.5
        
        self.view1.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        
        
    }
    var model:messageDetailModel? = nil{
        
        didSet{
            self.titleLabel.text = model?.title
            self.timeLabel.text = model?.time
            self.dataArray = model?.option as! NSMutableArray
            
            
        }
        
    }
    
    
}

extension messageDetailstyle1TableViewCell:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageStyleTableViewCell", for: indexPath) as! messageStyleTableViewCell
        cell.model = self.dataArray[indexPath.row] as? optionsModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row] as? optionsModel
        
        if let url = model?.url{
            messageDetailstyle1delegate?.messageDetailstyle1(url: url)
        }
        
        
    }
    
    
    
    
}

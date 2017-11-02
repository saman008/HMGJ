//
//  HomeTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var rewardLabel: UILabel!
    
    @IBOutlet weak var actualAmtLabel: UILabel!
    @IBOutlet weak var goodsLabel: UILabel!
    
    @IBOutlet weak var successLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model:homeliushuiDetailModel? = nil{
        
        didSet{
            
            if let aa = model?.time{
                self.dayLabel.text = ToolManger.transtimeStr(timeStamp: "\(aa/1000)", Str: "MM月dd日")
                self.hourLabel.text = ToolManger.transtimeStr(timeStamp: "\(aa/1000)", Str: "HH:mm")
            }
            
            if let bb = model?.billsMark{
                if let cc = model?.actualAmt{
                    if bb == "1"{
                        self.actualAmtLabel.text = "+" + cc
                    }else{
                        self.actualAmtLabel.text =  "-" + cc
                    }
                }

            }
            
            self.shopNameLabel.text = model?.paywayStr
            
            self.rewardLabel.text = model?.reward
            self.successLabel.text = model?.status
            self.goodsLabel.text = model?.goods
            
        }
        
    }
    
    
}

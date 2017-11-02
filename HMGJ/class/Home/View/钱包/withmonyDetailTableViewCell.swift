//
//  withmonyDetailTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class withmonyDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var moneyLabel: UILabel!
    
    @IBOutlet weak var DetailLabel: UILabel!
    @IBOutlet weak var sucssLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    var model:widthCheckModel? = nil{
        
        didSet{

            if let aa = model?.transDate{
                //20170831185710;
               
                
                let result = ToolManger.strendstart(aa: aa, startInt: 4, endInt: 2)
                let result1 = ToolManger.strendstart(aa: aa, startInt: 6, endInt: 2)
                
                self.hourLabel.text = result + "月" + result1 + "日"
                
                let hour = ToolManger.strendstart(aa: aa, startInt: 8, endInt: 2)
                let min = ToolManger.strendstart(aa: aa, startInt: 10, endInt: 2)
                let m = ToolManger.strendstart(aa: aa, startInt: 12, endInt: 2)
               
                self.dayLabel.text = "\(hour):\(min):\(m)"
                
            }
            
            self.moneyLabel.text = model?.settleAmt
            self.sucssLabel.text = model?.remark
            self.DetailLabel.text = model?.transTypeName
            
        }
        
    }
    
}

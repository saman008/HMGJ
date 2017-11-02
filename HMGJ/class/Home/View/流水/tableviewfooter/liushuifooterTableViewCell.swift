//
//  liushuifooterTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/13.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class liushuifooterTableViewCell: UITableViewCell {

    @IBOutlet weak var tiemLabel: UILabel!
    
    @IBOutlet weak var dealNumLabel: UILabel!
    
    @IBOutlet weak var inSumLabel: UILabel!
    
    @IBOutlet weak var outSumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:newlistRunningModel? = nil{
        
        didSet{
            if let aa = model?.time{
                self.tiemLabel.text = ToolManger.transtimeStr(timeStamp: "\(aa/1000)", Str: "yy年MM月dd日")
            }
            
            if let bb = model?.dealNum{
                self.dealNumLabel.text = "共" + bb + "笔"
            }
            if let cc = model?.inSum{
                self.inSumLabel.text = "收入￥" + cc
            }
            if let dd = model?.outSum{
                 self.outSumLabel.text = "支出￥" + dd
            }
           
            
            
            
        }
        
    }
    
    
}

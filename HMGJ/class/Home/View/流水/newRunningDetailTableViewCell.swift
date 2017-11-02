//
//  newRunningDetailTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/18.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class newRunningDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var paywayStrLabel: UILabel!
    
    @IBOutlet weak var actualAmtLabel: UILabel!
    
    @IBOutlet weak var rewardLabel: UILabel!
    
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var paywayImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    var model:newlistRunningModel? = nil{
        
        didSet{
            
            self.paywayStrLabel.text = model?.shopName
            
            if let dd = model?.paywayImg{
                self.paywayImg.sd_setImage(with: URL.init(string: dd), placeholderImage: nil)
            }
            
            self.actualAmtLabel.text = model?.actualAmt
            
            self.rewardLabel.text = model?.goods
            
            self.statusLabel.text = model?.status
            
            if self.statusLabel.text == "失败"{
                self.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
            }else{
                self.backgroundColor = UIColor.white
            }
            
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
            
            
        }
        
    }

}

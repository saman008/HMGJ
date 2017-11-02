//
//  RunningContentDetailTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class RunningContentDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var keyLabel1: UILabel!
    
    @IBOutlet weak var keyLabel2: UILabel!
    @IBOutlet weak var keyLabel3: UILabel!
    
    @IBOutlet weak var valueLabel1: UILabel!
    @IBOutlet weak var valueLabel2: UILabel!
    @IBOutlet weak var valueLabel3: UILabel!
    
    @IBOutlet weak var allLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
         self.allLabel.isHidden = true
    }


    var model:managerSearchModel? = nil{
        
        didSet{
            
            self.timeLabel.text = model?.time
            
            if let bb = model?.orderStatistics{
                
                for (j,i) in bb.enumerated(){
                    if j >= 3{
                        self.allLabel.isHidden = true
                        if let dd = i as? NSDictionary{
                            if let pp = dd["key"] as? String{
                                if j == 3{
                                    self.keyLabel1.text = pp
                                }else if j == 4{
                                    self.keyLabel2.text = pp
                                }else {
                                    self.keyLabel3.text = pp
                                }
                            }
                            if let mm = dd["value"] as? String{
                                if j == 3{
                                    self.valueLabel1.text = mm
                                }else if j == 4{
                                    self.valueLabel2.text = mm
                                }else {
                                    self.valueLabel3.text = mm
                                }
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
}

//
//  RunningContentView.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class RunningContentView: UIView {

    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var keyLabel1: UILabel!
    
    @IBOutlet weak var keyLabel2: UILabel!
    @IBOutlet weak var keyLabel3: UILabel!
    
    @IBOutlet weak var valueLabel1: UILabel!
    
    @IBOutlet weak var valueLabel2: UILabel!
    
    @IBOutlet weak var valueLabel3: UILabel!
    
    @IBOutlet weak var allLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var model:managerSearchModel? = nil{
        
        didSet{
            
            self.timeLabel.text = model?.time
            
            if let aa = model?.createTime{
                print(ToolManger.transtimeStr(timeStamp: "\(aa/1000)", Str: "yyyy-MM-dd HH:mm:ss"))
            }
            self.rightBtn.isUserInteractionEnabled = false
            self.allLabel.isHidden = false
            if let bb = model?.orderStatistics{
                self.allLabel.isHidden = true
                self.rightBtn.isUserInteractionEnabled = true
                for (j,i) in bb.enumerated(){
                    if j >= 3{
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

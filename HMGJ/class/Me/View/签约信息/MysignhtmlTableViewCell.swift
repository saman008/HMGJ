//
//  MysignhtmlTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/10/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MysignhtmlTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    var model:sigingingModel? = nil{
        
        didSet{
            
            self.titleLabel.text = model?.key
            
            
        }
        
    }
    
    
}

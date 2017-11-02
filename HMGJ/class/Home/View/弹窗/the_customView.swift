//
//  the_customView.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/18.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class the_customView: UIView {

    @IBOutlet weak var titleLabel: UIButton!

    @IBOutlet weak var DetailLabel: UILabel!
    
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var viewDD: UIView!
    
    
    override func draw(_ rect: CGRect) {
        
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 5
        titleLabel.layer.borderColor = UIColor.white.cgColor
        titleLabel.layer.borderWidth = 1
        
        
        viewDD.layer.masksToBounds = true
        viewDD.layer.cornerRadius = 5
        
    }
    
 

}

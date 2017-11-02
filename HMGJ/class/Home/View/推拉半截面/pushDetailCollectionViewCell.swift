//
//  pushDetailCollectionViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/13.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class pushDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var minLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        
    }
    var model:newRunningModel? = nil{
        
        didSet{
            
            self.minLabel.text = model?.key
            
            
        }
        
    }

}

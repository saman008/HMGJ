//
//  reportDanTimeCollectionViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/26.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class reportDanTimeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var daysBtn: UIButton!
    
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var timeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.daysBtn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        
        self.monthBtn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        
        self.timeBtn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
    }

}

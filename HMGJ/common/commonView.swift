//
//  commonView.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/24.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class commonView: UIView {

    override func draw(_ rect: CGRect) {
        
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH)
        self.isUserInteractionEnabled = true
        
        UIApplication.shared.keyWindow?.addSubview(self)
    }
 

}

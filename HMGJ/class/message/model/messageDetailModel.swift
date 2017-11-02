//
//  messageDetailModel.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/19.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class messageDetailModel: ALLMODEL {

    var muid = ""
    var time = ""
    var style = ""
    var title = ""
    var option:NSArray? = nil
    
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        
        return ["option":optionsModel.self]
        
    }
    
}

class optionsModel: ALLMODEL {
    
    var img = ""
    var title = ""
    var url = ""
    var jump = ""
    
    
}

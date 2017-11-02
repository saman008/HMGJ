//
//  managerSearchModel.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/28.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class managerSearchModel:ALLMODEL {

    var time = ""//日期
    //var orderStatistics = ""
    var inCount = ""//收入笔数
    var inSum = ""//收入金额
    var outSum = ""//支出金额
    var outCount = ""//支出笔数
    var rewardCount = ""//奖励笔数
    var rewardSum = ""//奖励金额
    var createTime:Int = 0//系统订单时间

    var orderStatistics:NSArray? = nil
    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        
        return ["orderStatisticsModel":orderStatisticsModel.self]
    }
    
}
class orderStatisticsModel: ALLMODEL {
    
    var key = ""
    var value = ""
    
}

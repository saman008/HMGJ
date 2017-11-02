//
//  storelistModel.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/24.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class storelistModel: ALLMODEL {

    
    var shopCode = ""//店铺编码
    var shopQRCode = ""//店铺二维码
    var shopQRCodeUrl = ""//店铺二维码地址
    var shopName = ""//店铺名
    var shopAlias = ""//店铺简称
    var provinceCode = ""//省
    var cityCode = "" //市
    var countryCode = ""//区
    var shopAddress = ""//店铺地址
    var shopImgUrl = ""//店铺图片地址
    var verifyStatus = ""//审核状态String  0-待审核 1-可用 2-审核中 3-不可用

    var isBoundAccount = ""
    
    var verifyStatusDesc = ""//审核状态描述

}

//
//  extensionClass.swift
//  FunLife
//
//  Created by Forever on 2017/6/20.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit

class extensionClass: NSObject {

}
class BGButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        
        imageView?.contentMode = .center
        //imageView?.contentMode = .scaleAspectFit
        imageView?.image = imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        titleLabel?.textAlignment = .center
        
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        setTitleColor(WColor, for: UIControlState.normal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.width - 50)
        
        titleLabel?.frame = CGRect.init(x: 0, y: self.frame.width - 30, width: self.frame.width, height: self.frame.height - self.frame.width + 10)
        
    }
    
    
    
    
}
extension UIAlertController{
    
    /// 添加一个普通提示框
    ///
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - title: <#title description#>
    static func addNornalAlertController(target: AnyObject, title: String){
        let alertC = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alertC.addAction(action)
        target.present(alertC, animated: true, completion: nil)
    }
    
    /// 添加打电话的提示框
    ///
    /// - Parameters:
    ///   - target: <#target description#>
    ///   - phoneNumber: <#phoneNumber description#>
    static func addPhoneAlertController(target: UIViewController, phoneNumber: String){
        
        let alertC = UIAlertController.init(title: "拨打电话", message: phoneNumber, preferredStyle: .alert)
        
        let OK = UIAlertAction.init(title: "确定", style: .default) { (action) in
            
            UIApplication.shared.openURL(URL.init(string: "tel://" + phoneNumber)!)
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertC.addAction(cancel)
        alertC.addAction(OK)
        
        target.present(alertC, animated: true, completion: nil)
    }
}

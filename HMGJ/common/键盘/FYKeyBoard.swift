//
//  FYKeyBoard.swift
//  KeyBoardDemo
//
//  Created by ios_dev on 2017/7/8.
//  Copyright © 2017年 王飞扬. All rights reserved.
//

import UIKit


protocol FYKeyBoardDelegate: class {
    func showBtnTitle(_ btnTitle: String)
}


let FYKeyBoardTag = 301



class FYKeyBoard: UIView {
    
    // 1. 申明子控件
    //let nameLabel = UILabel()
    //let startTextField = UITextField()
    //let addLabel = UILabel()
    //let endTextField = UITextField()
    let noBtn = UIImageView()
    let intolabel = UILabel()
    var password = SYPasswordView()
    let forgetBtn = UILabel()
    
    var prefix: String!
    weak var delegate: FYKeyBoardDelegate?
    
    // 2.添加子视图
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        noBtn.tag = FYKeyBoardTag + 0
        
        
        noBtn.image = UIImage.init(named: "关闭")
        noBtn.contentMode = .scaleAspectFit
        noBtn.backgroundColor = UIColor.white
        self.addSubview(noBtn)
        
        intolabel.textAlignment = .right
        intolabel.text = "请输入支付密码"
        intolabel.backgroundColor = UIColor.white
        self.addSubview(intolabel)
        
        password.tag = FYKeyBoardTag + 1
        password.backgroundColor = UIColor.white
        self.addSubview(password)
        
        
        //forgetBtn.tag = FYKeyBoardTag + 2
        forgetBtn.text = "忘记密码"
        forgetBtn.textColor = rColor
        forgetBtn.textAlignment = .right
        forgetBtn.backgroundColor = UIColor.white
        self.addSubview(forgetBtn)
        self.backgroundColor = UIColor.white
        
        let btnTitlesArray = ["1","2","3","4","5","6","7","8","9",".","0","x"]
        for item in btnTitlesArray {
            // 创建按钮
            let btn = UIButton()
            // 设置title 
            btn.setTitle(item, for: UIControlState())
            btn.setTitleColor(UIColor.black, for: UIControlState())
            // 设置边框颜色
            btn.layer.borderColor = UIColor.black.cgColor
            // 设置边框宽度
            btn.layer.borderWidth = 0.5
            btn.backgroundColor = UIColor.white
            
            // 添加点击事件
            btn.addTarget(self, action: #selector(FYKeyBoard.btnAction(_:)), for: .touchUpInside)
            // 添加到界面上
            self.addSubview(btn)
            
        }

    }
    // MARK: 只要在视图中重写/创建了构造方法，那么这个方法必须实现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    func btnAction(_ btn: UIButton) {
        print(btn.currentTitle!)
        self.delegate?.showBtnTitle(btn.currentTitle!)
    }
    override func layoutSublayers(of layer: CALayer) {
        
        // keyBoard的宽
        let keyWidth = UIScreen.main.bounds.width
        // keyBoard的高
        let keyHeight = self.frame.size.height
        
        // 间距
        let margin: CGFloat = 10
        
        //忘记密码
        //输入框密码
        //请输入支付密码
        //关闭
        
        //关闭
        let startTextField_X = margin
        let startTextField_Y = margin
        let startTextField_W:CGFloat = 30
        let startTextField_H:CGFloat = 21
        noBtn.frame = CGRect.init(x: startTextField_X, y: startTextField_Y, width: startTextField_W, height: startTextField_H)
        //请输入支付密码
        
        let addLabel_Y = margin
        let addLabel_W: CGFloat = 150
        let addLabel_H:CGFloat = 21
        let addLabel_X = ScreenW - margin - addLabel_W
        intolabel.frame = CGRect.init(x: addLabel_X, y: addLabel_Y, width: addLabel_W, height: addLabel_H)
         //输入框密码
        let nameLabel_X:CGFloat = 2 * margin
        let nameLabel_Y: CGFloat = 2 * margin + 21
        let nameLabel_W = ScreenW - 4 * margin
        let nameLabel_H:CGFloat = 120
        //password.frame = CGRect(x: nameLabel_X, y: nameLabel_Y, width: nameLabel_W, height: nameLabel_H)
        self.password = SYPasswordView(frame: CGRect(x: nameLabel_X, y: nameLabel_Y, width: nameLabel_W, height: nameLabel_H))
        //忘记密码

        
        let endTextField_Y = nameLabel_Y + nameLabel_H + 2 * margin
        let endTextField_W:CGFloat = 100
        let endTextField_H:CGFloat = 21
        let endTextField_X = ScreenW - margin - endTextField_W
        forgetBtn.frame = CGRect(x: endTextField_X, y: endTextField_Y, width: endTextField_W, height: endTextField_H)
        

        
        // 按钮的宽度
        let button_W = keyWidth / 3
        // 按钮的高度
        let button_H = keyHeight / 7
        
        // 设置变量 确定当前第几个Button
        var i = 0
        
        for item in self.subviews {
        
            if item.isKind(of: UIButton.self) {
                
                let btn = item as! UIButton
                btn.setTitleColor(UIColor.white, for: UIControlState.normal)
                btn.backgroundColor = UIColor.gray
                if btn.titleLabel?.text == "." || btn.titleLabel?.text == "x"{
                    btn.backgroundColor = UIColor.black
                    
                }
                let button_X = button_W * CGFloat(i % 3)
                let button_Y = button_H * CGFloat(i / 3) + endTextField_H + endTextField_Y + margin
                
                btn.frame = CGRect(x: button_X, y: button_Y, width: button_W, height: button_H)
                
                // 找到1个按钮，i+1
                i += 1
                
            }
        }
    }


}

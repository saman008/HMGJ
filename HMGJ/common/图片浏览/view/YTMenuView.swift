//
//  YTMenuView.swift
//  MovieFansDemo1
//
//  Created by 余婷 on 16/10/9.
//  Copyright © 2016年 余婷. All rights reserved.
//

import UIKit

//MARK: - 菜单协议
protocol YTMenuViewDelegate {
    
    func cellDidSeleted(index:NSIndexPath)
}

class YTMenuView: UIView {

    //MARK： - 第一步,声明所有的子视图
    //1.背景
    let bgImageView = UIImageView()
    //2.tableView
    let tableView = UITableView()
    
    //3.数据源数组
    var dataArray:[(String,String)] = [(String,String)]()
    //4.代理属性
    var delegate:YTMenuViewDelegate? = nil
    
    
    //MARK: - 第二步,在构造方法中将子视图对象添加到视图上
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //1.背景
        self.addSubview(self.bgImageView)
        self.bgImageView.image = UIImage.init(named: "menu.png")
        //2.tableView
        self.addSubview(self.tableView)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //关闭滚动
        self.tableView.isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 单例对象
    static let defaultMenuView = YTMenuView()
    
    
    //MARK: - 第三步,计算frame
    override func layoutSubviews() {
        
        let headerH:CGFloat = 15
        let W = self.frame.size.width
        let H = self.frame.size.height
        //1.背景
        self.bgImageView.frame = self.bounds
        //2.tableView
        self.tableView.frame = CGRect.init(x: 0, y: headerH, width: W, height: H-headerH)
    }
  

}

extension YTMenuView{

    //显示菜单
    func showMenu(animated:Bool) {
        
        self.isHidden = false
        
        
        
        //没有动画效果
       
        self.tableView.frame = CGRect.init(x: 0, y: 15, width: self.frame.size.width, height: self.frame.size.height-15)
        self.bgImageView.frame.size.height = self.frame.size.height
        
    }
    
    ///隐藏菜单
    func disappearMenu(animated:Bool){
       
        
        //没有动画效果
        
        self.tableView.frame = CGRect.init(x: 0, y: 15, width: self.frame.size.width, height: 0)
        self.bgImageView.frame.size.height = 0
        self.isHidden = true
    }
    
}

//MARK: - tableView 协议方法
extension YTMenuView:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //创建cell
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
            //文字颜色
            cell!.textLabel?.textColor = UIColor.white
            //文字大小
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
            //背景颜色
            cell!.backgroundColor = UIColor.clear
            //取消选中效果
            cell?.selectionStyle = .none
        }
        //刷新数据
        let data = self.dataArray[indexPath.row]
        cell!.imageView?.image = UIImage.init(named: data.1)
        cell!.textLabel?.text = data.0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //通知代理，cell被选中了
        self.delegate?.cellDidSeleted(index: indexPath as NSIndexPath)
    }
    
}

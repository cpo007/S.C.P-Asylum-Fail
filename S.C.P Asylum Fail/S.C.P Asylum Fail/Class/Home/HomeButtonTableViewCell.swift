//
//  HomeButtonTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import SnapKit

enum buttonType:NSInteger {
    case left = 101
    case right = 102
}

class HomeButtonTableViewCell: BaseTableViewCell {

    var leftButton:UIButton?
    var rightButton:UIButton?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        leftButton?.frame = CGRect(x: 0, y: 0, width: frame.width / 5 * 3, height: 58)
//        rightButton?.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 5 * 3, height: 58)
    }
    func setupUI() {
        let leftButton = getNormalButton(self, action: #selector(HomeButtonTableViewCell.buttonDidClick(_:)), Title: "Test", font: nil, color: nil, tag: buttonType.left.rawValue)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        leftButton.titleLabel?.numberOfLines = 0
        addSubview(leftButton)
        self.leftButton = leftButton
        
        let rightButton = getNormalButton(self, action: #selector(HomeButtonTableViewCell.buttonDidClick(_:)), Title: "Test", font: nil, color: nil, tag: buttonType.right.rawValue)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightButton.titleLabel?.numberOfLines = 0
        addSubview(rightButton)
        self.rightButton = rightButton
        
        leftButton.snp.makeConstraints { (make) in
//            make.edges.equalTo(UIEdgeInsets(top: 10, left: 12, bottom: -10, right: -12)
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self.snp.centerX).offset(-12)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
        rightButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-12)
            make.leading.equalTo(self.snp.centerX).offset(12)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
    func buttonDidClick(_ sender: UIButton) {
        isUserInteractionEnabled = false
        sender.isSelected = true
        switch sender.tag {
        case buttonType.left.rawValue :
            print("左键点击:\(theText?.LeftButton?.Branch)")
            rightButton?.isEnabled = false
            break
        case buttonType.right.rawValue :
            print("右键点击:\(theText?.RightButton?.Branch)")
            leftButton?.isEnabled = false
            break
        default :
            break
        }
        buttonDidClickBlock?(sender.tag as NSNumber?)
    }
    
    override func updateResource(_ theText: TheText) {
        super.updateResource(theText)
        
        isUserInteractionEnabled = true
        leftButton?.isEnabled = true
        leftButton?.isSelected = false
        rightButton?.isEnabled = true
        rightButton?.isSelected = false

        leftButton?.setTitle(theText.LeftButton?.Text, for: UIControlState())
        rightButton?.setTitle(theText.RightButton?.Text, for: UIControlState())
        
        if let is1 = theText.LeftButton?.isSelectod , let is2 = theText.RightButton?.isSelectod {
            if is1 || is2 {
                isUserInteractionEnabled = false
                if is1 {
                    leftButton?.isSelected = true
                    rightButton?.isEnabled = false
                } else if is2 {
                    rightButton?.isSelected = true
                    leftButton?.isEnabled = false
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//
//  HomeButtonTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

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
        leftButton?.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: frame.height)
        rightButton?.frame = CGRect(x: frame.width / 2, y: 0, width: frame.width / 2, height: frame.height)
    }
    func setupUI() {
        let leftButton = getNormalButton(self, action: #selector(HomeButtonTableViewCell.buttonDidClick(_:)), Title: "Test", font: nil, color: nil, tag: buttonType.left.rawValue)
        leftButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        leftButton.titleLabel?.numberOfLines = 0
        addSubview(leftButton)
        self.leftButton = leftButton
        
        let rightButton = getNormalButton(self, action: #selector(HomeButtonTableViewCell.buttonDidClick(_:)), Title: "Test", font: nil, color: nil, tag: buttonType.right.rawValue)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        rightButton.titleLabel?.numberOfLines = 0
        addSubview(rightButton)
        self.rightButton = rightButton
    }
    
    func buttonDidClick(sender: UIButton) {
        userInteractionEnabled = false
        sender.selected = true
        switch sender.tag {
        case buttonType.left.rawValue :
            print("左键点击:\(theText?.LeftButton?.Branch)")
            rightButton?.enabled = false
            break
        case buttonType.right.rawValue :
            print("右键点击:\(theText?.RightButton?.Branch)")
            leftButton?.enabled = false
            break
        default :
            break
        }
        buttonDidClickBlock?(buttonTag: sender.tag)
    }
    
    override func updateResource(theText: TheText) {
        super.updateResource(theText)
        
        userInteractionEnabled = true
        leftButton?.enabled = true
        leftButton?.selected = false
        rightButton?.enabled = true
        rightButton?.selected = false

        leftButton?.setTitle(theText.LeftButton?.Text, forState: UIControlState.Normal)
        rightButton?.setTitle(theText.RightButton?.Text, forState: UIControlState.Normal)
        
        if let is1 = theText.LeftButton?.isSelectod , is2 = theText.RightButton?.isSelectod {
            if is1 || is2 {
                userInteractionEnabled = false
                if is1 {
                    leftButton?.selected = true
                    rightButton?.enabled = false
                } else if is2 {
                    rightButton?.selected = true
                    leftButton?.enabled = false
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

//
//  HomeOneButtonTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/22.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class HomeOneButtonTableViewCell: BaseTableViewCell {

    var theButton:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        theButton?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    func setupUI() {
        let theButton = getNormalButton(self, action: #selector(HomeButtonTableViewCell.buttonDidClick(_:)), Title: "Test", font: nil, color: nil, tag: buttonType.left.rawValue)
        theButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        theButton.titleLabel?.numberOfLines = 0
        addSubview(theButton)
        self.theButton = theButton
        
    }
    
    func buttonDidClick(sender: UIButton) {
        buttonDidClickBlock?(buttonTag: nil)
    }
    
    override func updateResource(theText: TheText) {
        super.updateResource(theText)
        theButton?.setTitle(theText.Text, forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

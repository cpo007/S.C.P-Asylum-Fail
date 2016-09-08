//
//  BaseTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/22.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var theText:TheText?
    var buttonDidClickBlock:((buttonTag:NSNumber?)->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = defultColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateResource(theText:TheText) {
        self.theText = theText
    }

}

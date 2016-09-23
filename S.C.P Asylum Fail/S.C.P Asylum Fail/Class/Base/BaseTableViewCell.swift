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
    var theStoryLine:TheStoryLine?

    var buttonDidClickBlock:((_ buttonTag:NSNumber?)->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateResource(_ theText:TheText) {
        self.theText = theText
    }
    
    func updateResourece(theStoryLine:TheStoryLine) {
        self.theStoryLine = theStoryLine
    }
    
    func setCellBackground() {
        self.backgroundView = UIImageView(image: UIImage(named: "CellBackground"))
    }

}

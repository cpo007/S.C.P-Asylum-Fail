//
//  StartTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class StartTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var upLine: UIView!
    @IBOutlet weak var downLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func updateResourece(theStoryLine: TheStoryLine) {
        super.updateResourece(theStoryLine: theStoryLine)
        if let centerNode = theStoryLine.CenterNode {
            if centerNode.IsEnd {
                downLine.isHidden = true
            } else {
                upLine.isHidden = true
            }
        }
    }
    
}

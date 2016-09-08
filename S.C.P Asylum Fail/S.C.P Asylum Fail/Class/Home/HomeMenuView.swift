//
//  HomeMenuView.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class HomeMenuView: UIView {

    var buttonDidClickBlock:((tag:Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func buttonDidClick(sender: UIButton) {
        buttonDidClickBlock?(tag: sender.tag)
    }

}

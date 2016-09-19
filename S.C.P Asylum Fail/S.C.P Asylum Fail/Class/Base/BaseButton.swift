//
//  BaseButton.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/19.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

}

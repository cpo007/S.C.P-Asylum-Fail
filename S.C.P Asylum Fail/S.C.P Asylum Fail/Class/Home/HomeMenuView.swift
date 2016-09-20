//
//  HomeMenuView.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

enum HomeMenuButtonStyle:NSInteger {
    case dismiss = 200
    case gotoArchives = 201
    case gotoWorldLine = 202
    case quickMode = 203
    case getScore = 204
}
class HomeMenuView: UIView {

    
    @IBOutlet weak var quickModeButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    
    var buttonDidClickBlock:((_ tag:Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let isQuick = UserDefaults.standard.bool(forKey: "isQuick")
        if isQuick {
            quickModeButton.setTitle("正常模式", for: .normal)
        } else {
            quickModeButton.setTitle("快速模式", for: .normal)
        }
        
    }
    
    @IBAction func buttonDidClick(_ sender: UIButton) {
        switch sender.tag {
        case HomeMenuButtonStyle.quickMode.rawValue :
            let isQuick = UserDefaults.standard.bool(forKey: "isQuick")
            if isQuick {
                quickModeButton.setTitle("快速模式", for: .normal)
            } else {
                quickModeButton.setTitle("正常模式", for: .normal)
            }
            UserDefaults.standard.set(!isQuick, forKey: "isQuick")
            break
        default :
            break
        }
        buttonDidClickBlock?(sender.tag)
    }

}

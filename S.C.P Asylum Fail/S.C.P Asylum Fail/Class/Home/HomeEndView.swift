//
//  HomeEndView.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/19.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class HomeEndView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func dismiss(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { (isSuccess) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func gotoNewStory(_ sender: AnyObject) {
        print("打开Flag图")
    }
    
    @IBAction func gotoAppStore(_ sender: AnyObject) {
        print("评分")
    }
    
}

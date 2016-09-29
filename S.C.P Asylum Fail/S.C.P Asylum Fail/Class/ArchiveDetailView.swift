//
//  ArchiveDetailView.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/29.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class ArchiveDetailView: UIView,UIScrollViewDelegate {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var asylumMeasures: UILabel!
    
    func updateResource(theProject: TheProject) {
        icon.image = UIImage(named: theProject.Icon ?? "")
        number.text = theProject.Number
        level.text = theProject.Level
        describe.text = theProject.Describe
        asylumMeasures.text = theProject.AsylumMeasures
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.alpha = 0
            }) { (isSuccess) in
                self.removeFromSuperview()
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -40 {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame.origin = CGPoint(x: 0, y:  Height)
                }, completion: { (isSuccess) in
                    self.removeFromSuperview()
            })
        }
    }
    
}

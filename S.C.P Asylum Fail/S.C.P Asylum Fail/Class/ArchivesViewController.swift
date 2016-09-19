//
//  ArchivesViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import Koloda

class ArchivesViewController: BaseViewController {

    var theArchivesArray = [TheArchives]()
    var kolaView:KolodaView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResource()
        kolaView = KolodaView(frame: CGRect(x: 0, y: 0, width: Width * 2 / 3, height: Height * 2 / 3))
        kolaView?.center = view.center
        view.addSubview(kolaView!)
        kolaView?.delegate = self
        kolaView?.dataSource = self
    }
 
    //初始化S.C.P档案
    func setupResource() {
        guard let path = Bundle.main.path(forResource: "Archives", ofType: "plist") else { return }
        guard let arr = NSArray(contentsOfFile: path) as? [AnyObject] else { return }
        for dict in arr {
            guard let dict = dict as? [String:AnyObject] else { return }
            let theArchives = TheArchives(dict: dict)
            theArchivesArray.append(theArchives)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArchivesViewController: KolodaViewDelegate,KolodaViewDataSource {
    func kolodaNumberOfCards(_ koloda:KolodaView) -> UInt {
        return UInt(theArchivesArray.count)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAtIndex index: UInt) -> UIView {
        let archive = theArchivesArray[Int(index)]
        
        return UIImageView(image: UIImage(named: archive.Icon ?? ""))
    }
    
    func koloda(koloda: KolodaView, viewForCardOverlayAtIndex index: UInt) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView",
                                                  owner: self, options: nil)?[0] as? OverlayView
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAtIndex index: UInt) {
        guard let endView = Bundle.main.loadNibNamed("ArchiveDetailView", owner: nil, options: nil)?.last as? UIView else { return }
        endView.frame = Bounds
        endView.alpha = 0
        view.addSubview(endView)
        UIView.animate(withDuration: 0.3, animations: {
            endView.alpha = 1
        })

    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
    }

}

//
//  ArchivesViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class ArchivesViewController: BaseViewController {

    var theArchivesArray = [TheArchives]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupResource()
//        let epDocumentView = EPDocumentBaseView(frame: view.frame, array: theArchivesArray)
//        let tap = UITapGestureRecognizer(target: self, action: #selector(ArchivesViewController.viewDidClick))
//        epDocumentView.addGestureRecognizer(tap)
//        view.addSubview(epDocumentView)
    }
    
    func viewDidClick() {
        let vc = ArchiveDetailViewController(CityName: "asdas")
        present(vc, animated: true, completion: nil)
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

//
//  ArchiveDetailViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/8.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class ArchiveDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //菜单选项
//        let detailView = NSBundle.mainBundle().loadNibNamed("ArchiveDetailView", owner: nil, options: nil).first as? UIView
//        print(detailView)
//        view.addSubview(detailView!)
//        detailView?.snp_makeConstraints(closure: { (make) in
//            make.edges.equalTo(view)
//        })

    }
    
    convenience init(CityName:String){
        self.init()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


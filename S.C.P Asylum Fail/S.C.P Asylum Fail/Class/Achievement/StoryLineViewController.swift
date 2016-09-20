//
//  StoryLineViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class StoryLineViewController: BaseViewController {
    
    var tableView:HomeTableView?
    var theStoryLineArray = [AnyObject]()
    
    let startIdentifier = "startIdentifier"
    let processIdentifier = "processIdentifier"
    let endIdentifier = "endIdentifier"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupResource()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        
        //主体TableView
        tableView = HomeTableView(frame: CGRect(x: 20, y: 20, width: Width - 40, height: Height - 50))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.showsVerticalScrollIndicator = false
        view.addSubview(tableView!)
        
        tableView?.register(UINib(nibName: "StartTableViewCell", bundle: nil), forCellReuseIdentifier: startIdentifier)
        tableView?.register(UINib(nibName: "ProcessTableViewCell", bundle: nil), forCellReuseIdentifier: processIdentifier)
        tableView?.register(UINib(nibName: "EndTableViewCell", bundle: nil), forCellReuseIdentifier: endIdentifier)
        
    }
    
    //初始化数据，数据为固定值，若用户从未使用过则从plist读取并且存档，之后的改动都从存档中更改
    func setupResource() {
//        if let theStoryArry = reloadData().theStoryArry, let theTextArray = reloadData().theTextArry {
//            self.theStoryArray = theStoryArry
//            self.theTextArray = theTextArray
//            storyCount = theStoryArry.count
//        } else {
//            guard let path = Bundle.main.path(forResource: "Prologue", ofType: "plist") else { return }
//            guard let dict = NSDictionary(contentsOfFile: path) as? [String:[AnyObject]] else { return }
//            guard let arr = dict["Branch101"] as? [[String:AnyObject]] else { return }
//            for dic in arr{
//                let theText = TheText(dict: dic)
//                theTextArray.append(theText)
//            }
//        }
//        
    }

}

extension StoryLineViewController: UITableViewDataSource,UITableViewDelegate {
    
    //tableViewDelegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: startIdentifier) as? StartTableViewCell
            return cell!
        } else if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: endIdentifier) as? EndTableViewCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: processIdentifier) as? ProcessTableViewCell
            return cell!
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

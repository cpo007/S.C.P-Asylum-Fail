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
    var theStoryLineArray = [TheStoryLine]()
    var reloadStory: ((TheStoryNode)->())?
    
    
    let startIdentifier = "startIdentifier"
    let processIdentifier = "processIdentifier"

    convenience init(theStoryLineArray:[TheStoryLine]) {
        self.init()
        self.theStoryLineArray = theStoryLineArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

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
        
    }

}

extension StoryLineViewController: UITableViewDataSource,UITableViewDelegate {
    
    //tableViewDelegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theStoryLineArray.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theStorLine = theStoryLineArray[indexPath.row]
        if theStorLine.Style == 101 {
            let cell = tableView.dequeueReusableCell(withIdentifier: startIdentifier) as? StartTableViewCell
            cell?.updateResourece(theStoryLine: theStorLine)
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: processIdentifier) as? ProcessTableViewCell
            cell?.updateResourece(theStoryLine: theStorLine)
            cell?.nodeDidClick = { [weak self] node in
                guard let detailView = Bundle.main.loadNibNamed("StoryLineDetailsView", owner: nil, options: nil)?.first as? StoryLineDetailsView else { return }
                detailView.alpha = 0
                detailView.frame = Bounds
                detailView.updateDetailsView(theStoryNode: node)
                self?.view.addSubview(detailView)
                UIView.animate(withDuration: 0.3, animations: { 
                    detailView.alpha = 1
                })
                detailView.reloadButtonDidClick = {
                    self?.navigationController?.popViewController(animated: true)
                    self?.reloadStory?(node)
                }
                
            }
            return cell!
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

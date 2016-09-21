//
//  StoryLineDetailsView.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/21.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class StoryLineDetailsView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var theStoryNode: TheStoryNode?
    var reloadButtonDidClick: (()->())?
    
   
    override func awakeFromNib() {
        
    }
    
    //从节点获得详细数据，包括标题、详情及更新故事线按钮逻辑
    func updateDetailsView(theStoryNode: TheStoryNode) {
        self.theStoryNode = theStoryNode
        titleLabel.text = theStoryNode.Title
        detailLabel.text = theStoryNode.Detail
    }

    
    @IBAction func dismissButtonDidClick(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
            }) { [weak self] (isSuccess) in
                self?.removeFromSuperview()
        }
    }

    @IBAction func reloadStoryButtonDidClick(_ sender: AnyObject) {
        reloadButtonDidClick?()
        
    }
}

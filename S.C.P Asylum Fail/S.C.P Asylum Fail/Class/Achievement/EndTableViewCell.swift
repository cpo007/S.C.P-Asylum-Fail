//
//  EndTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class EndTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var centerLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftEndButton: UIButton!
    @IBOutlet weak var centerEndButton: NSLayoutConstraint!
    @IBOutlet weak var rightEndButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

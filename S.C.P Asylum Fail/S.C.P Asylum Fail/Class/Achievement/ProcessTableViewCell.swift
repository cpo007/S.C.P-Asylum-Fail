//
//  ProcessTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class ProcessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftConnectLine: UIView!
    @IBOutlet weak var rightConnectLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var centerLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftProcessButton: UIButton!
    @IBOutlet weak var centerProcessButton: UIButton!
    @IBOutlet weak var rightProcessButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

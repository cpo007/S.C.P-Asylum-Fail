//
//  HomeDialogueTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/22.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import SnapKit

class HomeDialogueTableViewCell: BaseTableViewCell {

    var textLbl:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        setCellBackground()
        let textLbl = getLabel(text: "Test", font: UIFont.systemFont(ofSize: 14), color: ColorBlue())
        addSubview(textLbl)
        self.textLbl = textLbl
        textLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
        }
    }
    
    override func updateResource(_ theText: TheText) {
        super.updateResource(theText)
        textLbl?.text = theText.Text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

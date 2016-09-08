//
//  HomeNormalTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class HomeInstructionsTableViewCell: BaseTableViewCell {

    var textLbl:UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textLbl?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    func setupUI() {
        let textLbl = getLabel(text: "Tesasdasdasdasdast", font: UIFont.systemFontOfSize(14), color: ColorYellow())
        textLbl.textAlignment = .Center
        addSubview(textLbl)
        self.textLbl = textLbl
    }
    
    override func updateResource(theText: TheText) {
        super.updateResource(theText)
        textLbl?.text = theText.Text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

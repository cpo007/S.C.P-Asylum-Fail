//
//  HomeEndTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/8.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class HomeEndTableViewCell: BaseTableViewCell {

    var endBlock:(()->())?
    var textLbl:UILabel?
    var endButton:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        endButton?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    func setupUI() {
        endButton =  getNormalButton(self, action: #selector(HomeEndTableViewCell.buttonDidClick), Title: "Test")
        addSubview(endButton!)
        
//        let textLbl = getLabel(text: "Tesasdasdasdasdast", font: UIFont.systemFont(ofSize: 14), color: ColorYellow())
//        textLbl.textAlignment = .center
//        addSubview(textLbl)
//        self.textLbl = textLbl
    }
    
    func buttonDidClick() {
        endBlock?()
    }
    
    override func updateResource(_ theText: TheText) {
        super.updateResource(theText)
        endButton?.setTitle(theText.Text, for: UIControlState.normal)
//        textLbl?.text = theText.Text
//        let delay = DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
//        DispatchQueue.main.asyncAfter(deadline: delay) { [weak self] in
//            self?.endBlock?()
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

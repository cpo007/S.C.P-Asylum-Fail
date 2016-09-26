//
//  ProcessTableViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import SnapKit

class ProcessTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var leftConnectLine: UIView!
    @IBOutlet weak var rightConnectLine: UIView!
    @IBOutlet weak var leftLine: UIView!
    @IBOutlet weak var centerLine: UIView!
    @IBOutlet weak var rightLine: UIView!
    @IBOutlet weak var leftLine2: UIView!
    @IBOutlet weak var rightLine2: UIView!
    
    @IBOutlet weak var leftProcessButton: UIButton!
    @IBOutlet weak var centerProcessButton: UIButton!
    @IBOutlet weak var rightProcessButton: UIButton!
    
    @IBOutlet weak var leftLineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightLineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerLineTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerLineBottomConstraint: NSLayoutConstraint!
    
    var nodeDidClick:((TheStoryNode)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func updateResourece(theStoryLine: TheStoryLine) {
        super.updateResourece(theStoryLine: theStoryLine)
        
        if theStoryLine.Style == 101, theStoryLine.CenterNode != nil {
            leftConnectLine.isHidden = true
            leftLine.isHidden = true
            leftLine2.isHidden = true
            leftProcessButton.isHidden = true
            
            rightConnectLine.isHidden = true
            rightLine.isHidden = true
            rightLine2.isHidden = true
            rightProcessButton.isHidden = true
            
            centerLineTopConstraint.constant = 100

            return
        }
        
        if theStoryLine.CenterNode == nil {
            centerProcessButton.isHidden = true
        }
        if theStoryLine.LeftNode == nil {
            leftProcessButton.isHidden = true
            leftLine.isHidden = true
            leftLine2.isHidden = true
            leftConnectLine.isHidden = true
        }
        if theStoryLine.RightNode == nil {
            rightProcessButton.isHidden = true
            rightLine.isHidden = true
            rightLine2.isHidden = true
            rightConnectLine.isHidden = true
        }
        
        if let leftNode = theStoryLine.LeftNode {

            if leftNode.IsEnd {
                if leftNode.JustOne {
                    leftLine.isHidden = true
                } else {
                    leftConnectLine.isHidden = true
                }
                leftLine2.isHidden = true
            } else {
                leftLine.isHidden = true
            }
            if !leftNode.HasActivate {
                setupKeepOutView(button: leftProcessButton)
            }
        }
        if let rightNode = theStoryLine.RightNode {
            if rightNode.IsEnd {
                if rightNode.JustOne {
                    rightLine.isHidden = true
                } else {
                    rightConnectLine.isHidden = true
                }
                rightLine2.isHidden = true
            } else {
                rightLine.isHidden = true
            }
            if !rightNode.HasActivate {
                setupKeepOutView(button: rightProcessButton)
            }
            
        }
        
        if let centerNode = theStoryLine.CenterNode {
            if centerNode.IsEnd {
                centerLineBottomConstraint.constant = 100
            }
            if !centerNode.HasActivate {
                setupKeepOutView(button: centerProcessButton)
            }
        }

        
    }
    
    func setupKeepOutView(button:UIButton) {
        let view = UIView()
        view.backgroundColor = defultColor()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 55, height: 55))
            make.center.equalTo(button)
        }
    }
    
    @IBAction func centerButtonDidClick(_ sender: AnyObject) {
        nodeDidClick?(theStoryLine!.CenterNode!)
    }
    
   
    @IBAction func rightButtonDidClick(_ sender: AnyObject) {
        nodeDidClick?(theStoryLine!.RightNode!)

    }
   
    @IBAction func leftButtonDidClick(_ sender: AnyObject) {
        nodeDidClick?(theStoryLine!.LeftNode!)
    }

}

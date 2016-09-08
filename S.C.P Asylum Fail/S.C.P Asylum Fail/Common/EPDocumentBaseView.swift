//
//  EPBaseView.swift
//  DocumentViewDemo
//
//  Created by cpo007@qq.com on 16/9/1.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class EPDocumentBaseView: UIView {
    
    let space:CGFloat = 5
    var documentViewArray = [UIView]()
    var startPoint = CGPoint.zero
    var movePoint = CGPoint.zero
    var centerPoint = CGPoint.zero
    var dataArray = [TheArchives]()
    var lastBounds = CGRect.zero

    init(frame: CGRect, array:[TheArchives]) {
        super.init(frame: frame)
        dataArray = array
        setupUI()
    }
    
    func setupUI() {
        
        //根据数据创建等量的DocumentView
        createDocumentView()
        //归档按钮
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        button.center = CGPoint(x: center.x, y: frame.height - 64)
        button.addTarget(self, action: #selector(EPDocumentBaseView.buttonDidClick), forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.yellowColor()
        addSubview(button)
    }
    
    func createDocumentView() {
        for i in 0..<dataArray.count {
            let theArchives = dataArray[i]
            let documentView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width * 2 / 3 + CGFloat(i) * space, height: frame.height * 2 / 3 + CGFloat(i) * space))
            documentView.image = UIImage(named: theArchives.Icon ?? "")
            documentView.layer.shadowColor = UIColor.grayColor().CGColor
            documentView.layer.shadowOffset = CGSize(width: -3, height: -3)
            documentView.layer.shadowOpacity = 0.4
            documentView.layer.shadowRadius = 3
            documentView.center = CGPoint(x: center.x, y: center.y - CGFloat(i) * space)
            
            addSubview(documentView)
            documentViewArray.append(documentView)
        }
       lastBounds = documentViewArray.last?.layer.bounds ?? CGRect.zero
        
    }
    
    func buttonDidClick() {
        for documentView in documentViewArray{
            documentView.removeFromSuperview()
        }
        documentViewArray.removeAll()
        createDocumentView()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        guard let point = touch?.locationInView(self) else { return }
        startPoint = point
        movePoint = point
        if let documentView = documentViewArray.last {
            if CGRectContainsPoint(documentView.frame, point) {
                 centerPoint = documentView.center
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        guard let point = touch?.locationInView(self) else { return }
        movePoint = point
        let moveDistance = CGPoint(x: movePoint.x - startPoint.x, y: movePoint.y - startPoint.y)
        if let documentView = documentViewArray.last {
            if CGRectContainsPoint(documentView.frame, point) {
                documentView.layer.position = CGPoint(x: centerPoint.x + moveDistance.x, y: centerPoint.y + moveDistance.y)
                let angel = moveDistance.x / (Width / 2) * CGFloat(M_PI_2 / 2)
                documentView.transform = CGAffineTransformMakeRotation(angel)
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let documentView = documentViewArray.last else { return }
        let moveDistance = CGPoint(x: movePoint.x - startPoint.x, y: movePoint.y - startPoint.y)
        if moveDistance.x > 150 || moveDistance.x < -150 {
            UIView.animateWithDuration(0.3, animations: {
                documentView.layer.position.x += moveDistance.x > 150 ? 200 : -200
                }, completion: { (isSucdess) in
                    documentView.removeFromSuperview()
                    self.documentViewArray.removeLast()
            })
        } else {
            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .AllowAnimatedContent, animations: {
                documentView.transform = CGAffineTransformIdentity
                documentView.layer.position = CGPoint(x: self.center.x, y: self.center.y - CGFloat(self.documentViewArray.count - 1) * self.space)
                }, completion: { (isSuccess) in
                    
            })
            documentView.transform = CGAffineTransformIdentity
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  随机颜色
    func RandomColor() -> UIColor {
        return RGB(red: CGFloat(random() % 256), green: CGFloat(random() % 256), blue: CGFloat(random() % 256))
    }
    
    //颜色便利构造
    func RGB(red red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255 , blue: blue / 255, alpha: 1)
    }
}



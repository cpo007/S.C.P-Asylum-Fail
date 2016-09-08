//
//  TheText.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/19.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class TheText: NSObject,NSCoding {
    
    var Style: NSNumber = 0 {
        didSet{
            setCellStyle(Style)
        }
    }
    var Text: String = ""
    var SubText: String = ""
    var NotificationTime: NSNumber = 0
    var LeftButton: TheButton?
    var RightButton: TheButton?
    var CellStyle: HomeCellStyle?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            if k == "LeftButton"  {
                let d = v as! [String:AnyObject]
                LeftButton = TheButton(dict: d)
            } else if k == "RightButton" {
                let d = v as! [String:AnyObject]
                RightButton = TheButton(dict: d)
            } else {
                setValue(v, forKey: k)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Style = aDecoder.decodeObjectForKey("Style") as! NSNumber
        Text = aDecoder.decodeObjectForKey("Text") as! String
        SubText = aDecoder.decodeObjectForKey("SubText") as! String
        LeftButton = aDecoder.decodeObjectForKey("LeftButton") as? TheButton
        RightButton = aDecoder.decodeObjectForKey("RightButton") as? TheButton
        setCellStyle(aDecoder.decodeObjectForKey("Style") as! NSNumber)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(Style, forKey: "Style")
        aCoder.encodeObject(Text, forKey: "Text")
        aCoder.encodeObject(SubText, forKey: "SubText")
        aCoder.encodeObject(LeftButton, forKey: "LeftButton")
        aCoder.encodeObject(RightButton, forKey: "RightButton")
    }
    
    func setCellStyle(number:NSNumber) {
        switch number {
        case 101 :
            CellStyle = HomeCellStyle.Instructions
            break
        case 102 :
            CellStyle = HomeCellStyle.Dialogue
            break
        case 103 :
            CellStyle = HomeCellStyle.TwoButton
            break
        case 104 :
            CellStyle = HomeCellStyle.End
            break
        case 105 :
            CellStyle = HomeCellStyle.Notification
        default :
            break
        }
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}
    
}

class TheButton: NSObject,NSCoding {
    
    var Branch = 0
    var Text:String?
    var PlistName = ""
    var isSelectod = false
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            setValue(v, forKey: k)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Branch = aDecoder.decodeObjectForKey("Branch") as! Int
        Text = aDecoder.decodeObjectForKey("Text") as? String
        PlistName = aDecoder.decodeObjectForKey("PlistName") as! String
        isSelectod = aDecoder.decodeObjectForKey("isSelectod") as! Bool
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(Branch, forKey: "Branch")
        aCoder.encodeObject(Text, forKey: "Text")
        aCoder.encodeObject(PlistName, forKey: "PlistName")
        aCoder.encodeObject(isSelectod, forKey: "isSelectod")
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {}

}

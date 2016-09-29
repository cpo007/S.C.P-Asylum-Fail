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
    var Number: String?
    
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
        Style = aDecoder.decodeObject(forKey: "Style") as! NSNumber
        Text = aDecoder.decodeObject(forKey: "Text") as! String
        Number = aDecoder.decodeObject(forKey: "Number") as? String
        SubText = aDecoder.decodeObject(forKey: "SubText") as! String
        LeftButton = aDecoder.decodeObject(forKey: "LeftButton") as? TheButton
        RightButton = aDecoder.decodeObject(forKey: "RightButton") as? TheButton
        setCellStyle(aDecoder.decodeObject(forKey: "Style") as! NSNumber)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Style, forKey: "Style")
        aCoder.encode(Text, forKey: "Text")
        aCoder.encode(Number, forKey: "Number")
        aCoder.encode(SubText, forKey: "SubText")
        aCoder.encode(LeftButton, forKey: "LeftButton")
        aCoder.encode(RightButton, forKey: "RightButton")
    }
    
    func setCellStyle(_ number:NSNumber) {
        switch number {
        case 101 :
            CellStyle = HomeCellStyle.instructions
            break
        case 102 :
            CellStyle = HomeCellStyle.dialogue
            break
        case 103 :
            CellStyle = HomeCellStyle.twoButton
            break
        case 104 :
            CellStyle = HomeCellStyle.end
            break
        case 105 :
            CellStyle = HomeCellStyle.notification
        default :
            break
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

class TheButton: NSObject,NSCoding {
    
    var Branch = 0
    var Text:String?
    var PlistName:String?
    var isSelectod = false
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            setValue(v, forKey: k)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Branch = aDecoder.decodeInteger(forKey: "Branch")
        Text = aDecoder.decodeObject(forKey: "Text") as? String
        PlistName = aDecoder.decodeObject(forKey: "PlistName") as? String
        isSelectod = aDecoder.decodeBool(forKey: "isSelectod")
    }
    
    func encode(with aCoder: NSCoder) {
        print(Branch)
        aCoder.encode(Branch, forKey: "Branch")
        aCoder.encode(Text, forKey: "Text")
        aCoder.encode(PlistName, forKey: "PlistName")
        aCoder.encode(isSelectod, forKey: "isSelectod")
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

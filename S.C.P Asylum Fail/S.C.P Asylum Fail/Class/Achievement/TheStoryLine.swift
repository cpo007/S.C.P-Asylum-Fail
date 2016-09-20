//
//  TheStoryLine.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class TheStoryLine: NSObject {
    
    var CenterNode: TheStoryNode?
    var LeftNode: TheStoryNode?
    var RightNode: TheStoryNode?
    var Style: NSNumber?
    
        init(dict:[String:AnyObject]) {
            super.init()
            for (k,v) in dict{
                if k == "CenterNode" {
                    CenterNode = TheStoryNode(dict: dict["CenterNode"] as! [String : AnyObject])
                } else if k == "LeftNode" {
                    LeftNode = TheStoryNode(dict: dict["LeftNode"] as! [String : AnyObject])
                } else if k == "RightNode" {
                    RightNode = TheStoryNode(dict: dict["RightNode"] as! [String : AnyObject])
                } else {
                    setValue(v, forKey: k)
                }
            }
        }
        
//        required init?(coder aDecoder: NSCoder) {
//            super.init()
//            Branch = aDecoder.decodeInteger(forKey: "Branch")
//            Text = aDecoder.decodeObject(forKey: "Text") as? String
//            PlistName = aDecoder.decodeObject(forKey: "PlistName") as? String
//            isSelectod = aDecoder.decodeBool(forKey: "isSelectod")
//        }
//        
//        func encode(with aCoder: NSCoder) {
//            print(Branch)
//            aCoder.encode(Branch, forKey: "Branch")
//            aCoder.encode(Text, forKey: "Text")
//            aCoder.encode(PlistName, forKey: "PlistName")
//            aCoder.encode(isSelectod, forKey: "isSelectod")
//        }
    
        override func setValue(_ value: Any?, forUndefinedKey key: String) {}
        
}

class TheStoryNode: NSObject {
    var HasActivate = false
    var IsEnd = false
    var Plist = "Prologue"
    var Branch = 101
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            setValue(v, forKey: k)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

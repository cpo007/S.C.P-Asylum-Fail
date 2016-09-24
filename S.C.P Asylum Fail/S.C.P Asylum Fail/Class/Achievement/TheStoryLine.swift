//
//  TheStoryLine.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/20.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class TheStoryLine: NSObject,NSCoding {
    
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
        
        required init?(coder aDecoder: NSCoder) {
            super.init()
            CenterNode = aDecoder.decodeObject(forKey: "CenterNode") as? TheStoryNode
            LeftNode = aDecoder.decodeObject(forKey: "LeftNode") as? TheStoryNode
            RightNode = aDecoder.decodeObject(forKey: "RightNode") as? TheStoryNode
            Style = aDecoder.decodeObject(forKey: "Style") as? NSNumber
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(CenterNode, forKey: "CenterNode")
            aCoder.encode(LeftNode, forKey: "LeftNode")
            aCoder.encode(RightNode, forKey: "RightNode")
            aCoder.encode(Style, forKey: "Style")
        }
    
        override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

class TheStoryNode: NSObject,NSCoding {
    var HasActivate = false
    var IsEnd = false
    var Plist = "Prologue"
    var Branch = 101
    var Icon = ""
    var Title = ""
    var Detail = ""
    
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            setValue(v, forKey: k)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        HasActivate = aDecoder.decodeBool(forKey: "HasActivate")
        IsEnd = aDecoder.decodeBool(forKey: "IsEnd")
        Plist = aDecoder.decodeObject(forKey: "Plist") as? String ?? ""
        Branch = aDecoder.decodeInteger(forKey: "Branch")
        Icon = aDecoder.decodeObject(forKey: "Icon") as? String ?? ""
        Title = aDecoder.decodeObject(forKey: "Title") as? String ?? ""
        Detail = aDecoder.decodeObject(forKey: "Detail") as? String ?? ""
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(HasActivate, forKey: "HasActivate")
        aCoder.encode(IsEnd, forKey: "IsEnd")
        aCoder.encode(Plist, forKey: "Plist")
        aCoder.encode(Branch, forKey: "Branch")
        aCoder.encode(Icon, forKey: "Icon")
        aCoder.encode(Title, forKey: "Title")
        aCoder.encode(Detail, forKey: "Detail")
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

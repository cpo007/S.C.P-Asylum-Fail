//
//  TheArchives.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class TheArchives: NSObject {
    var Icon:String?
    var Number:String?
    var HasActivation = false
    var Project:TheProject?
    
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            if k == "Project"  {
                let d = v as! [String:AnyObject]
                Project = TheProject(dict: d)
            } else {
                setValue(v, forKey: k)
            }
        }
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init()
//        Branch = aDecoder.decodeObjectForKey("Branch") as! Int
//        Text = aDecoder.decodeObjectForKey("Text") as? String
//        PlistName = aDecoder.decodeObjectForKey("PlistName") as! String
//        isSelectod = aDecoder.decodeObjectForKey("isSelectod") as! Bool
//    }
//    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(Branch, forKey: "Branch")
//        aCoder.encodeObject(Text, forKey: "Text")
//        aCoder.encodeObject(PlistName, forKey: "PlistName")
//        aCoder.encodeObject(isSelectod, forKey: "isSelectod")
//    }
//    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

class TheProject: NSObject {
    
    var Number:String?
    var Icon:String?
    var Level:String?
    var AsylumMeasures:String?
    var Describe:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        for (k,v) in dict{
            setValue(v, forKey: k)
        }
    }
}

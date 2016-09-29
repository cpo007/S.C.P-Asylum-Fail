//
//  TheArchives.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class TheArchives: NSObject,NSCoding {
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Icon = aDecoder.decodeObject(forKey: "Icon") as? String
        Number = aDecoder.decodeObject(forKey: "Number") as? String
        HasActivation = aDecoder.decodeBool(forKey: "HasActivation")
        Project = aDecoder.decodeObject(forKey: "Project") as? TheProject
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(HasActivation, forKey: "HasActivation")
        aCoder.encode(Number, forKey: "Number")
        aCoder.encode(Icon, forKey: "Icon")
        aCoder.encode(Project, forKey: "Project")
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

class TheProject: NSObject,NSCoding {
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        Number = aDecoder.decodeObject(forKey: "Number") as? String
        Icon = aDecoder.decodeObject(forKey: "Icon") as? String
        Level = aDecoder.decodeObject(forKey: "Level") as? String
        AsylumMeasures = aDecoder.decodeObject(forKey: "AsylumMeasures") as? String
        Describe = aDecoder.decodeObject(forKey: "Describe") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Number, forKey: "Number")
        aCoder.encode(Icon, forKey: "Icon")
        aCoder.encode(Level, forKey: "Level")
        aCoder.encode(AsylumMeasures, forKey: "AsylumMeasures")
        aCoder.encode(Describe, forKey: "Describe")
    }
}

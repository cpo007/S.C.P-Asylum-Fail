//
//  EPTool.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit


let Width = UIScreen.main.bounds.width
let Height = UIScreen.main.bounds.height
let Bounds = UIScreen.main.bounds

func getLabel(text:String, font:UIFont?, color:UIColor) -> UILabel{
    let label = UILabel()
    label.text = text
    if let font = font {
        label.font = font        
    }
    label.textColor = color
    label.numberOfLines = 0
    return label
}

//创建一个普通按钮
func getNormalButton(_ target:AnyObject,action:Selector,Title:String ,font:UIFont? = nil,color:UIColor? = nil,tag:NSInteger? = nil) -> UIButton{
    let button = BaseButton()
    button.adjustsImageWhenHighlighted = false
    button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    button.setTitle(Title, for: UIControlState())
    button.setBackgroundImage(UIImage(named: "NormalButton"), for: .normal)
    button.setBackgroundImage(UIImage(named: "SelectedButton"), for: .selected)
    if let f = font{
        button.titleLabel?.font = f
    }
    if let c = color {
        button.setTitleColor(c, for: UIControlState())
    } else {
        button.setTitleColor(UIColor.black, for: UIControlState())
    }
    if let t = tag {
        button.tag = t
    }
    return button
}

//制作分支字符串
func getBranchString(_ Branch:NSInteger) -> String{
    return "Branch\(Branch)"
}

//本地通知
func registerLocalNotification(_ alertTime:TimeInterval){
    print(alertTime)
    //本地通知激活时记录通知时长及通知激活时时间以供比对
    UserDefaults.standard.set(alertTime, forKey: "NotificationTime")
    UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "HistoryOfTime")
    
    let localNotifacation = UILocalNotification()
    let fireDate = Date(timeInterval: alertTime, since: Date())
    localNotifacation.fireDate = fireDate
    localNotifacation.timeZone = TimeZone.current
    localNotifacation.soundName = UILocalNotificationDefaultSoundName
    localNotifacation.alertBody = "D-9587有事想告知您."
    UIApplication.shared.scheduleLocalNotification(localNotifacation)
    
}

//获得沙盒路径
func getSandBoxPath(_ fileName:String) -> String{
    guard let SandBoxBasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
        return ""
    }
    let SandSavdBoxPath = SandBoxBasePath + "/\(fileName)"
    return SandSavdBoxPath
}

//保存数据
//func saveData(_ theStoryArry:[TheText], theTextArry:[TheText]){
//    let sandBoxSavePath = getSandBoxPath("data")
//    let sandBoxMaxSavePath = getSandBoxPath("maxData")
//    if sandBoxSavePath.isEmpty && sandBoxMaxSavePath.isEmpty {
//        print("保存失败")
//        return
//    }
//    let data = NSKeyedArchiver.archivedData(withRootObject: theStoryArry)
//    let maxData = NSKeyedArchiver.archivedData(withRootObject: theTextArry)
//    try? data.write(to: URL(fileURLWithPath: sandBoxSavePath), options: [.atomic])
//    try? maxData.write(to: URL(fileURLWithPath: sandBoxMaxSavePath), options: [.atomic])
//    print("保存成功")
//}

func saveData(_ data: AnyObject, dataName: String){
    let sandBoxSavePath = getSandBoxPath(dataName)
    if sandBoxSavePath.isEmpty {
        print("保存\(dataName)失败")
        return
    }
    let data = NSKeyedArchiver.archivedData(withRootObject: data)
    try? data.write(to: URL(fileURLWithPath: sandBoxSavePath), options: [.atomic])
    print("保存\(dataName)成功")

}

//读取数据
//func reloadData() -> (theStoryArry: [TheText]?, theTextArry: [TheText]?) {
//    let sandBoxSavePath = getSandBoxPath("data")
//    let sandBoxMaxSavePath = getSandBoxPath("maxData")
//    if sandBoxSavePath.isEmpty && sandBoxMaxSavePath.isEmpty {
//        print("读取失败")
//    }
//    let data = try?Data(contentsOf: URL(fileURLWithPath: sandBoxSavePath), options: .dataReadingMapped)
//    let maxData = try?Data(contentsOf: URL(fileURLWithPath: sandBoxMaxSavePath), options: .dataReadingMapped)
//    guard let d = data, let m = maxData else {
//        return (nil,nil)
//    }
//    let theStoryArry = NSKeyedUnarchiver.unarchiveObject(with: d) as? [TheText]
//    let theTextArry = NSKeyedUnarchiver.unarchiveObject(with: m) as? [TheText]
//    print("读取成功")
//    return (theStoryArry,theTextArry)
//}

func reloadData(dataName: String) -> Any? {
    let sandBoxSavePath = getSandBoxPath(dataName)
    if sandBoxSavePath.isEmpty {
        print("读取\(dataName)失败")
    }
    if let data = try?Data(contentsOf: URL(fileURLWithPath: sandBoxSavePath), options: .dataReadingMapped) {
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    return nil
}

//颜色便利构造
func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255 , blue: blue / 255, alpha: 1)
}

//  随机颜色
func RandomColor() -> UIColor {
    return RGB(red: CGFloat(arc4random() % 256), green: CGFloat(arc4random() % 256), blue: CGFloat(arc4random() % 256))
}

//APP默认颜色
func defultColor() -> UIColor{
    return UIColor(red: 89/255.0, green: 88/255.0, blue: 117/255.0, alpha: 1)
}

func ColorBlue () -> UIColor{
    return RGB(red: 125, green: 205, blue: 202)
}

func ColorYellow () -> UIColor{
    return RGB(red: 251, green: 187, blue: 42)
}

func ColorOrange () -> UIColor{
    return RGB(red: 244, green: 159, blue: 96)
}

func ColorRed () -> UIColor{
    return RGB(red: 242, green: 116, blue: 126)
}

func ColorPurple () -> UIColor{
    return RGB(red: 107, green: 87, blue: 112)
}

func ColorBlack () -> UIColor{
    return RGB(red: 28, green: 19, blue: 16)
}

//颜色转图片（暂用）
func colorToImage(_ color:UIColor) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

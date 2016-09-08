//
//  EPTool.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit


let Width = UIScreen.mainScreen().bounds.width
let Height = UIScreen.mainScreen().bounds.height
let Bounds = UIScreen.mainScreen().bounds

func getLabel(text text:String, font:UIFont?, color:UIColor) -> UILabel{
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
func getNormalButton(target:AnyObject,action:Selector,Title:String ,font:UIFont?,color:UIColor?,tag:NSInteger?) -> UIButton{
    let button = UIButton()
    button.adjustsImageWhenHighlighted = false
    button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    button.setTitle(Title, forState: UIControlState.Normal)
    button.setBackgroundImage(colorToImage(ColorYellow()), forState: .Normal)
    button.setBackgroundImage(colorToImage(ColorBlack()), forState: .Highlighted)
    button.setBackgroundImage(colorToImage(ColorBlue()), forState: .Selected)
    if let f = font{
        button.titleLabel?.font = f
    }
    if let c = color {
        button.setTitleColor(c, forState: UIControlState.Normal)
    } else {
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    if let t = tag {
        button.tag = t
    }
    return button
}

//制作分支字符串
func getBranchString(Branch:NSNumber) -> String{
    return "Branch\(Branch)"
}

//本地通知
func registerLocalNotification(alertTime:NSTimeInterval){
    print(alertTime)
    //本地通知激活时记录通知时长及通知激活时时间以供比对
    NSUserDefaults.standardUserDefaults().setDouble(alertTime, forKey: "NotificationTime")
    NSUserDefaults.standardUserDefaults().setDouble(NSDate().timeIntervalSince1970, forKey: "HistoryOfTime")
    
    let localNotifacation = UILocalNotification()
    let fireDate = NSDate(timeInterval: alertTime, sinceDate: NSDate())
    localNotifacation.fireDate = fireDate
    localNotifacation.timeZone = NSTimeZone.defaultTimeZone()
    localNotifacation.soundName = UILocalNotificationDefaultSoundName
    localNotifacation.alertBody = "D-9587有事想告知您."
    UIApplication.sharedApplication().scheduleLocalNotification(localNotifacation)
    
}

//获得沙盒路径
func getSandBoxPath(fileName:String) -> String{
    guard let SandBoxBasePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first else {
        return ""
    }
    let SandSavdBoxPath = SandBoxBasePath.stringByAppendingString("/\(fileName)")
    return SandSavdBoxPath
}

//保存数据
func saveData(theStoryArry:[TheText], theTextArry:[TheText]){
    let sandBoxSavePath = getSandBoxPath("data")
    let sandBoxMaxSavePath = getSandBoxPath("maxData")
    if sandBoxSavePath.isEmpty && sandBoxMaxSavePath.isEmpty {
        print("保存失败")
        return
    }
    print("保存成功")
    let data = NSKeyedArchiver.archivedDataWithRootObject(theStoryArry)
    let maxData = NSKeyedArchiver.archivedDataWithRootObject(theTextArry)
    data.writeToFile(sandBoxSavePath, atomically: true)
    maxData.writeToFile(sandBoxMaxSavePath, atomically: true)
}

//读取数据
func reloadData() -> (theStoryArry:[TheText]?, theTextArry:[TheText]?) {
    let sandBoxSavePath = getSandBoxPath("data")
    let sandBoxMaxSavePath = getSandBoxPath("maxData")
    if sandBoxSavePath.isEmpty && sandBoxMaxSavePath.isEmpty {
        print("读取失败")
    }
    print("读取成功")
    let data = try?NSData(contentsOfFile: sandBoxSavePath, options: .DataReadingMapped)
    let maxData = try?NSData(contentsOfFile: sandBoxMaxSavePath, options: .DataReadingMapped)
    guard let d = data, m = maxData else {
        return (nil,nil)
    }
    let theStoryArry = NSKeyedUnarchiver.unarchiveObjectWithData(d) as? [TheText]
    let theTextArry = NSKeyedUnarchiver.unarchiveObjectWithData(m) as? [TheText]
    return (theStoryArry,theTextArry)
}

//颜色便利构造
func RGB(red red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red / 255, green: green / 255 , blue: blue / 255, alpha: 1)
}

//  随机颜色
func RandomColor() -> UIColor {
    return RGB(red: CGFloat(random() % 256), green: CGFloat(random() % 256), blue: CGFloat(random() % 256))
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
func colorToImage(color:UIColor) -> UIImage{
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

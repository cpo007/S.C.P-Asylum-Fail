//
//  HomeViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/8/17.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import SnapKit

enum HomeCellStyle:NSInteger {
    case Instructions = 101
    case Dialogue = 102
    case TwoButton = 103
    case End = 104
    case Notification = 105
}

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:HomeTableView?
    var menuView:HomeMenuView?
    var theTextArray = [TheText]()
    var theStoryArray = [TheText]()
    var storyCount = 0
    var hasLoad = false
    var isPop = false
    
    
    var timer:NSTimer?
    
    let instructionsIdentifier = "instructionsIdentifier"
    let dialogueIdentifier = "dialogueIdentifier"
    let endButtonIdentifier = "endButtonIdentifier"
    let twoButtonIdentifier = "twoButtonIdentifier"
    let notificationIdentifier = "notificationIdentifier"


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupResource()
        compareNotificationTime()
    }
    
    deinit {
        tableView?.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setupUI() {
        
        //主体TableView
        tableView = HomeTableView(frame: CGRect(x: 20, y: 20, width: Width - 40, height: Height - 50))
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .None
        tableView?.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
        tableView?.showsVerticalScrollIndicator = false
        view.addSubview(tableView!)

        tableView?.registerClass(HomeInstructionsTableViewCell.self, forCellReuseIdentifier: instructionsIdentifier)
        tableView?.registerClass(HomeDialogueTableViewCell.self, forCellReuseIdentifier: dialogueIdentifier)
        tableView?.registerClass(HomeButtonTableViewCell.self, forCellReuseIdentifier: twoButtonIdentifier)
        tableView?.registerClass(HomeNotificationCell.self, forCellReuseIdentifier: notificationIdentifier)
        tableView?.registerClass(HomeEndTableViewCell.self, forCellReuseIdentifier: endButtonIdentifier)

        //菜单选项
        menuView = NSBundle.mainBundle().loadNibNamed("HomeMenuView", owner: nil, options: nil).first as? HomeMenuView
        view.addSubview(menuView!)
        menuView?.snp_makeConstraints(closure: { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp_bottom).offset(-50)
            make.leading.equalTo(view).offset(44)
            make.trailing.equalTo(view).offset(-44)
            make.height.equalTo(Height / 3)
        })
            menuView?.backgroundColor = ColorPurple()
        
        menuView?.buttonDidClickBlock = { [weak self] tag in
            switch tag {
            case 201 :
                self?.updateMenuView()
                break
            case 202:
                self?.presentViewController(ArchivesViewController(), animated: true, completion: nil)
                break
            default :
                break
            }
        }
    }
    
    func updateMenuView() {
        
        menuView?.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(view.snp_bottom).offset(isPop ? -50 : -(Height / 3))
        })
        UIView.animateWithDuration(0.3) {
            self.menuView?.layoutIfNeeded()
        }
        isPop = !isPop
    }
    
    func getStory() {
        if theTextArray.count == 0 { return }
        let theText = theTextArray[storyCount]
        theStoryArray.append(theText)
        tableView?.beginUpdates()
        tableView?.insertRowsAtIndexPaths([NSIndexPath(forRow: theStoryArray.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
        tableView?.endUpdates()
        storyCount += 1
        if theText.CellStyle == HomeCellStyle.Notification || theText.CellStyle == HomeCellStyle.TwoButton {
            timerStop()
        }
        saveData(theStoryArray, theTextArry: theTextArray)
    }
    
    
    //初始化数据，若有存档则读取存档，否则读取序章
    func setupResource() {
        if let theStoryArry = reloadData().theStoryArry, theTextArray = reloadData().theTextArry {
            self.theStoryArray = theStoryArry
            self.theTextArray = theTextArray
            storyCount = theStoryArry.count
        } else {
            guard let path = NSBundle.mainBundle().pathForResource("Prologue", ofType: "plist") else { return }
            guard let dict = NSDictionary(contentsOfFile: path) as? [String:[AnyObject]] else { return }
            guard let arr = dict["Branch101"] as? [[String:AnyObject]] else { return }
            for dic in arr{
                let theText = TheText(dict: dic)
                theTextArray.append(theText)
            }
        }
        
        //若存档不存在或最后CellStyle不为TwoButton则继续
        if let theText = theStoryArray.last {
            if theText.CellStyle != HomeCellStyle.TwoButton && theText.CellStyle != HomeCellStyle.Notification {
                timerStart()
            }
        } else {
            timerStart()
        }
    }
    
    //根据分支选项不同来获取不同的后续故事
    func getBranch(buttonTag:NSNumber?) {
        timerStart()
        if let buttonTag = buttonTag {
            guard let theText = theStoryArray.last else { return }
            var branchString:String?
            var plistName:String?
            
            switch buttonTag {
            case buttonType.left.rawValue :
                branchString = getBranchString(theText.LeftButton!.Branch)
                plistName = theText.LeftButton?.PlistName
                theText.LeftButton!.isSelectod = true
                break
            case buttonType.right.rawValue :
                branchString = getBranchString(theText.RightButton!.Branch)
                plistName = theText.RightButton?.PlistName
                theText.RightButton!.isSelectod = true
                break
            default :
                break
            }
            guard let pN = plistName, bS = branchString else { return }
            appendStory(pN, branchString: bS)
        }
    }
    
    //监听contentSize的改变以自动向下滑动
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentSize" {
            if let tableView = object as? HomeTableView {
                let contentSize = tableView.contentSize
                if contentSize.height > tableView.frame.height {
                    let offset = CGPointMake(0, contentSize.height - tableView.frame.height)
                    tableView.setContentOffset(offset, animated: true)
                }
            }
        }
    }
    
    //这个方法与初始化时获得历史数据相分离，作用是当故事发展到一定情节时将新的剧情加入到剧情数组中
    func appendStory(plistName: String, branchString:String) {
        guard let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist") else { return }
        guard let dict = NSDictionary(contentsOfFile: path) as? [String:[AnyObject]] else { return }
        guard let arr = dict[branchString] as? [[String:AnyObject]] else { return }
        for dic in arr{
            let theText = TheText(dict: dic)
            theTextArray.append(theText)
        }
    }
    
    //每次进入时根据时差判断是否继续故事
    func compareNotificationTime() {
        guard let theText = theStoryArray.last else { return }
        if theText.CellStyle == HomeCellStyle.Notification {
            let notificationTime = NSUserDefaults.standardUserDefaults().doubleForKey("NotificationTime")
            let historyOfTime = NSUserDefaults.standardUserDefaults().doubleForKey("HistoryOfTime")
            let currentTime = NSDate().timeIntervalSince1970
            if currentTime - historyOfTime > notificationTime {
                print("激活")
                timerStart()
            } else {
                print("激活失败")
            }
        }
    }
    
    //暂停计时器
    func timerStop() {
        timer?.invalidate()
    }
    
    //开启计时器
    func timerStart() {
        if let t = timer {
            if !t.valid {
                timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HomeViewController.getStory), userInfo: nil, repeats: true)
            }
        } else {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HomeViewController.getStory), userInfo: nil, repeats: true)
        }
    }
    
}

extension HomeViewController {
    
    //tableViewDelegate And DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theStoryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theText = theStoryArray[indexPath.row]
        switch theText.CellStyle! {
        case .Instructions :
            let cell = tableView.dequeueReusableCellWithIdentifier(instructionsIdentifier) as? HomeInstructionsTableViewCell
            cell?.updateResource(theText)
            return cell!
        case .Dialogue :
            let cell = tableView.dequeueReusableCellWithIdentifier(dialogueIdentifier) as? HomeDialogueTableViewCell
            cell?.updateResource(theText)
            return cell!
        case .End :
            let cell = tableView.dequeueReusableCellWithIdentifier(dialogueIdentifier) as? HomeEndTableViewCell
            return cell!
        case .TwoButton :
            let cell = tableView.dequeueReusableCellWithIdentifier(twoButtonIdentifier) as? HomeButtonTableViewCell
            cell?.updateResource(theText)
            cell?.buttonDidClickBlock = { [weak self] buttonTag in
                self?.getBranch(buttonTag)
            }
            return cell!
        case .Notification :
            //注册通知类型Cell
            let cell = tableView.dequeueReusableCellWithIdentifier(notificationIdentifier) as? HomeNotificationCell
            cell?.updateResource(theText)
            return cell!
        }

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let theText = theStoryArray[indexPath.row]
        if theText.Style == 103 {
            return 120
        } else {
            return 80
        }
    }
}

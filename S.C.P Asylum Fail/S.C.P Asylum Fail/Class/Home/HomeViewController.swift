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
    case instructions = 101
    case dialogue = 102
    case twoButton = 103
    case end = 104
    case notification = 105
}

class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:HomeTableView?
    var menuView:HomeMenuView?
    var theTextArray = [TheText]()
    var theStoryArray = [TheText]()
    var storyCount = 0
    var hasLoad = false
    var isPop = false
    
    
    var timer:Timer?
    
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
        tableView?.separatorStyle = .none
        tableView?.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        tableView?.showsVerticalScrollIndicator = false
        view.addSubview(tableView!)

        tableView?.register(HomeInstructionsTableViewCell.self, forCellReuseIdentifier: instructionsIdentifier)
        tableView?.register(HomeDialogueTableViewCell.self, forCellReuseIdentifier: dialogueIdentifier)
        tableView?.register(HomeButtonTableViewCell.self, forCellReuseIdentifier: twoButtonIdentifier)
        tableView?.register(HomeNotificationCell.self, forCellReuseIdentifier: notificationIdentifier)
        tableView?.register(HomeEndTableViewCell.self, forCellReuseIdentifier: endButtonIdentifier)

        //菜单选项
        menuView = Bundle.main.loadNibNamed("HomeMenuView", owner: nil, options: nil)?.first as? HomeMenuView
        view.addSubview(menuView!)
        menuView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp.bottom).offset(-50)
            make.leading.equalTo(view).offset(44)
            make.trailing.equalTo(view).offset(-44)
            make.height.equalTo(Height / 3)
        })
            menuView?.backgroundColor = ColorPurple()
        
        menuView?.buttonDidClickBlock = { [weak self] tag in
            switch tag {
            case HomeMenuButtonStyle.dismiss.rawValue :
                self?.updateMenuView()
                break
            case HomeMenuButtonStyle.gotoArchives.rawValue :
                self?.navigationController?.pushViewController(ArchivesViewController(), animated: true)
                break
            case HomeMenuButtonStyle.gotoWorldLine.rawValue :
                self?.navigationController?.pushViewController(StoryLineViewController(), animated: true)
                break
            case HomeMenuButtonStyle.getScore.rawValue :
                break
            default :
                break
            }
        }
    }
    
    func updateMenuView() {
        
        menuView?.snp.updateConstraints({ (make) in
            make.top.equalTo(view.snp.bottom).offset(isPop ? -50 : -(Height / 3))
        })
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        isPop = !isPop
    }
    
    func getStory() {
        
        if theTextArray.count == 0 { return }
        let theText = theTextArray[storyCount]
        theStoryArray.append(theText)
        tableView?.beginUpdates()
        tableView?.insertRows(at: [IndexPath(row: theStoryArray.count-1, section: 0)], with: UITableViewRowAnimation.bottom)
        tableView?.endUpdates()
        storyCount += 1
        let isQuick = UserDefaults.standard.bool(forKey: "isQuick")
        if  theText.CellStyle == HomeCellStyle.twoButton || theText.CellStyle == HomeCellStyle.end {
            timerStop()
        } else if theText.CellStyle == HomeCellStyle.notification && !isQuick {
            //快速模式中继续故事，非快速模式下激活通知并暂停故事
            timerStop()
        }
        saveData(theStoryArray, theTextArry: theTextArray)
    }
    
    
    //初始化数据，若有存档则读取存档，否则读取序章
    func setupResource() {
        if let theStoryArry = reloadData().theStoryArry, let theTextArray = reloadData().theTextArry {
            self.theStoryArray = theStoryArry
            self.theTextArray = theTextArray
            storyCount = theStoryArry.count
        } else {
            guard let path = Bundle.main.path(forResource: "Prologue", ofType: "plist") else { return }
            guard let dict = NSDictionary(contentsOfFile: path) as? [String:[AnyObject]] else { return }
            guard let arr = dict["Branch101"] as? [[String:AnyObject]] else { return }
            for dic in arr{
                let theText = TheText(dict: dic)
                theTextArray.append(theText)
            }
        }
        
        //若存档不存在或最后CellStyle不为TwoButton则继续
        if let theText = theStoryArray.last {
            if theText.CellStyle != HomeCellStyle.twoButton && theText.CellStyle != HomeCellStyle.notification && theText.CellStyle != HomeCellStyle.end {
                timerStart()
            }
        } else {
            timerStart()
        }
    }
    
    //根据分支选项不同来获取不同的后续故事
    func getBranch(_ buttonTag:NSNumber?) {
        timerStart()
        if let buttonTag = buttonTag {
            guard let theText = theStoryArray.last else { return }
            var branchString:String?
            var plistName:String?
            
            switch buttonTag.intValue {
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
            guard let pN = plistName, let bS = branchString else { return }
            appendStory(pN, branchString: bS)
        }
    }
    
    //监听contentSize的改变以自动向下滑动
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let tableView = object as? HomeTableView {
                let contentSize = tableView.contentSize
                if contentSize.height > tableView.frame.height {
                    let offset = CGPoint(x: 0, y: contentSize.height - tableView.frame.height)
                    tableView.setContentOffset(offset, animated: true)
                }
            }
        }
    }
    
    //这个方法与初始化时获得历史数据相分离，作用是当故事发展到一定情节时将新的剧情加入到剧情数组中
    func appendStory(_ plistName: String, branchString:String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist") else { return }
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
        if theText.CellStyle == HomeCellStyle.notification {
            let notificationTime = UserDefaults.standard.double(forKey: "NotificationTime")
            let historyOfTime = UserDefaults.standard.double(forKey: "HistoryOfTime")
            let currentTime = Date().timeIntervalSince1970
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
            if !t.isValid {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.getStory), userInfo: nil, repeats: true)
            }
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeViewController.getStory), userInfo: nil, repeats: true)
        }
    }
    
}

extension HomeViewController {
    
    //tableViewDelegate And DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theStoryArray.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theText = theStoryArray[(indexPath as NSIndexPath).row]
        switch theText.CellStyle! {
        case .instructions :
            let cell = tableView.dequeueReusableCell(withIdentifier: instructionsIdentifier) as? HomeInstructionsTableViewCell
            cell?.updateResource(theText)
            return cell!
        case .dialogue :
            let cell = tableView.dequeueReusableCell(withIdentifier: dialogueIdentifier) as? HomeDialogueTableViewCell
            cell?.updateResource(theText)
            return cell!
        case .end :
            let cell = tableView.dequeueReusableCell(withIdentifier: endButtonIdentifier) as? HomeEndTableViewCell
            cell?.updateResource(theText)
            cell?.endBlock = { [weak self] in
                guard let endView = Bundle.main.loadNibNamed("HomeEndView", owner: nil, options: nil)?.first as? HomeEndView else { return }
                endView.frame = Bounds
                endView.alpha = 0
                self?.view.addSubview(endView)
                UIView.animate(withDuration: 0.3, animations: { 
                    endView.alpha = 1
                })
                print("Game Over")
            }
            return cell!
        case .twoButton :
            let cell = tableView.dequeueReusableCell(withIdentifier: twoButtonIdentifier) as? HomeButtonTableViewCell
            cell?.updateResource(theText)
            cell?.buttonDidClickBlock = { [weak self] buttonTag in
                self?.getBranch(buttonTag)
            }
            return cell!
        case .notification :
            //注册通知类型Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: notificationIdentifier) as? HomeNotificationCell
            cell?.updateResource(theText)
            return cell!
        }

    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let theText = theStoryArray[(indexPath as NSIndexPath).row]
        if theText.Style == 103 {
            return 120
        } else {
            return 80
        }
    }
    

}

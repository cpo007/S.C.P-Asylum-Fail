//
//  ArchivesViewController.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/5.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit
import Koloda

class ArchivesViewController: BaseViewController {

    var theArchivesArrayArray = [[TheArchives]]()
    var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupResource()

    }
    
    func setupUI() {
        
        let rect = CGRect(x: 0, y: 0, width: Width - 40 , height: Height * 2 / 3)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.center = view.center
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(ArchivesPageCollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView!)
        resizeCollectionView(size: CGSize(width: Width - 40 , height: Height * 2 / 3))
        
        
        //Border
        
        if let c = collectionView {
            let borderView = UIImageView(frame: CGRect(x: 0, y: 0, width: c.frame.width + 20, height: c.frame.height))
            borderView.image = UIImage(named: "Border2")
            borderView.center = CGPoint(x: c.center.x, y: c.center.y - 20 )
            view.addSubview(borderView)
        }
        
    }
    
    func resizeCollectionView(size: CGSize) {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = size
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
        }
    }
    
    //初始化S.C.P档案
    func setupResource() {
        guard let data = reloadData(dataName: theArchivesArrayName) else { return }
        let array = data  as! [TheArchives]
        var theArchivesArray = [TheArchives]()
        var theArchivesArrayArray = [[TheArchives]]()
        //通过计算分离初始数据数组为以9为极值的数个子数组
        let quotient = array.count / 9
        let remainder = array.count % 9
        for i in 0..<array.count {
            theArchivesArray.append(array[i])
            var number = 0
            if i / 9 == quotient && (i % 9) != 0 {
                number = remainder
            } else if i / 9 != quotient {
                number = 9
            }
            if theArchivesArray.count == number {
                let arr = theArchivesArray
                theArchivesArrayArray.append(arr)
                theArchivesArray.removeAll()
            }
        }
        self.theArchivesArrayArray = theArchivesArrayArray

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArchivesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theArchivesArrayArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theArchivesArray = theArchivesArrayArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! ArchivesPageCollectionViewCell
        cell.updateResource(theArchivesArray: theArchivesArray)
        cell.itemDidSelected = { [weak self] theProject in
            guard let weakSelf = self else { return }
            if let archiveDetailView = Bundle.main.loadNibNamed("ArchiveDetailView", owner: nil, options: nil)?.first as? ArchiveDetailView {
                weakSelf.view.addSubview(archiveDetailView)
                archiveDetailView.updateResource(theProject: theProject)
                archiveDetailView.alpha = 0
                archiveDetailView.frame = weakSelf.view.frame
                UIView.animate(withDuration: 0.3, animations: { 
                    archiveDetailView.alpha = 1
                })
            }
        }
        return cell
    }
}



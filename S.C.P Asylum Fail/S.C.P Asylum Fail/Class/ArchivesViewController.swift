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

    var theArchivesArray = [TheArchives]()
    var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupResource()

    }
    
    func setupUI() {
        
        
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.clear
        collectionView?.register(ArchivesPageCollectionViewCell.self, forCellWithReuseIdentifier: "collectionView")
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView!)
        resizeCollectionView(size: view.frame.size)
    }
    
    func resizeCollectionView(size: CGSize) {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = view.frame.size
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
        }
    }

    //初始化S.C.P档案
    func setupResource() {
        guard let path = Bundle.main.path(forResource: "Collection", ofType: "plist") else { return }
        guard let arr = NSArray(contentsOfFile: path) as? [AnyObject] else { return }
        for dict in arr {
            guard let dict = dict as? [String:AnyObject] else { return }
            let theArchives = TheArchives(dict: dict)
            theArchivesArray.append(theArchives)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ArchivesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var a = 0
        if theArchivesArray.count % 9 > 0 {
            a = 1
        }
        return theArchivesArray.count / 9 + a
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as! ArchivesPageCollectionViewCell
//        cell.backgroundColor = RandomColor()
        return cell
    }
}



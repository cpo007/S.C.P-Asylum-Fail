//
//  ArchivesPageCollectionViewCell.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/9/26.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

class ArchivesPageCollectionViewCell: UICollectionViewCell {
    
    var collectionView: UICollectionView?
    var theArchivesArray = [TheArchives]()
    var itemDidSelected:((_ theProject: TheProject)->())?
    
    let APP_ITEM_MIN_WIDTH: CGFloat = 70
    let APP_ITEM_SPACING: CGFloat = 12
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    func setupUI() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame
            .width, height: frame.height), collectionViewLayout: UICollectionViewFlowLayout())
            collectionView?.dataSource = self
            collectionView?.delegate = self
            collectionView?.backgroundColor = UIColor.clear
            collectionView?.register(UINib(nibName: "ArchiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArchiveCollectionViewCell")
            addSubview(collectionView!)
            resizeCollectionView(size: frame.size)
    }
    
    func resizeCollectionView(size: CGSize) {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let app = calculateItemWidth(width: size.width, minWidth: APP_ITEM_MIN_WIDTH, itemSpacing: APP_ITEM_SPACING, maxCount: 3)
            let appWidth = app.0
            let appItemSize = CGSize(width: appWidth, height: appWidth + 36)
            layout.itemSize = appItemSize
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }
    
    func calculateItemWidth(width: CGFloat, minWidth: CGFloat, itemSpacing: CGFloat, maxCount: Int) -> (CGFloat, Int) {
        var itemCount = Int(width / (minWidth + itemSpacing))
        if itemCount == 0 {
            itemCount = 1
        }
        
        if itemCount > maxCount {
            itemCount = maxCount
        }
        
        let itemWidth = (width - CGFloat((itemCount + 1)) * itemSpacing) / CGFloat(itemCount)
        
        return (itemWidth, itemCount)
    }
    
    func updateResource(theArchivesArray: [TheArchives]) {
        self.theArchivesArray = theArchivesArray
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ArchivesPageCollectionViewCell: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theArchivesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let theArchives = theArchivesArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArchiveCollectionViewCell", for: indexPath) as! ArchiveCollectionViewCell
        if theArchives.HasActivation {
            cell.icon.image = UIImage(named: theArchives.Icon ?? "")
            cell.titleLabel.text = theArchives.Number
        }
        return cell
    }
    
    //点击时未激活档案则无响应
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let archives = theArchivesArray[indexPath.row]
        if archives.HasActivation {
            itemDidSelected?(archives.Project!)
        }
    }
}

//
//  PhotoCollectionViewController.swift
//  DayOneClone
//
//  Created by Ricardo Hui on 5/6/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import UIKit
import RealmSwift


class PhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var pictures : Results<Picture>?
    
    override func viewWillAppear(_ animated: Bool) {
        getPictures()
    }

    func getPictures(){
        if let realm  = try? Realm(){
            pictures = realm.objects(Picture.self)
            collectionView?.reloadData()
        }
    }
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let pictures = self.pictures{
            return pictures.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
            
            if let picture = pictures?[indexPath.row]{
                cell.previewImagView.image = picture.thumbnail()
                cell.dayLabel.text = picture.entry?.dayString()
                cell.monthYearLabel.text = picture.entry?.monthYearString()
            }
            
            return cell
        }
    
        // Configure the cell
    
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2)
    }

}

class PhotoCell : UICollectionViewCell{
    
    
    @IBOutlet var previewImagView: UIImageView!
    
    @IBOutlet var monthYearLabel: UILabel!
    
    @IBOutlet var dayLabel: UILabel!
}

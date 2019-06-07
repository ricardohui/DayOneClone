//
//  Modal.swift
//  DayOneClone
//
//  Created by Ricardo Hui on 7/6/2019.
//  Copyright © 2019 Ricardo Hui. All rights reserved.
//

import Foundation
import RealmSwift
import Toucan

class Entry : Object {
    @objc dynamic var text = ""
    @objc dynamic var date = Date()
    let pictures = List<Picture>()
}

class Picture : Object {
    @objc dynamic var fullImageName = ""
    @objc dynamic var thumbnailName = ""
    @objc dynamic var entry : Entry?
    
    convenience init(image: UIImage){
        self.init()
        fullImageName = imageToURLString(image:image)
        if let smallImage = Toucan(image: image).resize(CGSize(width: 500, height:500),fitMode: .crop).image{
            thumbnailName = imageToURLString(image: smallImage)
        }
        
    }
    
    func imageToURLString(image: UIImage)-> String{
        if let imageData = image.pngData(){
            let fileName = UUID().uuidString + ".png"
            var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            path.appendPathComponent(fileName)
            try? imageData.write(to: path)
            return fileName
        }
        return ""
    }
}
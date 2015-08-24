//
//  PhotoThumbnail.swift
//  Tag
//
//  Created by Ankita Prasad on 8/22/15.
//  Copyright (c) 2015 Ankita Prasad. All rights reserved.
//

import UIKit

class PhotoThumbnail: UICollectionViewCell {
    
    @IBOutlet var thumbnail: UIImageView!
    
    func selectThumbnail(imageThumbnail : UIImage){
        thumbnail.image = imageThumbnail
    }
    
}

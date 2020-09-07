//
//  PhotoGalleryViewCell.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class PhotoGalleryViewCell: UICollectionViewCell {
    
    static let reuseId: String = "PhotoGalleryCell"
    static let nib: UINib = {
       return UINib(nibName: "PhotoGalleryViewCell", bundle: nil)
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    
}

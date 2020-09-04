//
//  MainCollectionViewCell.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static var reuseId: String = "MainCollectionViewCell"
    static var nib: UINib = {
       UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    
    func configurationCell(_ size: CGFloat) {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.frame.size.width = size
        self.frame.size.height = size
    }
    
}

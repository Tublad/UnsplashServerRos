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
    
    override func prepareForReuse() {
        imageView.image = nil
        saveImageButton.imageView?.image = nil
    }
    
    func configurationCell(_ size: CGFloat) {
        self.layer.cornerRadius = 1
        self.clipsToBounds = true
        
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false 
        self.frame.size.width = size
        self.frame.size.height = size
    }
    
}

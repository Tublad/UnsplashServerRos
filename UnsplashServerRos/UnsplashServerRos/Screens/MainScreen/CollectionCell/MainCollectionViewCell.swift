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
        saveImageButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        saveImageButton.isEnabled = true 
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    override var isSelected: Bool  {
        didSet {
            if isSelected {
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.white.cgColor
            } else {
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    
}

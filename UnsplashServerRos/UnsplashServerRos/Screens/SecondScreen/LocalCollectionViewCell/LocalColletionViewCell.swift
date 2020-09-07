//
//  LocalColletionViewCell.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 06.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class LocalCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "LocalViewCell"
    static let nib: UINib = {
        UINib(nibName: "LocalCollectionViewCell", bundle: nil)
    }()
    
    @IBOutlet weak var saveImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deleteImageButton: UIButton!
    
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

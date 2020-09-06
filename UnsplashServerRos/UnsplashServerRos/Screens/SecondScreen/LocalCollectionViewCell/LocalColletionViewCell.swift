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
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configurationCell(_ size: CGFloat) {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 2
        self.frame.size.width = size
        self.frame.size.height = size
    }
    
}

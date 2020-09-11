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
    
    var imageClicked: ((UIView) -> ())? = nil
    
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
    
    override func awakeFromNib() {
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    @objc func pickImage() {
        imageClicked?(imageView)
        self.isSelected = false
    }
    
    
}

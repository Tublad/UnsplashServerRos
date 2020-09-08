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
    
    var imageClicked: ((UIView) -> ())? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveImageButton: UIButton!
    
    override func prepareForReuse() {
        imageView.image = nil
        saveImageButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        saveImageButton.isEnabled = true 
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func awakeFromNib() {
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    
    @objc func pickImage() {
        imageClicked?(imageView)
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

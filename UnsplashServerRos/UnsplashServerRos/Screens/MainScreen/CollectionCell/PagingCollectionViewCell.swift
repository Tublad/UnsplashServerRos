//
//  PagingCollectionViewCell.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class PagingCollectionViewCell: UICollectionViewCell {
    
    static let reuseId: String = "PagingCell"
    static nib: UINib = {
        return UINib(nibName: "PagingCollectionViewCell", bundle: nil)
    }
    
}

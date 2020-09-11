//
//  ImageScrollView.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 11.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class ImageScrollView: UIScrollView {
    
    var imageZoomView: UIImageView!
    
    func set(image: UIImage) {
        imageZoomView.removeFromSuperview()
        imageZoomView = nil
        
        imageZoomView = UIImageView(image: image)
        self.addSubview(imageZoomView)
    }
    
}

//
//  UIColor + customColor.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

    
// MARK: - Custom Color для кнопок и текста.

extension UIColor {

    static var marineColor = UIColor(r: 0, g: 150, b: 136)
    static var redColor = UIColor(r: 180, g: 55, b: 87)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255,green: g/255, blue: b/255, alpha: 1)
    }
}



//
//  ImageViewLoader.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//
import Foundation
import UIKit

class ImageLoader {

  static let cache = NSCache<NSString, NSData>()

  class func image(for url: URL, completionHandler: @escaping(_ image: UIImage?) -> ()) {

    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {

      if let data = self.cache.object(forKey: url.absoluteString as NSString) {
        DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        return
      }

      guard let data = NSData(contentsOf: url) else {
        DispatchQueue.main.async { completionHandler(nil) }
        return
      }

      self.cache.setObject(data, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
    }
  }

}

//
//  DataProvider.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

//MARK: - DataProvider

class DataProvider {
    
    static let shared = DataProvider()
    
    init(){}
    
    private var imageCache = NSCache<NSString, UIImage>()
    private var saveImageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Download image in main view
    func downloadImageUrl(id: String, url: URL, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: id as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 20)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil,
                    let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let `self` = self else {
                        return
                }
                
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: id as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}

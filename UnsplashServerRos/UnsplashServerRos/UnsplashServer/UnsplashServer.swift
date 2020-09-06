//
//  UnsplashServer.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

enum RequestError: Error {
    case failedError(message: String)
    case decodebleError
}

final class UnsplashServer {
    
    //complitionHandler: @escaping ([Picture], Error) -> Void
   static func getImageUnsplashServerForShow(complitionHandler: @escaping (Picture, Error?) -> Void) {
        let baseUrl = "https://api.unsplash.com/"
        let photosUrl = "photos?per_page=28&client_id=p1YRXPEkZGPz67f2Q265GQvNLPOFnoWV7sdmRl2hYe8"
    
        let urls = baseUrl + photosUrl
        guard let fullUrl = URL(string: urls) else { return }
        
        let session = URLSession.shared
        
        session.dataTask(with: fullUrl) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let picture = try JSONDecoder().decode(Picture.self, from: data)
                complitionHandler(picture, error)
            } catch {
                print(" вот он и nil \(error)")
            }
        }.resume()
    }
    
    static func searchImageInUnsplashServer(_ searchName: String, complitionHandler: @escaping (SearchPicture, Error?) -> Void) {
        let searchUrl = "https://api.unsplash.com/search/photos?query="
        let pageCount = "&per_page=28&client_id=p1YRXPEkZGPz67f2Q265GQvNLPOFnoWV7sdmRl2hYe8"
        
        let urls = searchUrl + searchName + pageCount
        guard let fullUrl = URL(string: urls) else { return }
        
        let session = URLSession.shared
        session.dataTask(with: fullUrl) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let picture = try JSONDecoder().decode(SearchPicture.self, from: data)
                complitionHandler(picture,error)
            } catch {
                print("А это собственно уже nil из поисковика \(error)")
            }
        }.resume()
    }
}

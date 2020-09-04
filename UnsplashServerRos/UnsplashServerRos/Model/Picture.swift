//
//  Picture.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import Foundation

class SearchPicture: Codable {
    let results: [PictureElement]

    init(results: [PictureElement]) {
        self.results = results
    }
}


// MARK: - PictureElement
class PictureElement: Codable {
    let id: String
    let urls: Urls

    init(id: String, urls: Urls) {
        self.id = id
        self.urls = urls
    }
}

// MARK: - Urls
class Urls: Codable {
    let full, small: String

    init(full: String, small: String) {
        self.full = full
        self.small = small
    }
}

typealias Picture = [PictureElement]

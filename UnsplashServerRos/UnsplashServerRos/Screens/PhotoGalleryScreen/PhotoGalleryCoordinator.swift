//
//  PhotoGalleryCoordinator.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol PhotoGalleryCoordination {
    
}

final class PhotoGalleryCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    //MARK: - Open properties
    override func start() {
        let vc = PhotoGalleryViewController()
        let presenter = PhotoGalleryPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        
        navController.pushViewController(vc, animated: true)
    }
    
    func startPhotoGallery(picture: Picture, count: Int) {
        let vc = PhotoGalleryViewController()
        let presenter = PhotoGalleryPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        vc.picture = picture
        vc.count = count
        
        navController.pushViewController(vc, animated: true)
    }
    
}


//MARK: - PhotoGalleryInCoordination
extension PhotoGalleryCoordinator: PhotoGalleryCoordination {
    
}

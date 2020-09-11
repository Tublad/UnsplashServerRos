//
//  LocalCoordinator.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit


protocol LocalCoordination {
    func showPhotoGallery(vc: LocalViewController, picture: Picture, count: Int)
}


final class LocalCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    //MARK: - Open properties
    override func start() {
        let vc = LocalViewController()
        let presenter = LocalPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        
        navController.pushViewController(vc, animated: true)
    }
    
    func startLocalView(picture: Picture) {
        let vc = LocalViewController()
        let presenter = LocalPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        vc.picture = picture
        
        navController.pushViewController(vc, animated: true)
    }
}


//MARK: - LocalInCoordination
extension LocalCoordinator: LocalCoordination {
    
    func showPhotoGallery(vc: LocalViewController, picture: Picture, count: Int) {
        let delegate = ImageViewerPresenter(delegate: vc)
        navController.delegate = delegate
        let photoGalleryCoordinator = PhotoGalleryCoordinator(navController: navController)
        self.parentCoordinator?.setDependence(withChildCoordinator: photoGalleryCoordinator)
        photoGalleryCoordinator.startPhotoGallery(picture: picture, count: count)
        self.parentCoordinator?.didFinish(coordinator: self)
    }

}

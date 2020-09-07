//
//  PhotoGalleryPresenter.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

protocol PhotoGalleryViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
}

protocol PhotoGalleryViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
}


final class PhotoGalleryPresenter {
    
    //MARK: - Private properties
    private weak var view: PhotoGalleryViewControllerImpl?
    private let coordinator: PhotoGalleryCoordination
    
    
    //MARK: - Init
    init(view: PhotoGalleryViewControllerImpl, coordinator: PhotoGalleryCoordination) {
        self.view = view
        self.coordinator = coordinator
    }
}

extension PhotoGalleryPresenter: PhotoGalleryViewAction {
    
}


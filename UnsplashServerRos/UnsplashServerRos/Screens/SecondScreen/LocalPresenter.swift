//
//  LocalPresenter.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol LocalViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
    func sourceView(view: UIView, picture: Picture, count: Int)
    func showGalleryViewController(vc: LocalViewController, picture: Picture, count: Int)
}

protocol LocalViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
    func sourceView(view: UIView, picture: Picture, count: Int)
}


final class LocalPresenter {
    
    //MARK: - Private properties
    private weak var view: LocalViewControllerImpl?
    private let coordinator: LocalCoordination
    
    
    //MARK: - Init
    init(view: LocalViewControllerImpl, coordinator: LocalCoordination) {
        self.view = view
        self.coordinator = coordinator
    }
}


extension LocalPresenter: LocalViewAction {
    
    func sourceView(view: UIView, picture: Picture, count: Int) {
        self.view?.sourceView(view: view, picture: picture, count: count)
    }
    
    func showGalleryViewController(vc: LocalViewController, picture: Picture, count: Int) {
        self.coordinator.showPhotoGallery(vc: vc, picture: picture, count: count)
    }
    
}

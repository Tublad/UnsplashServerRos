//
//  LocalPresenter.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

protocol LocalViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
}

protocol LocalViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
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
    
}

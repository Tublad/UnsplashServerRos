//
//  LocalViewController.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

final class LocalViewController: UIViewController, ImageViewPresenterSource {
    
    //MARK: - Open properties
    // презентору сообщаем обо всех действиях и передаем данные, например: презентер, была нажата кнопка войти
    var presenter: LocalViewAction?
    var source: UIView?
    var picture: Picture?
    
    //MARK: - Private properties
    
    //вью просим отобразить контент
    private lazy var localView = view as? LocalViewImpl
    
    //MARK: - Life cycle
    //устанавливаем вью
    override func loadView() {
        view = LocalView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = localView, let presenter = presenter, let listPicture = picture {
            view.setPresenter(presenter)
            view.getContent(listPicture)
        }
        setNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Private metods
    
    //Устанавливаем навигацию, заголовок навигейшен контроллера, кнопки на навиг контроллере
    private func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "LocalMemory"
    }
}


extension LocalViewController: LocalViewControllerImpl {
    
    func sourceView(view: UIView, picture: Picture, count: Int) {
        self.source = view
        self.presenter?.showGalleryViewController(vc: self, picture: picture, count: count)
    }
}


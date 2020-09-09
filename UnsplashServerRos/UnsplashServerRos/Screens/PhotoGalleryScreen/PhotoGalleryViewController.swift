//
//  PhotoGalleryViewController.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

final class PhotoGalleryViewController: UIViewController {
    
    //MARK: - Open properties
    // презентору сообщаем обо всех действиях и передаем данные, например: презентер, была нажата кнопка войти
    var presenter: PhotoGalleryViewAction?
    var picture: Picture?
    var count: Int?
    
    //MARK: - Private properties
    
    //вью просим отобразить контент
    private lazy var photoGalleryView = view as? PhotoGalleryViewImpl
    
    //MARK: - Life cycle
    //устанавливаем вью
    override func loadView() {
        view = PhotoGalleryView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = photoGalleryView, let presenter = presenter {
            view.setPresenter(presenter)
            view.getContent(picture: picture ?? Picture(), count: count ?? 0)
        }
        setNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let view = photoGalleryView {
            view.scrollCollection()
        }
    }
    
    //MARK: - Private metods
    
    //Устанавливаем навигацию, заголовок навигейшен контроллера, кнопки на навиг контроллере
    private func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Gallery"
    }
}


extension PhotoGalleryViewController: PhotoGalleryViewControllerImpl {

}


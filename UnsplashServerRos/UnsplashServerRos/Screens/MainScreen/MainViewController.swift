//
//  ViewController.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Open properties
    // презентору сообщаем обо всех действиях и передаем данные, например: презентер, была нажата кнопка войти
    var presenter: MainViewAction?
    
    //MARK: - Private properties
    
    //вью просим отобразить контент
    private lazy var mainView = view as? MainViewImpl
    
    //MARK: - Life cycle
    //устанавливаем вью
    override func loadView() {
        view = MainView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = mainView, let presenter = presenter {
            view.setPresenter(presenter)
        }
        //            UnsplashServer.searchImageInUnsplashServer("canada")
        setNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUnsplashServiceContent()
    }
    
    //MARK: - Private metods
    
    //Устанавливаем навигацию, заголовок навигейшен контроллера, кнопки на навиг контроллере
    private func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Unsplash"
    }
    
}


extension MainViewController: MainViewControllerImpl {
    
    func getUnsplashServiceContent() {
        UnsplashServer.getImageUnsplashServerForShow { [weak self] (picture, error) in
            if error == nil {
                print(error?.localizedDescription)
            }
            if let view = self?.mainView {
                view.getContent(picture)
            }
        }
    }

}

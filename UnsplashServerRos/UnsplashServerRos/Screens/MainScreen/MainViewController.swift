//
//  ViewController.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 03.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, ImageViewPresenterSource {
    
    //MARK: - Open properties
    // презентору сообщаем обо всех действиях и передаем данные, например: презентер, была нажата кнопка войти
    var presenter: MainViewAction?
    var source: UIView?
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
            presenter.getImage()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigation()
    }
    
    //MARK: - Private metods
    
    //Устанавливаем навигацию, заголовок навигейшен контроллера, кнопки на навиг контроллере
    private func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Unsplash"
        self.navigationController?.navigationBar.tintColor = UIColor.marineColor
        
        let rightButton = UIBarButtonItem(title: "Local Memory", style: .plain, target: self, action: #selector(showLocalViewController))
        navigationItem.rightBarButtonItem = rightButton
    }
}

extension MainViewController: MainViewControllerImpl {
    func sourceView(view: UIView, picture: Picture, count: Int) {
        self.source = view
        self.presenter?.showGalleryViewController(vc: self, picture: picture, count: count)
    }
    
    func deleteButton() {
        navigationItem.leftBarButtonItem = nil
    }
    
    func showButton() {
        let button = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveImageList))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func saveImageList() {
        if let view = mainView {
            view.saveListImage()
        }
    }
    
    func searchImageInUnsplashServer(text: String) {
        if text.count > 0 {
            UnsplashServer.searchImageInUnsplashServer(1, text) { [weak self] (searchPicture, error) in
                if error != nil,
                   let error = error {
                    print(error.localizedDescription)
                }
                if let view = self?.mainView {
                    view.getContent(searchPicture.results)
                }
            }
        }
    }
    
    func getUnsplashServiceContent() {
        UnsplashServer.getImageUnsplashServerForShow { [weak self] (picture, error) in
           if error != nil,
               let error = error {
                print(error.localizedDescription)
            }
            if let view = self?.mainView {
                view.getContent(picture)
            }
        }
    }
    
    @objc func showLocalViewController(_ sender: UIButton) {
        self.presenter?.showLocalViewController()
    }
    
}


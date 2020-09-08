
import UIKit


protocol MainViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
    func searchText(_ text: String)
    func getImage()
    func showLocalViewController()
    func actionDoubleTap()
    func getButtonForSaveList()
    func deleteButtonSave()
    func pickImage()
}

protocol MainViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
    func getUnsplashServiceContent()
    func searchImageInUnsplashServer(text: String)
    func showButton()
    func doubleTap()
    func deleteButton()
}


final class MainPresenter {
    
    //MARK: - Private properties
    private weak var view: MainViewControllerImpl?
    private let coordinator: MainCoordination
    
    
    //MARK: - Init
    init(view: MainViewControllerImpl, coordinator: MainCoordination) {
        self.view = view
        self.coordinator = coordinator
    }
}


extension MainPresenter: MainViewAction {
    
    func pickImage() {
        self.coordinator.showPhotoGallery()
    }
    
    func deleteButtonSave() {
        self.view?.deleteButton()
    }
    
    func getButtonForSaveList() {
        self.view?.showButton()
    }
    
    func searchText(_ text: String) {
        self.view?.searchImageInUnsplashServer(text: text)
    }
    
    func getImage() {
        self.view?.getUnsplashServiceContent()
    }
    
    func actionDoubleTap() {
        self.view?.doubleTap()
    }
    
    func showLocalViewController() {
        self.coordinator.showLocalViewController()
    }
}

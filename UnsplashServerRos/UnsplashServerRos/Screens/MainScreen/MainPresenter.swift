
import Foundation


protocol MainViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
    func searchText(_ text: String)
    func getImage()
    func showLocalViewController()
}

protocol MainViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
    func getUnsplashServiceContent()
    func searchImageInUnsplashServer(text: String)
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
    
    func searchText(_ text: String) {
        self.view?.searchImageInUnsplashServer(text: text)
    }
    
    func getImage() {
        self.view?.getUnsplashServiceContent()
    }
    
    func showLocalViewController() {
        self.coordinator.showLocalViewController()
    }
}

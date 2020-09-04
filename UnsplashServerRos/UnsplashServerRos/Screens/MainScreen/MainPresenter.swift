
import Foundation


protocol MainViewAction: class {
    //фунции типа кнопка войти, забыли пароль, и тп. была нажата
}

protocol MainViewControllerImpl: class {
    //функции типа показать загрузку, установить делегатов
    func getUnsplashServiceContent()
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
    
}

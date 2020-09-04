
import UIKit


protocol MainCoordination {
    
}


final class MainCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    //MARK: - Open properties
    override func start() {
        let vc = MainViewController()
        let presenter = MainPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        
        navController.pushViewController(vc, animated: false)
    }
}


//MARK: - SignInCoordination
extension MainCoordinator: MainCoordination {
    


}


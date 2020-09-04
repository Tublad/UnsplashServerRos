import UIKit
import CoreData

protocol MainShowing {
    func showMain()
}


final class AppCoordinator: BaseCoordirator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let navController: UINavigationController
    
    
    // MARK: - Init
    init(window: UIWindow, navController: UINavigationController) {
        self.window = window
        self.navController = navController
    }
    
    
    //MARK: - Open metods
    override func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        parentCoordinator = nil
        
        showMain()
    }
}


//MARK: - MainShowing

extension AppCoordinator: MainShowing {
    
    func showMain() {
        // present main view controller
        let mainInCoordinator = MainCoordinator(navController: navController)
        self.setDependence(withChildCoordinator: mainInCoordinator)
        mainInCoordinator.start()
    }
}



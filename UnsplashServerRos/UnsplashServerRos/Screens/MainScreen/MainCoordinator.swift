
import UIKit


protocol MainCoordination {
    func showLocalViewController(picture: Picture)
    func showPhotoGallery(vc: MainViewController, picture: Picture, count: Int)
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
        
        navController.pushViewController(vc, animated: true)
    }
}


//MARK: - MainCoordination
extension MainCoordinator: MainCoordination {
    
    func showLocalViewController(picture: Picture) {
        let localCoordinator = LocalCoordinator(navController: navController)
        self.parentCoordinator?.setDependence(withChildCoordinator: localCoordinator)
        localCoordinator.startLocalView(picture: picture)
        self.parentCoordinator?.didFinish(coordinator: self)
        
    }
    
    func showPhotoGallery(vc: MainViewController, picture: Picture, count: Int) {
        let delegate = ImageViewerPresenter(delegate: vc)
        navController.delegate = delegate
        let photoGalleryCoordinator = PhotoGalleryCoordinator(navController: navController)
        self.parentCoordinator?.setDependence(withChildCoordinator: photoGalleryCoordinator)
        photoGalleryCoordinator.startPhotoGallery(picture: picture, count: count)
        self.parentCoordinator?.didFinish(coordinator: self)
    }
}


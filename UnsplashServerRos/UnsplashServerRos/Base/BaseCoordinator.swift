
import UIKit


protocol Coordinator: AnyObject {
    var parentCoordinator: BaseCoordirator? { get set }
    var childCoordinators: [BaseCoordirator] { get set }
    
    func start()
}


class BaseCoordirator: Coordinator {
    
    //MARK: - Coordinator
    weak var parentCoordinator: BaseCoordirator?
    var childCoordinators: [BaseCoordirator] = []
    
    func start() {
        print("Will be redefined in childrens")
    }
}


extension BaseCoordirator {
    
    //добавляет координатор в дочерние и себя в его родителя
    func setDependence(withChildCoordinator coordinator: BaseCoordirator) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
    }
    
    //когда закрываеем экран, удаляем координатор из дочерних родителя
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
    
    //ищет среди родительстких координаторов, тот который реализует нужный нам протокол
    func findListener<T>(parent: Coordinator?) -> T? {
        guard let parent = parent
            else { return nil }
        
        if parent is T {
            let listener = parent as! T
            return listener
        }
        else {
            let parent = parent.parentCoordinator
            return findListener(parent: parent)
        }
    }
}


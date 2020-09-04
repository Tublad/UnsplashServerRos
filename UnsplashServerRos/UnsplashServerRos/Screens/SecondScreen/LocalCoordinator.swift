//
//  LocalCoordinator.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 04.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit


protocol LocalCoordination {
    
}


final class LocalCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    //MARK: - Open properties
    override func start() {
        let vc = LocalViewController()
        let presenter = LocalPresenter(view: vc, coordinator: self)
        vc.presenter = presenter
        
        navController.pushViewController(vc, animated: false)
    }
}


//MARK: - LocalInCoordination
extension LocalCoordinator: LocalCoordination {
    


}

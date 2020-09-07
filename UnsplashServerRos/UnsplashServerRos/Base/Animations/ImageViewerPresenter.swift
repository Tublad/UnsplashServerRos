//
//  ImageViewerPresenter.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol ImageViewPresenterSource: UIViewController {
    var source: UIView? { get }
}

class ImageViewerPresenter: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    var animatorSource: ImageViewPresenterSource?
    var animator = PopAnimator()
    
    init(delegate: ImageViewPresenterSource) {
        self.animatorSource = delegate
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let sourceView = animatorSource?.source,
            let view = UIApplication.topViewController()?.navigationController?.view,
            let original = sourceView.superview?.convert(sourceView.frame,
                                                         to: view)  else {
                                                            return nil
        }
        animator.originalFrame = CGRect(x: original.minX,
                                        y: original.minY,
                                        width: original.size.width,
                                        height: original.size.height)
        return animator
    }
    
    
}

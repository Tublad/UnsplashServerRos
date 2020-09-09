//
//  ImageViewerPresenter.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 08.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

protocol ImageViewPresenterSource: UIViewController {
    var source: UIView? { get }
}

class ImageViewerPresenter: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    var animatorSource: ImageViewPresenterSource?
    var animator = PushAnimator()
    
    init(delegate: ImageViewPresenterSource) {
        animatorSource = delegate
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let sourceView = animatorSource?.source,
            let origin = sourceView.superview?.convert(sourceView.frame,
                                                       to: UIApplication.topViewController()?.navigationController?.view) else {
             return nil
        }
        
        animator.originFrame = CGRect(x: origin.minX,
                                      y: origin.minY,
                                      width: origin.size.width,
                                      height: origin.size.height)
        return animator
    }
}

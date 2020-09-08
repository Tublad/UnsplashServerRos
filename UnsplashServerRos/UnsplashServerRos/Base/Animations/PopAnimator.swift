//
//  PopAnimator.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 07.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let duration = 1.0
    var originalFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let recipeView = toView
        
        let finalFrame = recipeView.frame
        
        let xScaleFrame = originalFrame.width / finalFrame.width
        let yScaleFrame = originalFrame.height / finalFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFrame, y: yScaleFrame)
        
        recipeView.transform = scaleTransform
        recipeView.center = CGPoint(x: originalFrame.midX, y: originalFrame.midY)
        
        recipeView.clipsToBounds = true
        
        conteinerView.addSubview(toView)
        conteinerView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: duration,
                       animations: {
                        recipeView.transform = .identity
                        recipeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { (isCompletion) in
            transitionContext.completeTransition(isCompletion)
        }
    }
    
}

//
//  PopAnimator.swift
//  UnsplashServerRos
//
//  Created by Евгений Шварцкопф on 08.09.2020.
//  Copyright © 2020 Евгений Шварцкопф. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let conteinerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let recipeView = toView
        
        let finalFrame = recipeView.frame
        
        let xScaleFactor = originFrame.width / finalFrame.width
        let yScaleFactor = originFrame.height / finalFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        recipeView.transform = scaleTransform
        recipeView.center = CGPoint(x: originFrame.midX, y: originFrame.midY)
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


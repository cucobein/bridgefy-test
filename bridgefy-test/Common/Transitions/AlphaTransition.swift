//
//  AlphaTransition.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

final class AlphaTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: Double = 0.2
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        toView.frame = fromView.frame
        transitionContext.containerView.addSubview(toView)
        toView.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            toView.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}

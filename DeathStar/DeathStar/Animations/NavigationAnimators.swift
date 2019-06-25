//
//  NavigationAnimators.swift
//  PhunApp
//
//  Created by Sam Patteson on 7/29/18.
//  Copyright © 2018 Sam Patteson. All rights reserved.
//

import UIKit
import QuartzCore

class DetailPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // SIMPLE FADE
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let container = transitionContext.containerView
        
        container.addSubview(toVC.view)
        toVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toVC.view.alpha = 1.0
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
}

class DetailPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    private let image: UIImage
    
    init(originFrame: CGRect, image: UIImage) {
        self.originFrame = originFrame
        self.image = image
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let containerView = transitionContext.containerView

        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let partialSnap = UIImageView.init(image: image)
        let bgroundView = UIView(frame: toVC.view.frame)
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        bgroundView.backgroundColor = .white
        partialSnap.frame = originFrame
        
        toVC.view.frame.origin.y = originFrame.origin.y

        containerView.addSubview(bgroundView)
        containerView.addSubview(toVC.view)
        containerView.addSubview(partialSnap)
        
        toVC.view.alpha = 0.0
        bgroundView.alpha = 0.0
        partialSnap.alpha = 0.0
        
        UIView.animate(withDuration: 0.50, delay: 0.0, options: .curveEaseIn, animations: {
            // expand the image for selection effect
            bgroundView.alpha = 1.0
            partialSnap.alpha = 0.35
            partialSnap.frame = CGRect(x: toVC.view.frame.origin.x,
                                       y: self.originFrame.origin.y,
                                       width: toVC.view.frame.size.width,
                                       height: 300.0)
        }) { _ in
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                    // move the image and toVC up to the the top of the frame
                    partialSnap.alpha = 0.0
                    partialSnap.frame.origin.y = finalFrame.origin.y - 24.0
                    toVC.view.frame.origin.y = finalFrame.origin.y - 24.0
                    toVC.view.alpha = 1.0
                }, completion: { _ in
                        bgroundView.removeFromSuperview()
                        partialSnap.removeFromSuperview()
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.80
    }
}

//
//  LeftToRightAnimationController.swift
//  WebImageCollector
//
//  Created by fuji2013 on 2015/01/22.
//  Copyright (c) 2015年 fuji2013. All rights reserved.
//

import UIKit

class LeftToRightAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        fromViewController.view.alpha = 0.5

        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrame = transitionContext.finalFrameForViewController(toViewController)
        
        let containerView = transitionContext.containerView()
        
        // 遷移前の状態
        let screenBounds = UIScreen.mainScreen().bounds
        toViewController.view.frame = CGRectOffset(finalFrame, screenBounds.size.width * -1, 0)
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95)
            toViewController.view.frame = finalFrame
        }, completion: {
            finished in
            fromViewController.view.alpha = 1.0
            fromViewController.view.transform = CGAffineTransformIdentity
            let completeFlg = !transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(completeFlg)
        })
    }
}

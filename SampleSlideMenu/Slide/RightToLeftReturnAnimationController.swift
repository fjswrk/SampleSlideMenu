//
//  RightToLeftReturnAnimationController.swift
//
//  Created by fuji2013 on 2015/01/22.
//  Copyright (c) 2015年 fuji2013. All rights reserved.
//

import UIKit

class RightToLeftReturnAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
   
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // fromViewControllr 消えるやつ
        // toViewController 出てくる奴
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        let finalFrame = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()
        
        toViewController.view.frame = finalFrame
        toViewController.view.alpha = 0.5
        containerView.addSubview(toViewController.view)
        containerView.sendSubviewToBack(toViewController.view)
        toViewController.view.transform = CGAffineTransformMakeScale(0.95, 0.95)
        
        // 遷移前の状態
        let screenBounds = UIScreen.mainScreen().bounds

        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.frame = CGRectOffset(finalFrame, screenBounds.size.width * -1, 0)
            toViewController.view.transform = CGAffineTransformIdentity
            toViewController.view.alpha = 1.0

        }, completion: {
            finished in
            
            toViewController.view.transform = CGAffineTransformIdentity
            toViewController.view.alpha = 1.0
            let completeFlg = !transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(completeFlg)
        })
    }
    
}

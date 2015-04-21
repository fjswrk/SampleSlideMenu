//
//  SwipeInteractionController.swift
//  WebImageCollector
//
//  Created by fuji2013 on 2015/01/23.
//  Copyright (c) 2015年 fuji2013. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    private var shouldCompleteTransition = false
    private var navigationController:UINavigationController!
    private var viewController:UIViewController!
    var interactionProgress = false
    var completionSeed: CGFloat{
        return 1 - percentComplete
    }
    
    func wireToViewController(viewController:UIViewController){
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    private func prepareGestureRecognizerInView(view:UIView){
        let gesture = UIPanGestureRecognizer(target: self, action: "handleGesture:")
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(gestureRecgnizer:UIPanGestureRecognizer){
        let translation = gestureRecgnizer.translationInView(gestureRecgnizer.view!.superview!)
        let a = gestureRecgnizer.view!.superview!.frame
        let b = gestureRecgnizer.view!.frame
        switch gestureRecgnizer.state{
            
        case .Began:
            interactionProgress = true
            viewController.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            
            let viewRect = self.viewController.view.bounds
            var fraction = (translation.x / viewRect.size.width * -1)
            
            shouldCompleteTransition = fraction > 0.5
            
            updateInteractiveTransition(fraction)
            
        case .Ended, .Cancelled:
            interactionProgress = false
            if !shouldCompleteTransition || gestureRecgnizer.state == .Cancelled{
                cancelInteractiveTransition()
            }else{
                finishInteractiveTransition()
            }
        default:
            println("unsupported state")
        }
    }
    
}

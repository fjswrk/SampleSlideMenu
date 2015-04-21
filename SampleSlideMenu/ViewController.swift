//
//  ViewController.swift
//  SampleSlideMenu
//
//  Created by fuji2013 on 2015/04/21.
//  Copyright (c) 2015年 fuji2013. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIViewControllerTransitioningDelegate {
    // Animator
    private let leftToRightAnimator = LeftToRightAnimationController()
    private let rightToLeftAnimator = RightToLeftReturnAnimationController()
    private let swipeInteractionController = SwipeInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let btn = UIButton.buttonWithType(.System) as! UIButton
        btn.setTitle("Tap", forState: UIControlState.Normal)
        btn.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 40.0)
        btn.center = view.center
        btn.addTarget(self, action: "pressBtn:", forControlEvents: .TouchUpInside)
        view.addSubview(btn)
    }
    
    func pressBtn(sender:UIButton){
        let controller = LeftViewController()
        controller.transitioningDelegate = self;
        presentViewController(controller, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return swipeInteractionController.interactionProgress ? swipeInteractionController : nil
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        swipeInteractionController.wireToViewController(presented)
        return leftToRightAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        swipeInteractionController.wireToViewController(dismissed)
        return rightToLeftAnimator
    }

    
}


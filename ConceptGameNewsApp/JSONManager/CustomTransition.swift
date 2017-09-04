//
//  CustomTransition.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/16/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit

enum TransitionType {
    case presenting, dismissing
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 0.0
    var isPresenting: Bool = false
    var originFrame: CGRect = CGRect.zero
    var dismissCompletion: (()->Void)?
    /*
    init(withDuration duration: TimeInterval, forTransitionType type: TransitionType, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = type == .presenting
        self.originFrame = originFrame
        
        super.init()
    }
    */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        let detailView = self.isPresenting ? toView : fromView
        
        if self.isPresenting {
            containerView.addSubview(toView!)
        } else {
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        
        detailView?.frame.origin = self.isPresenting ? self.originFrame.origin : CGPoint(x: 0, y: 0)
        detailView?.frame.size.width = self.isPresenting ? self.originFrame.size.width : containerView.bounds.width
        detailView?.layoutIfNeeded()
        
        for view in detailView!.subviews {
            if !(view is UIImageView) {
                view.alpha = isPresenting ? 0.0 : 1.0
            }
        }
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            detailView?.frame = self.isPresenting ? containerView.bounds : self.originFrame
            detailView?.layoutIfNeeded()
            
            for view in detailView!.subviews {
                if !(view is UIImageView) {
                    view.alpha = self.isPresenting ? 1.0 : 0.0
                }
            }
        }) { (completed: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

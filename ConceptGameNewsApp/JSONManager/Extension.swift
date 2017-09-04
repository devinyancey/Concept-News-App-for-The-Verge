//
//  Extension.swift
//  ConceptGameNewsApp
//
//  Created by Devin Yancey on 6/16/17.
//  Copyright © 2017 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit
import WebKit
/*
extension ViewController: UIViewControllerTransitioningDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController()
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("ran")
        return AnimationController()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
*/
extension UIView{
    func instanceFromNib(name: String) -> UIView {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}

//extension UIViewController{
//    struct URLStruct {
//        static var url : URL?
//        static var webview : WKWebView?
//    }
//    
//    
//}

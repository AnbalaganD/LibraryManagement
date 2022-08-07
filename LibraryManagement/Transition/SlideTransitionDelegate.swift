//
//  SlideRightTransitionDelegate.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

class SlideTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source _: UIViewController) -> UIPresentationController? {
        return SlidePresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitionAnimator(isPresentation: true)
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideTransitionAnimator(isPresentation: false)
    }
}

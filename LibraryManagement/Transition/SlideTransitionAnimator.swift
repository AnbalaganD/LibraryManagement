//
//  SlideRightTransitionAnimator.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class SlideTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresentation: Bool

    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }

    func transitionDuration(
        using _: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return 0.3
    }

    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!

        var finalFrame = transitionContext.finalFrame(for: controller)

        if isPresentation {
            containerView.addSubview(controller.view)
        }

        controller.view.frame.origin.x = isPresentation ? -containerView.frame.width : finalFrame.origin.x

        if !isPresentation {
            finalFrame.origin.x = -containerView.frame.width
        }

        UIView.animate(withDuration: duration, animations: {
            controller.view.frame = finalFrame
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}

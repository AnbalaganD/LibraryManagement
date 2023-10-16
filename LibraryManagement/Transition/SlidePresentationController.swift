//
//  SlidePresentationController.swift
//  LibraryManagement
//
//  Created by Anbu on 16/05/19.
//  Copyright © 2019 Anbalagan D. All rights reserved.
//

import UIKit

final class SlidePresentationController: UIPresentationController {
    private var dimmingView: UIView!

    override init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?
    ) {
        super.init(
            presentedViewController: presentedViewController,
            presenting: presentingViewController
        )
        setupDimmingView()
    }

    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[dimmingView]|",
                options: [],
                metrics: nil,
                views: ["dimmingView": dimmingView!]
            )

            +

            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[dimmingView]|",
                options: [],
                metrics: nil,
                views: ["dimmingView": dimmingView!]
            )
        )

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        var rect: CGRect = .zero
        rect.size = size(
            forChildContentContainer: presentingViewController,
            withParentContainerSize: containerView!.bounds.size
        )
        return rect
    }

    override func size(
        forChildContentContainer _: UIContentContainer,
        withParentContainerSize parentSize: CGSize
    ) -> CGSize {
        let width = min(parentSize.width, parentSize.height) * (2.5 / 3.0)
        return CGSize(
            width: width,
            height: parentSize.height
        )
    }
}

extension SlidePresentationController {
    private func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.15)
        dimmingView.alpha = 0.0

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDimmingViewTapped)
        )
        dimmingView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleDimmingViewTapped() {
        presentingViewController.dismiss(animated: true)
    }
}

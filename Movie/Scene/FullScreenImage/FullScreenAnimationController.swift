//
//  FullScreenAnimationController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import UIKit

final class FullScreenAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  enum AnimationType {
    case present
    case dismiss
  }
  
  private let animationType: AnimationType
  private let animationDuration: TimeInterval
  
  init(animationType: AnimationType, animationDuration: TimeInterval = 0.3) {
    self.animationType = animationType
    self.animationDuration = animationDuration
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    animationDuration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    switch animationType {
    case .present:
      guard
        let toViewController = transitionContext.viewController(forKey: .to)
      else {
        return transitionContext.completeTransition(false)
      }
      transitionContext.containerView.insertSubview(toViewController.view, at: 1)
      NSLayoutConstraint.activate([
        transitionContext.containerView.leadingAnchor.constraint(equalTo: toViewController.view.leadingAnchor),
        transitionContext.containerView.topAnchor.constraint(equalTo: toViewController.view.topAnchor),
        transitionContext.containerView.trailingAnchor.constraint(equalTo: toViewController.view.trailingAnchor),
        transitionContext.containerView.bottomAnchor.constraint(equalTo: toViewController.view.bottomAnchor)
      ])
      toViewController.view.layoutIfNeeded()
      transitionContext.completeTransition(true)
    case .dismiss:
      return transitionContext.completeTransition(true)
    }
  }
  
}

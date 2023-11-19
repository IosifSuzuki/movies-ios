//
//  FullScreenTransitionManager.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import UIKit

final class FullScreenTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
  
  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    return FullScreenPresentationController(presentedViewController: presented, presenting: presenting)
  }
  
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      FullScreenAnimationController(animationType: .present)
  }

  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      FullScreenAnimationController(animationType: .dismiss)
  }
  
}

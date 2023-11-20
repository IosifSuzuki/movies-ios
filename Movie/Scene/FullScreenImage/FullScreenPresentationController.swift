//
//  FullScreenPresentationController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation
import UIKit

final class FullScreenPresentationController: UIPresentationController {
  
  private let blurEffect = UIBlurEffect(style: .systemThinMaterial)
  
  private lazy var closeButtonContainer: UIVisualEffectView = {
    let closeButtonBlurEffectView = UIVisualEffectView(effect: blurEffect)
    closeButtonBlurEffectView.translatesAutoresizingMaskIntoConstraints = false
    let vibrancyEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
    vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false
    
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "xmark"), for: .normal)
    button.addTarget(self, action: #selector(close), for: .primaryActionTriggered)
    
    closeButtonBlurEffectView.contentView.addSubview(vibrancyEffectView)
    vibrancyEffectView.contentView.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: vibrancyEffectView.leadingAnchor),
      button.topAnchor.constraint(equalTo: vibrancyEffectView.topAnchor),
      button.trailingAnchor.constraint(equalTo: vibrancyEffectView.trailingAnchor),
      button.bottomAnchor.constraint(equalTo: vibrancyEffectView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      vibrancyEffectView.leadingAnchor.constraint(equalTo: closeButtonBlurEffectView.leadingAnchor),
      vibrancyEffectView.topAnchor.constraint(equalTo: closeButtonBlurEffectView.topAnchor),
      vibrancyEffectView.trailingAnchor.constraint(equalTo: closeButtonBlurEffectView.trailingAnchor),
      vibrancyEffectView.bottomAnchor.constraint(equalTo: closeButtonBlurEffectView.bottomAnchor),
      
      closeButtonBlurEffectView.heightAnchor.constraint(equalToConstant: 48),
      closeButtonBlurEffectView.heightAnchor.constraint(equalTo: closeButtonBlurEffectView.widthAnchor)
    ])
    
    closeButtonBlurEffectView.layer.cornerRadius = 24
    closeButtonBlurEffectView.clipsToBounds = true
    
    return closeButtonBlurEffectView
  }()
  
  private lazy var backgroundView: UIVisualEffectView = {
    let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
    blurVisualEffectView.translatesAutoresizingMaskIntoConstraints = false
    blurVisualEffectView.effect = nil
    
    return blurVisualEffectView
  }()
  
  @objc private func close(_ button: UIButton) {
    presentedViewController.dismiss(animated: true)
  }
  
}

// MARK: UIPresentationController
extension FullScreenPresentationController {
  
  override var frameOfPresentedViewInContainerView: CGRect {
    UIApplication.shared.currentWindow?.bounds ?? .zero
  }
  
  override func presentationTransitionWillBegin() {
    guard let containerView else { return }
    
    containerView.addSubview(backgroundView)
    containerView.addSubview(closeButtonContainer)
    
    NSLayoutConstraint.activate([
      backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      containerView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: closeButtonContainer.trailingAnchor, constant: 16),
      containerView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: closeButtonContainer.topAnchor, constant: -16)
    ])
    
    containerView.setNeedsLayout()
    containerView.layoutIfNeeded()
    
    guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
    
    closeButtonContainer.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    transitionCoordinator.animate(alongsideTransition: { _ in
      self.backgroundView.effect = self.blurEffect
      self.closeButtonContainer.transform = .identity
    })
    
  }
  
  override func presentationTransitionDidEnd(_ completed: Bool) {
    if !completed {
      backgroundView.removeFromSuperview()
      closeButtonContainer.removeFromSuperview()
    }
  }
  
  override func dismissalTransitionWillBegin() {
    guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
    
    transitionCoordinator.animate(alongsideTransition: { _ in
      self.backgroundView.effect = nil
      self.closeButtonContainer.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
    })
  }
  
  override func dismissalTransitionDidEnd(_ completed: Bool) {
    guard completed else {
      return
    }
    
    backgroundView.removeFromSuperview()
    closeButtonContainer.removeFromSuperview()
  }
  
}

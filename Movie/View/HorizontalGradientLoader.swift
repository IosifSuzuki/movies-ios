//
//  HorizontalGradientLoader.swift
//  Movie
//
//  Created by Bogdan Petkanych on 03.11.2023.
//

import UIKit

class HorizontalGradientLoader: UIView {
  
  private let gradientLayer = CAGradientLayer()
  private var state: State = .stop
  
  var colors: [UIColor]? {
    didSet {
      setNeedsDisplay()
    }
  }
  
  var duration: CGFloat = 0.1 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    gradientLayer.frame = rect
    setupLayer()
  }
  
  func startAnimation() {
    guard case state = .stop else {
      return
    }
    self.state = .start
    isHidden = false
    addAnimationToGradient()
  }
  
  func stopAnimation() {
    self.state = .stop
    
    isHidden = true
    gradientLayer.removeAllAnimations()
  }
  
}

// MARK: - Private methods
private extension HorizontalGradientLoader {
  
  func setupLayer() {
    gradientLayer.colors = colors?.map { $0.cgColor }
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    
    layer.addSublayer(gradientLayer)
  }
  
  func prepareAnimation(fromValues: [Any]?, toValues: [Any]?, duration: CGFloat) -> CABasicAnimation {
    let colorGradientAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
    colorGradientAnimation.fromValue = fromValues
    colorGradientAnimation.toValue = toValues
    colorGradientAnimation.duration = duration
    colorGradientAnimation.delegate = self
    return colorGradientAnimation
  }
  
  func addAnimationToGradient() {
    let fromValues = gradientLayer.colors
    let toValues = gradientLayer.colors?.rightShift()
    let animation = prepareAnimation(fromValues: fromValues, toValues: toValues, duration: duration)
    
    gradientLayer.colors = toValues
    gradientLayer.add(animation, forKey: animation.keyPath)
  }
  
}

// MARK: - CAAnimationDelegate
extension HorizontalGradientLoader: CAAnimationDelegate {
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    guard state == .start else {
      return
    }
    addAnimationToGradient()
  }
  
  enum State {
    case start
    case stop
  }
}

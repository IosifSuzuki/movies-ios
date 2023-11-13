//
//  DesignedButton.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import UIKit

final class DesignedButton: UIButton {
  
  var baseBackgroundColor: UIColor? {
    didSet {
      guard oldValue != baseBackgroundColor else {
        return
      }
      
      setupView()
    }
  }
  var foregroundColor: UIColor? {
    didSet {
      guard oldValue != foregroundColor else {
        return
      }
      
      setupView()
    }
  }
  var font: UIFont? {
    didSet {
      guard oldValue != font else {
        return
      }
      
      setupView()
    }
  }
  
  // MARK: - ThemeDependency
  
  private func setupView() {
    var configuration = UIButton.Configuration.filled()
    configuration.background.backgroundColor = baseBackgroundColor
    configuration.cornerStyle = .capsule
    configuration.titleTextAttributesTransformer = .init(buttonTextAtributesTransformer(incoming:))
    configuration.imagePadding = 4
    self.configuration = configuration
    
    setNeedsUpdateConfiguration()
  }
  
  private func buttonTextAtributesTransformer(incoming: AttributeContainer) -> AttributeContainer {
    var outgoing = incoming
    
    outgoing.foregroundColor = foregroundColor
    outgoing.font = font
    
    return outgoing
  }
  
}

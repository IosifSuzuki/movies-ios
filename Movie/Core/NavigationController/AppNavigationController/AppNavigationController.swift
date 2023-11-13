//
//  AppNavigationController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit

class AppNavigationController: UINavigationController, ThemeDependency {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    topViewController?.preferredStatusBarStyle ?? .default
  }
  
  var theme: Theme
  var style: Style
  
  init(theme: Theme, style: Style) {
    self.theme = theme
    self.style = style
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    apply(theme: theme)
  }
  
  func apply(theme: Theme) {
    setupApprearance()
  }
  
  func setupApprearance() {
    let barAppearance = UINavigationBarAppearance()
    
    let titleTextAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: theme.titleColor,
      .font: theme.font(style: .regular, size: 18) as Any
    ]
    barAppearance.titleTextAttributes = titleTextAttributes
    switch style {
    case .opaque:
      barAppearance.configureWithOpaqueBackground()
      barAppearance.backgroundColor = theme.backgroundColor
    case .transparent:
      barAppearance.configureWithTransparentBackground()
    }
    
    let buttonAppearance = UIBarButtonItemAppearance()
    buttonAppearance.normal.titleTextAttributes = titleTextAttributes
    barAppearance.buttonAppearance = buttonAppearance
    navigationBar.tintColor = theme.titleColor
    
    navigationBar.standardAppearance = barAppearance
    navigationBar.scrollEdgeAppearance = barAppearance
    navigationBar.compactAppearance = barAppearance
    navigationBar.compactScrollEdgeAppearance = barAppearance
  }
  
  enum Style {
    case opaque
    case transparent
  }
  
}

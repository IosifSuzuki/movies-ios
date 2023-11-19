//
//  UIApplication+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import UIKit

extension UIApplication {
  
  var activeScene: UIScene? {
    return UIApplication.shared.connectedScenes.first(where: { scene in
      scene.activationState == .foregroundActive
    })
  }
  
  var currentWindow: UIWindow? {
    (activeScene as? UIWindowScene)?.keyWindow
  }
  
}

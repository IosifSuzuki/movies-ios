//
//  ModernFont.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import UIKit.UIFont

class ModernFont: AppFont, Identify {
  
  func font(for style: FontStyle) throws -> UIFont {
    guard let font = AppFont(style: style).font else {
      throw ApplicationError(reason: "font must be register before use in app")
    }
    
    return font
  }
  
  enum AppFont: String {
    case interBold = "Inter-Bold.ttf"
    case interMedium = "Inter-Medium.ttf"
    case interRegular = "Inter-Regular.ttf"
    
    init(style: FontStyle) {
      switch style {
      case .regular:
        self = .interRegular
      case .medium:
        self = .interMedium
      case .bold:
        self = .interBold
      }
    }
    
    var font: UIFont? {
      Font(fileName: self.rawValue)?.font(with: 1)
    }
  }
  
}

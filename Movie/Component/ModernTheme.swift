//
//  ModernTheme.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit

struct ModernTheme: Theme, Identify {
  
  let appFont: AppFont
  
  var backgroundColor: UIColor {
    Asset.Colors.background.color
  }

  var titleColor: UIColor {
    Asset.Colors.title.color
  }
  
  var subtitleColor: UIColor {
    Asset.Colors.subtitle.color
  }
  
  var mainColor: UIColor {
    Asset.Colors.main.color
  }
  
  var accentColor: UIColor {
    Asset.Colors.accent.color
  }
  
  func font(style: FontStyle, size: CGFloat) -> UIFont {
    let font: UIFont
    do {
      font = try appFont.font(for: style).withSize(size)
    } catch {
      fatalError(error.localizedDescription)
    }
    return font
  }
  
}

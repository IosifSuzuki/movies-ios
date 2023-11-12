//
//  UIColor+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 03.11.2023.
//

import UIKit

extension UIColor {
  
  static func linearGradientColors(from startColor: UIColor, to endColor: UIColor, length: Int) -> [UIColor] {
    var startColorHue: CGFloat = .zero
    var startColorSaturation: CGFloat = .zero
    var startColorBrightness: CGFloat = .zero
    
    var endColorHue: CGFloat = .zero
    var endColorSaturation: CGFloat = .zero
    var endColorBrightness: CGFloat = .zero
    
    startColor.getHue(&startColorHue, 
                      saturation: &startColorSaturation,
                      brightness: &startColorBrightness,
                      alpha: nil)
    endColor.getHue(&endColorHue, 
                    saturation: &endColorSaturation,
                    brightness: &endColorBrightness,
                    alpha: nil)
    
    let stepHueComponent = (endColorHue - startColorHue) / CGFloat(length)
    let stepSaturationComponent = (endColorSaturation - startColorSaturation) / CGFloat(length)
    let stepBrightnessComponent = (endColorBrightness - startColorBrightness) / CGFloat(length)
    
    return (0..<length)
      .map { idx in
        UIColor(
          hue: startColorHue + stepHueComponent * CGFloat(idx),
          saturation: startColorSaturation + stepSaturationComponent * CGFloat(idx),
          brightness: startColorBrightness + stepBrightnessComponent * CGFloat(idx),
          alpha: 1
        )
      }
  }
  
  func inverseColor() -> UIColor {
    var red: CGFloat = .zero, green: CGFloat = .zero, blue: CGFloat = .zero, alpha: CGFloat = .zero
    
    self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
  }
  
  convenience init(hex: String, alpha: CGFloat = 1.0) {
      var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

      if hexValue.hasPrefix("#") {
          hexValue.remove(at: hexValue.startIndex)
      }

      var rgbValue: UInt64 = 0
      Scanner(string: hexValue).scanHexInt64(&rgbValue)

      let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
      let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
      let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

      self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
  
}

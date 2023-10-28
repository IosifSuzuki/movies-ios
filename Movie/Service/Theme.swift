//
//  Theme.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import UIKit.UIColor

protocol Theme {
  var backgroundColor: UIColor { get }
  var titleColor: UIColor { get }
  var subtitleColor: UIColor { get }
  var mainColor: UIColor { get }
  var accentColor: UIColor { get }
  
  func font(style: FontStyle, size: CGFloat) -> UIFont
}

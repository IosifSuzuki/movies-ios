//
//  AppFont.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import UIKit.UIFont

enum FontStyle {
  case regular
  case medium
  case bold
}

protocol AppFont {
  func font(for style: FontStyle) throws -> UIFont
}

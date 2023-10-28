//
//  Font.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import UIKit.UIFont

struct Font {
  private enum Extensions: String, CaseIterable {
    case otf
    case ttf
  }
  
  let name: String
  let `extension`: String
  
  init?(fileName: String) {
    if fileName.contains(Font.Extensions.otf.rawValue) ||
        fileName.contains(Font.Extensions.ttf.rawValue) {
      
      let components = fileName
        .split { $0 == "."}
        .map(String.init)
      
      if components.count == 2 {
        self.name = components[0]
        self.extension = components[1]
      } else {
        return nil
      }
    } else {
      return nil
    }
  }
  
  func font(with size: CGFloat) -> UIFont? {
    return UIFont(name: name, size: size)
  }
  
}

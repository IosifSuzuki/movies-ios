//
//  Array+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 03.11.2023.
//

import Foundation

extension Array {
  
  func rightShift() -> [Element] {
    var copy = self
    
    guard let last = copy.popLast() else {
      return []
    }
    
    return [last] + copy
  }
  
}

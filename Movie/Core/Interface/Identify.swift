//
//  Identify.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

protocol Identify {
  static var identifier: String { get }
}

extension Identify {
  
  static var identifier: String {
    return String(describing: Self.self)
  }
  
}

//
//  CustomerError.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct Alert {
  let title: String?
  let description: String?
  
  static func error(description: String) -> Self {
    return Self(title: L10n.error, description: description)
  }
  
}

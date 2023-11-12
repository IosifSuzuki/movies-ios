//
//  CustomerError.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct CustomerError: Error {
  let title: String
  let description: String
  
  init(title: String, description: String) {
    self.title = title
    self.description = description
  }
  
  init(description: String) {
    self.init(title: "Error", description: description)
  }
}

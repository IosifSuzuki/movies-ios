//
//  ApplicationError.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct ApplicationError: Error {
  let reason: String
  
  var localizedDescription: String {
    return reason
  }
  
}

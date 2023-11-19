//
//  ApplicationError.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct ApplicationError: Error, LocalizedError {
  let reason: String
  
  var errorDescription: String {
    return reason
  }
  
}

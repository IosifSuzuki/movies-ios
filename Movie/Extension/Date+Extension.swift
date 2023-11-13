//
//  Date+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

extension Date {
  
  func formatted(dateFormat: String) -> String {
    let dateFormatter = DateFormatter(dateFormat: dateFormat)
    
    return dateFormatter.string(from: self)
  }
  
}

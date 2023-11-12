//
//  DateFormatter+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

extension DateFormatter {
  
  convenience init(dateFormat: String) {
    self.init()
    self.dateFormat = dateFormat
  }
  
}

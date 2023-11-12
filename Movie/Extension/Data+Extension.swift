//
//  Data+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

extension Data {
  
  var prettyJSONString: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyJSONString = String(data: data, encoding: .utf8) else {
      return nil
    }
    
    return prettyJSONString
  }
  
}

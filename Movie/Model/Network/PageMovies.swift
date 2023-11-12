//
//  Page.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

struct Page<T: Decodable>: Decodable {
  let page: Int
  let totalPages: Int
  let result: [T]
  
  enum CodingKeys: String, CodingKey {
    case page
    case totalPages = "total_pages"
    case result = "results"
  }
}

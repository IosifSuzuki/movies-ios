//
//  MovieAPIConfiguration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation

struct MovieAPIConfiguration: Decodable {
  let images: ImageConfiguration
  
  enum CodingKeys: String, CodingKey {
    case images
  }
}

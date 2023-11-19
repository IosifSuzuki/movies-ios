//
//  ImageConfiguration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation

struct ImageConfiguration: Decodable {
  let baseURL: URL
  let posterSizes: [MovieImageSize]
  
  enum CodingKeys: String, CodingKey {
    case baseURL = "secure_base_url"
    case posterSizes = "poster_sizes"
  }
}

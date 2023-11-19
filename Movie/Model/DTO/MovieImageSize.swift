//
//  MovieImageSize.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation

enum MovieImageSize: String, Decodable, CaseIterable {
  case w45
  case w70
  case w92
  case w154
  case w185
  case w300
  case w342
  case w500
  case w780
  case w1280
  case h632
  case original
  
  var maxFitWidth: CGFloat? {
    switch self {
    case .w45:
      45
    case .w70:
      70
    case .w92:
      92
    case .w154:
      154
    case .w185:
      185
    case .w300:
      300
    case .w342:
      342
    case .w500:
      500
    case .w780:
      780
    case .w1280:
      1280
    case .h632:
      nil
    case .original:
      .infinity
    }
  }
}

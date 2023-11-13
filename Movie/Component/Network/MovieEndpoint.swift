//
//  MovieEndpoint.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation
import Alamofire

enum MovieEndpoint: EndpointConfigurable {
  
  case discover(page: Int, sortBy: MovieSortBy)
  case genres
  case movie(id: Int)
  
  var method: HTTPMethod {
    switch self {
    case .discover:
      return .get
    case .genres:
      return .get
    case .movie:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .discover:
      return "discover/movie"
    case .genres:
      return "genre/movie/list"
    case let .movie(id):
      return "movie/\(id)"
    }
  }
  
  var queryParams: [URLQueryItem] {
    switch self {
    case let .discover(page: page, sortBy: sortBy):
      return [
        URLQueryItem(name: "page", value: "\(page)"),
        URLQueryItem(name: "sort_by", value: "\(sortBy.rawValue)"),
      ]
    case .genres:
      return []
    case .movie:
      return []
    }
  }
  
  var header: [String: String] {
    return [:]
  }
  
  var body: Encodable? {
    switch self {
    case .discover:
      return nil
    case .genres:
      return nil
    case .movie:
      return nil
    }
  }
  
}

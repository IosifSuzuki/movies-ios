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
  case config
  
  var method: HTTPMethod {
    switch self {
    case .discover:
      return .get
    case .genres:
      return .get
    case .movie:
      return .get
    case .config:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .discover:
      "discover/movie"
    case .genres:
      "genre/movie/list"
    case let .movie(id):
      "movie/\(id)"
    case .config:
      "configuration"
    }
  }
  
  var queryParams: [URLQueryItem] {
    switch self {
    case let .discover(page: page, sortBy: sortBy):
      [
        URLQueryItem(name: "page", value: "\(page)"),
        URLQueryItem(name: "sort_by", value: "\(sortBy.rawValue)")
      ]
    case .genres:
      []
    case .movie:
      []
    case .config:
      []
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
    case .config:
      return nil
    }
  }
  
}

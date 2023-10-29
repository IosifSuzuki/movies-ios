//
//  MovieEndpoint.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation
import Alamofire

enum MovieEndpoint: EndpointConfigurable {
  
  case discover
  
  var method: HTTPMethod {
    switch self {
    case .discover:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .discover:
      return "discover/movie"
    }
  }
  
  var queryParams: [URLQueryItem] {
    switch self {
    case .discover:
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
    }
  }
  
}

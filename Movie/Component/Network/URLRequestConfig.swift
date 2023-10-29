//
//  ConfigEndpoint.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation
import Alamofire

class EndpointRequest: URLRequestConvertible {
  
  let configuration: Configuration
  let endpoint: EndpointConfigurable
  
  var jsonEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    encoder.outputFormatting = .prettyPrinted
    
    return encoder
  }()
  
  private var predefinedHeader: [String: String] {
    [
      "Authorization": "Bearer \(configuration.token)"
    ]
  }
  
  init(configuration: Configuration, endpoint: EndpointConfigurable) {
    self.configuration = configuration
    self.endpoint = endpoint
  }
  
  func asURLRequest() throws -> URLRequest {
    var endpointURL = configuration.baseURL
    endpointURL.append(path: endpoint.path)
    endpointURL.append(queryItems: endpoint.queryParams)
    
    var request = URLRequest(url: endpointURL, cachePolicy: .reloadIgnoringLocalCacheData)
    let mergedHeader = endpoint.header.merging(predefinedHeader) { $1 }
    mergedHeader.map { (key: String, value: String) in
      HTTPHeader(name: key, value: value)
    }.forEach { header in
      request.headers.add(header)
    }
    
    if let body = endpoint.body {
      let bodyData = try jsonEncoder.encode(body)
      request.httpBody = bodyData
    }
    
    return request
  }
  
}

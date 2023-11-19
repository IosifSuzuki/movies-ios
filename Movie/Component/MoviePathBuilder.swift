//
//  URLPathBuilder.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation

final class MoviePathBuilder {
  
  private let url: URL
  private var sourceID: String?
  private var size: MovieImageSize?
  
  required init(url: URL) {
    self.url = url
  }
  
  func set(sourceID: String) -> MoviePathBuilder {
    var sourceID = sourceID
    sourceID.trimPrefix("/")
    self.sourceID = sourceID
    
    return self
  }
  
  func set(size: MovieImageSize) -> MoviePathBuilder {
    self.size = size
    
    return self
  }
  
  func buildURL() -> URL? {
    guard let sourceID, let size else {
      return nil
    }
    
    return url
      .appending(path: size.rawValue)
      .appending(path: sourceID)
  }
  
  @discardableResult
  func reset() -> Self {
    self.size = nil
    self.sourceID = nil
    
    return self
  }
  
}

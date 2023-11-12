//
//  AppConfiguration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

struct AppConfiguration: Configuration {
  
  // MARK: - Configuration
  
  var baseURL: URL {
    let url: URL
    do {
      let urlText: String = try Self.value(for: .baseURL)
      guard let unwrapURL = URL(string: urlText) else {
        throw ApplicationError(reason: "baseURL contains not url value")
      }
      url = unwrapURL
    } catch {
      fatalError(error.localizedDescription)
    }
    return url
  }
  
  var token: String {
    let token: String
    do {
      token = try Self.value(for: .token)
    } catch {
      fatalError(error.localizedDescription)
    }
    return token
  }
  
  static func value<T>(for key: KeyPath) throws -> T where T: LosslessStringConvertible {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key.rawValue) else {
      throw ApplicationError(reason: "missing configuration key")
    }
    
    switch object {
    case let value as T:
      return value
    case let string as String:
      guard let value = T(string) else { fallthrough }
      return value
    default:
      throw ApplicationError(reason: "unknwon value by configuration keypath: \(key.rawValue)")
    }
  }
  
  enum KeyPath: String {
    case baseURL = "BASE_API_URL"
    case token = "TOKEN"
  }
}

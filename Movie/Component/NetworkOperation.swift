//
//  NetworkOperation.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation
import Alamofire
import Swinject

final class NetworkOperation: Identify {
  
  let configuration: Configuration
  let session: Session
  let dispatchQueue: DispatchQueue
  
  var jsonDecoder: JSONDecoder {
    let jsonDecoder = JSONDecoder()
    
    return jsonDecoder
  }
  
  init(configuration: Configuration, eventMonitor: LoggerEventMonitor) {
    self.configuration = configuration
    self.dispatchQueue = DispatchQueue.global(qos: .background)
    self.session = Session(eventMonitors: [eventMonitor])
  }
  
}

// MARK: - Private
private extension NetworkOperation {
  
  func endpointRequest(endpoitConfigurable: EndpointConfigurable) -> EndpointRequest {
    guard let endpointRequest = Assembler.shared.resolver.resolve(EndpointRequest.self, argument: endpoitConfigurable) else {
      fatalError("EndpointRequest must be register in dependency injection container")
    }
    return endpointRequest
  }
  
  private func performRequest<T: Decodable>(endpoint: URLRequestConvertible, jsonDecoder: JSONDecoder) async throws -> T {
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      guard let self else {
        continuation.resume(throwing: ApplicationError(reason: "nil value"))
        return
      }
      session.request(endpoint)
        .validate(statusCode: 200..<300)
        .response { response in
          guard let bodyData = response.data else {
            continuation.resume(throwing: ApplicationError(reason: "empty body"))
            return
          }
          let result: T
          do {
            result = try jsonDecoder.decode(T.self, from: bodyData)
          } catch {
            print("json decoded occured error: \(error)")
            continuation.resume(throwing: error)
            return
          }
          continuation.resume(returning: result)
        }
        .resume()
    }
  }
  
}

// MARK: - APIMovie
extension NetworkOperation: APIMovie {
  
  func discoverMovie() async throws -> Page<MovieItem> {
    let endpointRequest = endpointRequest(endpoitConfigurable: MovieEndpoint.discover)
    let jsonDecoder = self.jsonDecoder
    let dateFormatter = DateFormatter(dateFormat: "YYYY-MM-DD")
    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    
    return try await performRequest(endpoint: endpointRequest, jsonDecoder: jsonDecoder)
  }
  
}

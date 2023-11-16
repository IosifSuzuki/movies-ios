//
//  NetworkReachability.swift
//  Movie
//
//  Created by Bogdan Petkanych on 16.11.2023.
//

import Foundation
import RxSwift
import Alamofire

enum ReachabilityStatus {
  case unknown
  case notReachable
  case wifi
  case cellular
  
  init(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
    switch status {
    case .unknown:
      self = .unknown
    case .notReachable:
      self = .notReachable
    case .reachable(let connectionType):
      switch connectionType {
      case .ethernetOrWiFi:
        self = .wifi
      case .cellular:
        self = .cellular
      }
    }
  }
    
  var hasConnectionToNetwork: Bool {
    switch self {
    case .cellular, .wifi:
      return true
    default:
      return false
    }
  }
  
}
protocol NetworkReachability {
  var reachabilityStatus: Observable<ReachabilityStatus> { get }
  var isReachability: Bool { get }
}

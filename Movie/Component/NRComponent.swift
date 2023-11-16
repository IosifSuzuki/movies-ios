//
//  NRComponent.swift
//  Movie
//
//  Created by Bogdan Petkanych on 16.11.2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

final class NRComponent: NSObject, NetworkReachability {
  
  private let networkReachabilityManager: NetworkReachabilityManager
  private let logger: Logger
  private var status = PublishSubject<NetworkReachabilityManager.NetworkReachabilityStatus>()
  
  // MARK: - NetworkReachability
  
  var reachabilityStatus: Observable<ReachabilityStatus> {
    status
      .map { status in
        ReachabilityStatus(status: status)
      }
      .asObservable()
  }
  
  var isReachability: Bool {
    ReachabilityStatus(status: networkReachabilityManager.status).hasConnectionToNetwork
  }
  
  // MARK: - Init
  
  init?(logger: Logger) {
    guard let networkReachabilityManager = NetworkReachabilityManager() else {
      logger.error(message: "NetworkReachabilityManager has failed initialization")
      return nil
    }
    
    self.networkReachabilityManager = networkReachabilityManager
    self.logger = logger
    
    super.init()
    
    guard networkReachabilityManager.startListening(onUpdatePerforming: networkReachabilityStatusDidUpdated) else {
      logger.error(message: "add new listener to NetworkReachabilityManager has failed")
      return nil
    }
  }
  
  // MARK: - Private
  
  private func networkReachabilityStatusDidUpdated(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
    self.status.onNext(status)
  }
  
}

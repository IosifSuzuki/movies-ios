//
//  BaseViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
  let loadingIndicator = PublishSubject<Bool>()
  let alert = PublishSubject<Alert>()
  
  let networkReachability: NetworkReachability
  
  var disposeBag = DisposeBag()
  
  var alertDriver: Driver<Alert> {
    alert.asDriver(onErrorDriveWith: Driver<Alert>.empty())
  }
  
  var loadingIndicatorDriver: Driver<Bool> {
    loadingIndicator.asDriver(onErrorDriveWith: Driver<Bool>.empty())
  }
  
  init(networkReachability: NetworkReachability) {
    self.networkReachability = networkReachability
    
    setupObservers()
  }
  
  private func setupObservers() {
    networkReachability
      .reachabilityStatus
      .subscribe(onNext: { [weak self] status in
        guard let self, !status.hasConnectionToNetwork else {
          return
        }
        let alertModel = Alert(title: nil, description: L10n.Offline.message)
        self.alert.onNext(alertModel)
      }).disposed(by: disposeBag)
  }
  
}

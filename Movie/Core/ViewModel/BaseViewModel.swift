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
  let error = PublishSubject<CustomerError>()
  var disposeBag = DisposeBag()
  
  var errorDriver: Driver<CustomerError> {
    error.asDriver(onErrorDriveWith: Driver<CustomerError>.empty())
  }
  
  var loadingIndicatorDriver: Driver<Bool> {
    loadingIndicator.asDriver(onErrorDriveWith: Driver<Bool>.empty())
  }
  
}

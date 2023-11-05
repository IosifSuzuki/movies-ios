//
//  MoviesViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class MoviesViewModel: BaseViewModel, ViewModel {
  
  override var loadingIndicatorDriver: Driver<Bool> {
    Observable
      .combineLatest(availableGenres.isRefreshedList, loadingIndicator)
      .map { (isRefreshedList, loadingIndicator) in
        !isRefreshedList || loadingIndicator
      }
      .asDriver(onErrorDriveWith: Driver<Bool>.empty())
  }
  
  var title: String? {
    L10n.MoviesViewController.title
  }
  private var refreshView = PublishSubject<Void>()
  
  var dataSource: [MovieItemViewModel] = []
  
  private let apiMoview: APIMovie
  private let availableGenres: AvailableGenres
  private let logger: Logger
  
  init(apiMovie: APIMovie, availableGenres: AvailableGenres, logger: Logger) {
    self.availableGenres = availableGenres
    self.apiMoview = apiMovie
    self.logger = logger
    
    super.init()
  }
  
  @discardableResult
  func transform(input: Input) -> Output {
    return Output(
      refreshViewTrigger: refreshView.asDriver(onErrorDriveWith: Driver<()>.empty())
    )
  }
  
  // MARK: - Internal
  
  func fetchData() {
    Task {
      self.loadingIndicator.onNext(true)
      do {
        let page = try await self.apiMoview.discoverMovie()
        self.dataSource = page.result.compactMap { movieItem in
          MovieItemViewModel(movieItem: movieItem, availableGenres: self.availableGenres)
        }
        self.refreshView.onNext(())
      } catch {
        self.logger.error(message: error)
        self.error.onNext(CustomerError(description: error.localizedDescription))
      }
      self.loadingIndicator.onNext(false)
    }
  }
  
  struct Input {
  }
  
  struct Output {
    let refreshViewTrigger: Driver<Void>
  }
  
}

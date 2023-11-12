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
  
  private let moviesPagination: MoviesPagination
  private let availableGenres: AvailableGenres
  private let logger: Logger
  
  init(moviesPagination: MoviesPagination, availableGenres: AvailableGenres, logger: Logger) {
    self.availableGenres = availableGenres
    self.moviesPagination = moviesPagination
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
  
  func refreshData() {
    self.moviesPagination.reset()
    observeFetchMovies()
  }
  
  func fetchMore() {
    observeFetchMovies()
  }
  
  func displayCell(by indexPath: IndexPath) {
    if indexPath.row + 5 > dataSource.count {
      fetchMore()
    }
  }
  
  struct Input {
  }
  
  struct Output {
    let refreshViewTrigger: Driver<Void>
  }
}

extension MoviesViewModel {
  
  private func fetchMovies() async throws -> [MovieItemViewModel] {
    guard moviesPagination.canLoadMore else {
      return []
    }
    let movieItems = try await moviesPagination.loadMore()
    let newDSItems = movieItems.compactMap { movieItem in
      MovieItemViewModel(movieItem: movieItem, availableGenres: self.availableGenres)
    }
    return newDSItems
  }
  
  func observeFetchMovies() {
    Task {
      loadingIndicator.onNext(true)
      do {
        let newDSItems = try await fetchMovies()
        dataSource.append(contentsOf: newDSItems)
      } catch {
        self.logger.error(message: error)
        self.error.onNext(CustomerError(description: error.localizedDescription))
      }
      refreshView.onNext(())
      loadingIndicator.onNext(false)
    }
  }
  
}

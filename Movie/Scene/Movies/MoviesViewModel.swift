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
  
  private var refreshView = PublishSubject<Void>()
  private var movieDetailID = PublishSubject<Int>()
  private var movieSortByItems = PublishSubject<[MovieSortByItem]>()
  
  private let moviesDS: MoviesDataSource
  private let logger: Logger
  
  var dataSource: DataSource {
    moviesDS
  }
  
  var emptyStateViewModel: EmptyStateViewModel = {
    EmptyStateViewModel(
      title: L10n.noData,
      subtitle: L10n.MoviesViewController.EmptyState.subtitle
    )
  }()
  
  init(moviesDS: MoviesDataSource, logger: Logger, networkReachability: NetworkReachability) {
    self.moviesDS = moviesDS
    self.logger = logger
    
    super.init(networkReachability: networkReachability)
  }
  
  @discardableResult
  func transform(input: Input) -> Output {
    input
      .sortByTrigger
      .drive(onNext: { [weak self] in
        guard let self else {
          return
        }
        
        self.movieSortByItems.onNext(self.moviesDS.movieSortOptions.dataSource)
      })
      .disposed(by: disposeBag)
    
    input
      .searchTrigger
      .drive(onNext: { [weak self] text in
        guard let self else {
          return
        }
        
        self.moviesDS.search(by: text)
        self.refreshView.onNext(())
      })
      .disposed(by: disposeBag)
    
    return Output(
      refreshViewTrigger: refreshView.asDriver(onErrorDriveWith: Driver<()>.empty()), 
      sortByTrigger: movieSortByItems.asDriver(onErrorDriveWith: Driver<[MovieSortByItem]>.empty()), 
      movieDetailTrigger: movieDetailID.asDriver(onErrorDriveWith: Driver<Int>.empty())
    )
  }
  
  // MARK: - ViewModel
  
  var title: String? {
    L10n.MoviesViewController.title
  }
  
  // MARK: - BaseViewModel
  
  override var loadingIndicatorDriver: Driver<Bool> {
    Observable
      .combineLatest(moviesDS.availableGenres.isRefreshedList, loadingIndicator, moviesDS.movieConfiguration.isReady)
      .map { (isRefreshedList, loadingIndicator, movieConfigurationIsReady) in
        !isRefreshedList || loadingIndicator || !movieConfigurationIsReady
      }
      .asDriver(onErrorDriveWith: Driver<Bool>.empty())
  }
  
  // MARK: - Internal
  
  func select(movieSortByItem: MovieSortByItem) {
    guard networkReachability.isReachability else {
      self.showOfflineMassage()
      return
    }
    
    moviesDS.movieSortOptions.selectedOption = movieSortByItem.sortBy
    
    refreshData()
  }
  
  func select(movieItem: MovieItemViewModel) {
    guard networkReachability.isReachability else {
      self.showOfflineMassage()
      return
    }
    
    movieDetailID.onNext(movieItem.id)
  }
  
  func shouldBeginEditingSearchBar() -> Bool {
    guard networkReachability.isReachability else {
      self.showOfflineMassage()
      return false
    }
    
    return true
  }
  
  func cancelSearch() {
    self.moviesDS.search(by: "")
    self.refreshView.onNext(())
  }
  
  func refreshData() {
    guard networkReachability.isReachability else {
      refreshView.onNext(())
      return
    }
    
    moviesDS.reset()
    
    observeFetchMovies()
  }
  
  func fetchMore() {
    guard networkReachability.isReachability else {
      refreshView.onNext(())
      return
    }
    
    observeFetchMovies()
  }
  
  func scroll(to indexPath: IndexPath) {
    if indexPath.row + 5 > moviesDS.numberOfRows(in: 0), moviesDS.canLoadMore {
      fetchMore()
    }
  }
  
  // MARK: - Internal models
  
  struct Input {
    let sortByTrigger: Driver<Void>
    let searchTrigger: Driver<String?>
  }
  
  struct Output {
    let refreshViewTrigger: Driver<Void>
    let sortByTrigger: Driver<[MovieSortByItem]>
    let movieDetailTrigger: Driver<Int>
  }
}

// MARK: - Private
private extension MoviesViewModel {
  
  func observeFetchMovies() {
    Task {
      loadingIndicator.onNext(true)
      do {
        try await moviesDS.loadMore()
      } catch {
        self.logger.error(message: error)
        self.alert.onNext(Alert.error(description: error.localizedDescription))
      }
      refreshView.onNext(())
      loadingIndicator.onNext(false)
    }
  }
  
  func showOfflineMassage() {
    let alertModel = Alert(title: nil, description: L10n.Offline.message)
    self.alert.onNext(alertModel)
  }
  
}

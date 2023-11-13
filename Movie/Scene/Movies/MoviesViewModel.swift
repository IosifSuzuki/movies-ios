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
  
  private var moviesDS: MoviesDataSource
  private let logger: Logger
  
  var dataSource: DataSource {
    moviesDS
  }
  
  init(moviesDS: MoviesDataSource, logger: Logger) {
    self.moviesDS = moviesDS
    self.logger = logger
    
    super.init()
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
      .combineLatest(moviesDS.availableGenres.isRefreshedList, loadingIndicator)
      .map { (isRefreshedList, loadingIndicator) in
        !isRefreshedList || loadingIndicator
      }
      .asDriver(onErrorDriveWith: Driver<Bool>.empty())
  }
  
  // MARK: - Internal
  
  func select(movieSortByItem: MovieSortByItem) {
    moviesDS.movieSortOptions.selectedOption = movieSortByItem.sortBy
    
    refreshData()
  }
  
  func select(movieItem: MovieItemViewModel) {
    movieDetailID.onNext(movieItem.id)
  }
  
  func refreshData() {
    moviesDS.reset()
    
    observeFetchMovies()
  }
  
  func fetchMore() {
    observeFetchMovies()
  }
  
  func scroll(to indexPath: IndexPath) {
    if indexPath.row + 5 > moviesDS.numberOfRows(in: 0), moviesDS.canLoadMore {
      fetchMore()
    }
  }
  
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

extension MoviesViewModel {
  
  func observeFetchMovies() {
    Task {
      loadingIndicator.onNext(true)
      do {
        try await moviesDS.loadMore()
      } catch {
        self.logger.error(message: error)
        self.error.onNext(CustomerError(description: error.localizedDescription))
      }
      refreshView.onNext(())
      loadingIndicator.onNext(false)
    }
  }
  
}

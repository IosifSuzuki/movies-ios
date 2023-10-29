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
  
  var title: String? {
    L10n.MoviesViewController.title
  }
  private var refreshView = PublishSubject<Void>()
  
  var dataSource: [MovieItemViewModel] = []
  
  private let apiMoview: APIMovie
  
  init(apiMovie: APIMovie) {
    self.apiMoview = apiMovie
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
      do {
        let page = try await self.apiMoview.discoverMovie()
        self.dataSource = page.result.compactMap { movieItem in
          MovieItemViewModel(movieItem: movieItem)
        }
        self.refreshView.onNext(())
      } catch {
        self.error.onNext(CustomerError(description: error.localizedDescription))
      }
    }
  }
  
  struct Input {
  }
  
  struct Output {
    let refreshViewTrigger: Driver<Void>
  }
  
}

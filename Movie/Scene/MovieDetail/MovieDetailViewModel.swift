//
//  MovieDetailViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation
import UIKit.UITableView
import RxSwift
import RxCocoa

class MovieDetailViewModel: BaseViewModel, ViewModel {
  
  private let apiMovie: APIMovie
  private let movieExternalSource: MovieExternalSource
  private let movieID: Int
  private let refreshViewSubject = PublishSubject<Void>()
  private let topTitle = PublishSubject<String?>()
  
  let logger: Logger
  var dataSource: [Cells] = []
  
  init(movieID: Int, 
       apiMovie: APIMovie,
       logger: Logger,
       networkReachability: NetworkReachability,
       movieExternalSource: MovieExternalSource) {
    self.movieID = movieID
    self.apiMovie = apiMovie
    self.logger = logger
    self.movieExternalSource = movieExternalSource
    
    super.init(networkReachability: networkReachability)
  }
  
  // MARK: - ViewModel
  
  var title: String? {
    return nil
  }
  
  func transform(input: Input) -> Output {
    return Output(
      refreshViewTrigger: refreshViewSubject.asDriver(onErrorDriveWith: Driver<()>.empty()), 
      titleTrigger: topTitle.asDriver(onErrorDriveWith: Driver<String?>.empty())
    )
  }
  
  // MARK: - Internal
  
  func fetchData() {
    Task {
      loadingIndicator.onNext(true)
      do {
        let movieDetail = try await apiMovie.movie(by: movieID)
        self.prepareDataSource(movieDetail: movieDetail)
        
      } catch {
        logger.error(message: "fetch movie by id", err: error)
        self.alert.onNext(Alert.error(description: error.localizedDescription))
      }
      loadingIndicator.onNext(false)
      refreshViewSubject.onNext(())
    }
  }
  
  struct Input {
    
  }
  
  struct Output {
    let refreshViewTrigger: Driver<Void>
    let titleTrigger: Driver<String?>
  }
  
  enum Cells {
    case poster(viewModel: PosterViewModel)
    case movieInfo(viewModel: MovieInfoViewModel)
    case rating(viewModel: MovieRatingViewModel)
    case about(viewModel: AboutMovieViewModel)
    
    var height: CGFloat {
      switch self {
      case .poster:
        return 300
      case .rating:
        return 70
      case .movieInfo, .about:
        return UITableView.automaticDimension
      }
    }
  }
  
}

// MARK: - Private
private extension MovieDetailViewModel {
  
  func prepareDataSource(movieDetail: MovieDetail) {
    dataSource = []
    
    topTitle.onNext(movieDetail.originalTitle)
    
    if let posterViewModel = PosterViewModel(movieDetail: movieDetail, movieExternalSource: movieExternalSource, logger: logger) {
      dataSource.append(.poster(viewModel: posterViewModel))
    }
    
    let movieViewModel = MovieInfoViewModel(movieDetail: movieDetail)
    dataSource.append(.movieInfo(viewModel: movieViewModel))
    
    let movieRaitingViewModel = MovieRatingViewModel(movieDetail: movieDetail)
    dataSource.append(.rating(viewModel: movieRaitingViewModel))
    
    let aboutMovieViewModel = AboutMovieViewModel(movieDetail: movieDetail)
    dataSource.append(.about(viewModel: aboutMovieViewModel))
  }
}

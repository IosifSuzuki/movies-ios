//
//  MovieConfigManager.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation
import RxSwift

final class MovieConfigManager: APIMovieConfiguration {
  
  private let apiMovie: APIMovie
  private let logger: Logger
  private var movieConfig: MovieAPIConfiguration?
  
  private let isReadySubject = BehaviorSubject<Bool>(value: false)
  
  var isReady: Observable<Bool> {
    isReadySubject.asObservable()
  }
  
  init(logger: Logger, apiMovie: APIMovie) {
    self.logger = logger
    self.apiMovie = apiMovie
  }
  
  // MARK: - APIMovieConfiguration
  
  func fetchConfig() {
    Task {
      do {
        self.isReadySubject.onNext(false)
        let movieConfig = try await self.apiMovie.config()
        self.movieConfig = movieConfig
        self.isReadySubject.onNext(true)
        
        self.logger.debug(message: "movie configuration successfully loaded")
      } catch {
        self.logger.error(message: "failed to load movie configuration", err: error)
      }
    }
  }
  
  func posterMovieImageSizeToFit(_ width: CGFloat) throws -> MovieImageSize {
    guard let movieConfig else {
      throw ApplicationError(reason: "poster size doen't provide the size")
    }
    
    let scale = UIApplication.shared.currentWindow?.screen.scale ?? 1
    var targerMovieImageSize: MovieImageSize = .original
    let width = width * scale
    var differenceWithRealSize: CGFloat = width
    movieConfig.images.posterSizes.forEach { movieImageSize in
      let currentDifferenceWithRealSize = abs((movieImageSize.maxFitWidth ?? .zero) - width)
      if currentDifferenceWithRealSize < differenceWithRealSize {
        differenceWithRealSize = currentDifferenceWithRealSize
        targerMovieImageSize = movieImageSize
      }
    }
    
    return targerMovieImageSize
  }
  
  func posterURL(sourcePath: String, size: MovieImageSize) throws -> URL {
    guard let movieConfig, movieConfig.images.posterSizes.contains(size) == true else {
      throw ApplicationError(reason: "poster size doen't provide the size")
    }
    
    guard let externalURL = MoviePathBuilder(url: movieConfig.images.baseURL)
      .set(sourceID: sourcePath)
      .set(size: size)
      .buildURL() else {
      throw ApplicationError(reason: "build poster url has failed")
    }
    
    return externalURL
  }
  
}

//
//  PosterViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

struct PosterViewModel {
  private let posterPath: String
  private let movieExternalSource: MovieExternalSource
  let logger: Logger
  
  init?(movieDetail: MovieDetail, movieExternalSource: MovieExternalSource, logger: Logger) {
    guard let posterPath = movieDetail.posterPath else {
      return nil
    }
    
    self.posterPath = posterPath
    self.movieExternalSource = movieExternalSource
    self.logger = logger
  }
  
  func posterURL(by width: CGFloat) -> URL? {
    let externalURL: URL?
    do {
      let movieImageSize = try movieExternalSource.posterMovieImageSizeToFit(width)
      externalURL = try movieExternalSource.posterURL(sourcePath: posterPath, size: movieImageSize)
    } catch {
      externalURL = nil
      logger.error(message: "prepare poster url has failed", err: error)
    }
    
    return externalURL
  }
}

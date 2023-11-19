//
//  MovieItemViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct MovieItemViewModel {
  let id: Int
  let title: String
  let genreIDs: [Int]
  let avarageRating: Double
  let releaseDate: Date?
  
  private let posterPath: String
  private let availableGenres: AvailableGenres
  private let logger: Logger
  private let movieExternalSource: MovieExternalSource
  
  init?(movieItem: MovieItem, availableGenres: AvailableGenres, movieExternalSource: MovieExternalSource, logger: Logger) {
    guard let posterPath = movieItem.posterPath else {
      logger.warning(message: "posterPath has nil value")
      return nil
    }
    
    self.logger = logger
    self.movieExternalSource = movieExternalSource
    self.id = movieItem.id
    self.availableGenres = availableGenres
    self.posterPath = posterPath
    self.title = movieItem.title
    self.genreIDs = movieItem.genreIDs
    self.avarageRating = movieItem.voteAverage
    self.releaseDate = movieItem.realeaseDate
  }
  
  var yearText: String? {
    guard let releaseDate else {
      return nil
    }
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "YYYY"
    return dateFormat.string(from: releaseDate)
  }
  
  var genresText: String {
    genreIDs.compactMap { id in
      availableGenres[id]
    }.joined(separator: ", ")
  }
  
  var avarageRatingText: String {
    "\(avarageRating)"
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

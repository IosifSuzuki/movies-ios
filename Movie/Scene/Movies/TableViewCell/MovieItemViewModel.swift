//
//  MovieItemViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

struct MovieItemViewModel {
  let posterURL: URL
  let title: String
  let genreIDs: [Int]
  let avarageRating: Double
  let releaseDate: Date?
  private let availableGenres: AvailableGenres
  
  init?(movieItem: MovieItem, availableGenres: AvailableGenres) {
    guard let posterPath = movieItem.posterPath,
          let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
      return nil
    }
    self.availableGenres = availableGenres
    self.posterURL = url
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
}

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
  let genre: [String]
  let avarageRating: Double
  let releaseDate: Date
  
  init?(movieItem: MovieItem) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieItem.posterPath)") else {
      return nil
    }
    self.posterURL = url
    self.title = movieItem.title
    self.genre = ["test"]
    self.avarageRating = movieItem.voteAverage
    self.releaseDate = movieItem.realeaseDate
  }
  
  var yearText: String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "YYYY"
    return dateFormat.string(from: releaseDate)
  }
  
  var genresText: String {
    genre.joined(separator: ",")
  }
  
  var avarageRatingText: String {
    "\(avarageRating)"
  }
}

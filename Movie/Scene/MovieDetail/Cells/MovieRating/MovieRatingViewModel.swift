//
//  MovieRatingViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

class MovieRatingViewModel {
  
  let rating: String?
  let watchTheTrailer: String?
  
  init(movieDetail: MovieDetail) {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 1
    numberFormatter.minimumFractionDigits = 1
    numberFormatter.decimalSeparator = "."
    
    rating = numberFormatter.string(from: movieDetail.voteAverage as NSNumber)
    watchTheTrailer = L10n.MoviesViewController.WatchTheTrailer.text
  }
  
}

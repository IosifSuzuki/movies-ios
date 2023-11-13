//
//  PosterViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

struct PosterViewModel {
  let posterURL: URL
  
  init?(movieDetail: MovieDetail) {
    guard let posterPath = movieDetail.posterPath,
          let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
      return nil
    }
    posterURL = url
  }
}

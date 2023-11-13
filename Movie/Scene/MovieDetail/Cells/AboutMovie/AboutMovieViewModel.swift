//
//  AboutMovieViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

class AboutMovieViewModel {
  let description: String
  
  init(movieDetail: MovieDetail) {
    self.description = movieDetail.overview
  }
  
}

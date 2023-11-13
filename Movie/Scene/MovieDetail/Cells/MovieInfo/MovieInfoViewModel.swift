//
//  MovieInfoViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

struct MovieInfoViewModel {
  
  let title: String
  let subtitle: String
  let genres: String
  
  init(movieDetail: MovieDetail) {
    title = movieDetail.title
    let productionCountries = movieDetail.productionCountries.map { $0.name }.joined(separator: ",")
    var subtitle = productionCountries
    if let realeaseDate = movieDetail.realeaseDate {
      let productionDateText =  realeaseDate.formatted(dateFormat: "YYYY")
      subtitle.append(", \(productionDateText)")
    }
    self.subtitle = subtitle
    genres = movieDetail.genres.map { $0.name }.joined(separator: ", ")
  }
  
}

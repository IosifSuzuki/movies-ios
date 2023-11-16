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
    var subtitleComponents: [String] = []
    if !productionCountries.isEmpty {
      subtitleComponents.append(productionCountries)
    }
    if let realeaseDate = movieDetail.realeaseDate {
      let productionDateText =  realeaseDate.formatted(dateFormat: "YYYY")
      subtitleComponents.append(productionDateText)
    }
    self.subtitle = subtitleComponents.joined(separator: ", ")
    
    genres = movieDetail.genres.map { $0.name }.joined(separator: ", ")
  }
  
}

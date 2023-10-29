//
//  MovieItem.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

struct MovieItem: Decodable {
  let id: Int
  let title: String
  let overview: String
  let posterPath: String
  let realeaseDate: Date
  let genreIDs: [Int]
  let voteAverage: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case posterPath = "poster_path"
    case realeaseDate = "release_date"
    case genreIDs = "genre_ids"
    case voteAverage = "vote_average"
  }
}

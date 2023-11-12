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
  let posterPath: String?
  let realeaseDate: Date?
  let genreIDs: [Int]
  let voteAverage: Double
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    self.realeaseDate = try? container.decodeIfPresent(Date.self, forKey: .realeaseDate)
    self.genreIDs = try container.decode([Int].self, forKey: .genreIDs)
    self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
  }
  
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

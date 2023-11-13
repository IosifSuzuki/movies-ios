//
//  MovieDetail.swift
//  Movie
//
//  Created by Bogdan Petkanych on 13.11.2023.
//

import Foundation

struct MovieDetail: Decodable {
  let id: Int
  let adult: Bool
  let budget: Int
  let genres: [Genre]
  let title: String
  let originalTitle: String
  let overview: String
  let video: Bool
  let posterPath: String?
  let realeaseDate: Date?
  let voteAverage: Double
  let productionCountries: [ProductionCountry]
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.adult = try container.decode(Bool.self, forKey: .adult)
    self.budget = try container.decode(Int.self, forKey: .budget)
    self.genres = try container.decode([Genre].self, forKey: .genres)
    self.title = try container.decode(String.self, forKey: .title)
    self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.video = try container.decode(Bool.self, forKey: .video)
    self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    self.realeaseDate = try? container.decodeIfPresent(Date.self, forKey: .realeaseDate)
    self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    self.productionCountries = try container.decode([ProductionCountry].self, forKey: .productionCountries)
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case adult
    case budget
    case genres
    case title
    case originalTitle = "original_title"
    case overview
    case video
    case posterPath = "poster_path"
    case realeaseDate = "release_date"
    case voteAverage = "vote_average"
    case productionCountries = "production_countries"
  }
  
}

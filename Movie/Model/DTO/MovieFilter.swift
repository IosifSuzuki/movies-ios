//
//  MovieFilter.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

enum MovieSortBy: String, Encodable, CaseIterable {
  
  case revenueDesc = "revenue.desc"
  case popularityDesc = "popularity.desc"
  case voteAverageDesc = "vote_average.desc"
  
  var title: String {
    switch self {
    case .revenueDesc:
      L10n.MovieSortBy.RevenueDesc.text
    case .popularityDesc:
      L10n.MovieSortBy.PopularityDesc.text
    case .voteAverageDesc:
      L10n.MovieSortBy.VoteAverageDesc.text
    }
  }
}

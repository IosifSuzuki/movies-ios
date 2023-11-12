//
//  MovieSortOptions.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

struct MovieSortByItem {
  let sortBy: MovieSortBy
  let isSelected: Bool
  let title: String
}

struct MovieSortOptions {
  
  var dataSource: [MovieSortByItem] {
    availableOptions
      .map { movieSortBy in
        MovieSortByItem(
          sortBy: movieSortBy,
          isSelected: movieSortBy == selectedOption,
          title: movieSortBy.title
        )
      }
  }
  
  var selectedOption: MovieSortBy
  
  private var availableOptions: [MovieSortBy] {
    MovieSortBy.allCases
  }
  
  init() {
    selectedOption = .popularityDesc
  }
  
}

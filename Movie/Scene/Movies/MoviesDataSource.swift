//
//  MoviesDataSource.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

class MoviesDataSource {
    
  let availableGenres: AvailableGenres
  var movieSortOptions = MovieSortOptions() {
    willSet {
      moviesPagination.selectedOption = newValue.selectedOption
    }
  }
  
  private let moviesPagination: MoviesPagination
  
  private var searchText: String?
  private var dataSource: [MovieItemViewModel] = []
  private var filteredDataSource: [MovieItemViewModel] {
    guard let searchText, !searchText.isEmpty else {
      return dataSource
    }
    
    return dataSource.filter { movieItemViewModel in
      movieItemViewModel.title.lowercased().contains(searchText.lowercased())
    }
  }
  
  init(moviesPagination: MoviesPagination, availableGenres: AvailableGenres) {
    self.moviesPagination = moviesPagination
    self.availableGenres = availableGenres
  }
  
  // MARK: - Internal
  
  var canLoadMore: Bool {
    let searchText = searchText ?? .init()
    guard searchText.isEmpty else {
      return false
    }
    
    return moviesPagination.canLoadMore
  }
  
  func reset() {
    dataSource = []
    moviesPagination.reset()
  }
  
  func loadMore() async throws {
    guard moviesPagination.canLoadMore else {
      return
    }
    dataSource.append(contentsOf: try await fetchMovies())
  }
  
  func search(by text: String?) {
    searchText = text
  }
  
}

// MARK: - DataSource
extension MoviesDataSource: DataSource {
  
  func numberOfSection() -> Int {
    1
  }
  
  func numberOfRows(in section: Int) -> Int {
    filteredDataSource.count
  }
  
  func item(by indexPath: IndexPath) -> AnyObject? {
    guard filteredDataSource.indices.contains(indexPath.row) else {
      return nil
    }
    return filteredDataSource[indexPath.row] as AnyObject
  }
  
}

// MARK: - Private
private extension MoviesDataSource {
  
  func fetchMovies() async throws -> [MovieItemViewModel] {
    guard moviesPagination.canLoadMore else {
      return []
    }
    let movieItems = try await moviesPagination.loadMore()
    let newDSItems = movieItems.compactMap { movieItem in
      MovieItemViewModel(movieItem: movieItem, availableGenres: availableGenres)
    }
    return newDSItems
  }
  
}
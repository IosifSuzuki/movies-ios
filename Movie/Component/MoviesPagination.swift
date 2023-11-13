//
//  MoviesPagination.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

final class MoviesPagination: Pagination, Identify {
  
  private let movie: APIMovie
  private let logger: Logger
  private var state: PaginationState
  var selectedOption: MovieSortBy = .popularityDesc
  
  init(movies: APIMovie, logger: Logger) {
    self.movie = movies
    self.logger = logger
    self.state = .start
  }
  
  // MARK: - Pagination
  
  var canLoadMore: Bool {
    switch state {
    case .loading, .finish:
      return false
    default:
      return true
    }
  }
  
  func reset() {
    logger.debug(message: "change pagination state to start")
    state = .start
  }
  
  func loadMore() async throws -> [MovieItem] {
    guard !state.isBussy,
          let page = state.nextPage else {
      logger.debug(message: "pagination is bussy")
      return []
    }
    state = .loading(page: page)
    let result: Page<MovieItem>
    do {
      result = try await movie.discoverMovie(page: page, sortBy: selectedOption)
    } catch {
      state = .finish
      throw error
    }
    state = .loaded(page: page)
    if result.page == result.totalPages {
      logger.debug(message: "pagination has reached end")
      state = .finish
    }
    return result.result
  }
  
}

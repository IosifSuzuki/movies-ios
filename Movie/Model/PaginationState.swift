//
//  Pagination.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

enum PaginationState: Equatable {
  case start
  case loading(page: Int)
  case loaded(page: Int)
  case finish
  
  var nextPage: Int? {
    switch self {
    case .start:
      1
    case .loaded(page: let page):
      page + 1
    case .loading, .finish:
      nil
    }
  }
  
  var isBussy: Bool {
    switch self {
    case .start, .loaded:
      false
    case .loading, .finish:
      true
    }
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case let (.loading(page: lhsPage), .loading(page: rhsPage)):
      lhsPage == rhsPage
    case let (.loaded(page: lhsPage), .loaded(page: rhsPage)):
      lhsPage == rhsPage
    case (.finish, .finish), (.start, .start):
      true
    default:
      false
    }
  }
}

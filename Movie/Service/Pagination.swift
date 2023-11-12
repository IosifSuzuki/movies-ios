//
//  Pagination.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

protocol Pagination {
  associatedtype Model
  var canLoadMore: Bool { get }
  func reset()
  func loadMore() async throws -> [Model]
}

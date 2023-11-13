//
//  APIClient.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

protocol APIMovie {
  func discoverMovie(page: Int, sortBy: MovieSortBy) async throws -> Page<MovieItem>
  func genres() async throws -> Genres
  func movie(by id: Int) async throws -> MovieDetail
}

//
//  APIClient.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

protocol APIMovie {
  func discoverMovie() async throws -> Page<MovieItem>
  func genres() async throws -> Genres
}

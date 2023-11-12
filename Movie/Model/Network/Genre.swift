//
//  Genre.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import Foundation

struct Genre: Decodable {
  let id: Int
  let name: String
}

struct Genres: Decodable {
  let genres: [Genre]
}

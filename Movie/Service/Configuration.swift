//
//  Configuration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 29.10.2023.
//

import Foundation

protocol Configuration {
  var baseURL: URL { get }
  var token: String { get }
}

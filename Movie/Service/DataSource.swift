//
//  DataSource.swift
//  Movie
//
//  Created by Bogdan Petkanych on 12.11.2023.
//

import Foundation

protocol DataSource {
  func numberOfSection() -> Int
  func numberOfRows(in section: Int) -> Int
  func item(by indexPath: IndexPath) -> AnyObject?
}

//
//  Logger.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import Foundation

protocol Logger {
  func error(message: String)
  func error(message: Error)
  func error(message: String, err: Error)
  func info(message: String)
  func debug(message: String)
  func warning(message: String)
}

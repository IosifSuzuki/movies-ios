//
//  AvailableGenres.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import Foundation
import RxSwift

protocol AvailableGenres {
  var isRefreshedList: Observable<Bool> { get }
  subscript(int: Int) -> String? { get }
  func reloadList()
}

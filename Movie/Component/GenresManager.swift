//
//  GenresManager.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import Foundation
import RxSwift

class GenresManager: AvailableGenres, Identify {
  
  var isRefreshedList: Observable<Bool> {
    isRefreshedListSubject.asObservable()
  }
  
  private let apiMovie: APIMovie
  private let logger: Logger
  private var dataSource: [Genre] = []
  private let isRefreshedListSubject = BehaviorSubject<Bool>(value: false)
  
  init(logger: Logger, apiMovie: APIMovie) {
    self.logger = logger
    self.apiMovie = apiMovie
  }
  
  subscript(id: Int) -> String? {
    dataSource.first { genre in
      genre.id == id
    }?.name
  }
  
  func reloadList() {
    logger.debug(message: "will perform reload genres list")
    Task {
      do {
        self.isRefreshedListSubject.onNext(false)
        self.dataSource = try await self.apiMovie.genres().genres
        self.isRefreshedListSubject.onNext(true)
        logger.debug(message: "did perform reload genres list")
      } catch {
        logger.error(message: "did perform reload genres list", err: error)
      }
    }
  }
  
}

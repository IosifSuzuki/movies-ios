//
//  ViewModelAssembler.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import Swinject

class ViewModelAssemble: Assembly {
  
  func assemble(container: Container) {
    container.register(MoviesViewModel.self) { resolver in
      let moviesDataSource = resolver.resolve(MoviesDataSource.self)!
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      
      return MoviesViewModel(moviesDS: moviesDataSource, logger: logger)
    }
    container.register(MovieDetailViewModel.self) { (resolver, movieID: Int) in
      let apiMovie = resolver.resolve(APIMovie.self)!
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      
      return MovieDetailViewModel(movieID: movieID, apiMovie: apiMovie, logger: logger)
    }
  }
  
}

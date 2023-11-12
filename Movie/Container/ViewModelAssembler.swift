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
      let moviesPagination = resolver.resolve(MoviesPagination.self)!
      let availableGenres = resolver.resolve(AvailableGenres.self)!
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      
      return MoviesViewModel(moviesPagination: moviesPagination, availableGenres: availableGenres, logger: logger)
    }
  }
  
}

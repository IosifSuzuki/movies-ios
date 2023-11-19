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
      let networkReachability = resolver.resolve(NetworkReachability.self)!
      
      return MoviesViewModel(moviesDS: moviesDataSource, 
                             logger: logger,
                             networkReachability: networkReachability)
    }
    container.register(MovieDetailViewModel.self) { (resolver, movieID: Int) in
      let apiMovie = resolver.resolve(APIMovie.self)!
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      let networkReachability = resolver.resolve(NetworkReachability.self)!
      let movieExternalSource = resolver.resolve(APIMovieConfiguration.self)!
      
      return MovieDetailViewModel(movieID: movieID, 
                                  apiMovie: apiMovie,
                                  logger: logger,
                                  networkReachability: networkReachability, 
                                  movieExternalSource: movieExternalSource)
    }
  }
  
}

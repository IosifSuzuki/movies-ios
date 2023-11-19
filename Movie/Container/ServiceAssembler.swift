//
//  ServiceAssembler.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import Swinject

class ServiceAssemble: Assembly {
  
  func assemble(container: Container) {
    container.register(AppFont.self, name: ModernFont.identifier) { _ in
      return ModernFont()
    }
    container.register(Theme.self, name: ModernTheme.identifier) { resolver in
      let moderFont = resolver.resolve(AppFont.self, name: ModernFont.identifier)!
      
      return ModernTheme(appFont: moderFont)
    }
    container.register(Configuration.self) { _ in
      return AppConfiguration()
    }
    container.register(EndpointRequest.self) { (resolver, endpointConfigurable: EndpointConfigurable) in
      let configuration = resolver.resolve(Configuration.self)!
      
      return EndpointRequest(configuration: configuration, endpoint: endpointConfigurable)
    }
    container.register(LoggerEventMonitor.self) { _ in
      LoggerEventMonitor()
    }
    container.register(APIMovie.self) { resolver in
      let configuration = resolver.resolve(Configuration.self)!
      let loggerEventMonitor = resolver.resolve(LoggerEventMonitor.self)!
      
      return NetworkOperation(configuration: configuration, eventMonitor: loggerEventMonitor)
    }
    container.register(Logger.self, name: AppLogger.identifier) { _ in
      AppLogger()
    }
    container.register(AvailableGenres.self) { resolver in
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      let apiMovie = resolver.resolve(APIMovie.self)!
      
      return GenresManager(logger: logger, apiMovie: apiMovie)
    }.inObjectScope(.container)
    
    container.register(APIMovieConfiguration.self) { resolver in
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      let apiMovie = resolver.resolve(APIMovie.self)!
      
      return MovieConfigManager(logger: logger, apiMovie: apiMovie)
    }.inObjectScope(.container)
    
    container.register(MoviesPagination.self) { resolver in
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      let apiMovie = resolver.resolve(APIMovie.self)!
      
      return MoviesPagination(movies: apiMovie, logger: logger)
    }
    container.register(MoviesDataSource.self) { resolver in
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      let moviesPagination = resolver.resolve(MoviesPagination.self)!
      let availableGenres = resolver.resolve(AvailableGenres.self)!
      let apiMovieConfiguration = resolver.resolve(APIMovieConfiguration.self)!
      
      return MoviesDataSource(moviesPagination: moviesPagination, 
                              availableGenres: availableGenres,
                              movieConfiguration: apiMovieConfiguration,
                              logger: logger)
    }
    container.register(NetworkReachability.self) { resolver in
      let logger = resolver.resolve(Logger.self, name: AppLogger.identifier)!
      
      guard let nrComponent = NRComponent(logger: logger) else {
        fatalError("It has failed initialization NRComponent")
      }
      return nrComponent
    }
  }
  
}

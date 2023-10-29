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
      let apiMovie = resolver.resolve(APIMovie.self)!
      
      return MoviesViewModel(apiMovie: apiMovie)
    }
  }
  
}

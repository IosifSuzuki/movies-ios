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
  }
  
}

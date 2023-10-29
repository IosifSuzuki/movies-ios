//
//  Assembler+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import Swinject

extension Assembler {
  
  static var shared: Assembler = {
    return Assembler([
      ServiceAssemble(),
      ViewModelAssemble(),
      ViewControllerAssemble()
    ], container: Container.sharedContainer)
  }()
  
}

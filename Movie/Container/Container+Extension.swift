//
//  Container+Extension.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import Swinject

extension Container {
  
  static let sharedContainer: Container = {
    let container = Container()
    return container
  }()
  
}

//
//  ViewModel.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

protocol ViewModel {
  associatedtype Input
  associatedtype Output
  
  var title: String? { get }
  
  func transform(input: Input) -> Output
  
}

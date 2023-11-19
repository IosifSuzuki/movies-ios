//
//  APIMovieConfiguration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 19.11.2023.
//

import Foundation
import RxCocoa
import RxSwift

protocol MovieExternalSource {
  func posterMovieImageSizeToFit(_ width: CGFloat) throws -> MovieImageSize
  func posterURL(sourcePath: String, size: MovieImageSize) throws -> URL
}

protocol APIMovieConfiguration: MovieExternalSource {
  var isReady: Observable<Bool> { get }
  
  func fetchConfig()
}

//
//  FontFailure.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation

enum FontFailure: Error {
  case resourcePathForBundleNil
  case registrationFail(String)
  case creationFailed(String)
  case dataNotLoaded(String)
  case notFound(String)
}

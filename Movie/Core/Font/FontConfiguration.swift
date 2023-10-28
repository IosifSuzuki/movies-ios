//
//  FontConfiguration.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import Foundation
import CoreText

class FontConfiguration {
  
  private static func searchAvailableFontsInBundle() throws -> [Font] {
    if let fontFolderPath = Bundle.main.resourcePath {
      let fileManager = FileManager.default
      let files = try fileManager.contentsOfDirectory(atPath: fontFolderPath)
      
      let fonts = files
        .compactMap(Font.init)
      return fonts
    } else {
      throw FontFailure.resourcePathForBundleNil
    }
  }
  
  private static func registerFont(bundle: Bundle, font: Font) throws {
    if let fontURL = bundle.url(forResource: font.name, withExtension: font.extension) {
      if let fontDataProvider = CGDataProvider(url: fontURL as CFURL) {
        if let cgfont = CGFont(fontDataProvider) {
          var error: Unmanaged<CFError>?
          let success = CTFontManagerRegisterGraphicsFont(cgfont, &error)
          if !success {
            throw FontFailure.registrationFail(error?.takeUnretainedValue().localizedDescription ??
              "CTFontManagerRegisterGraphicsFont failed for \(font.name)"
            )
          }
        } else {
          throw FontFailure.creationFailed(font.name)
        }
      } else {
        throw FontFailure.dataNotLoaded(font.name)
      }
    } else {
      throw FontFailure.notFound(font.name)
    }
  }
  
  static func registerFonts() throws {
      try searchAvailableFontsInBundle()
        .forEach {
          try registerFont(bundle: .main, font: $0)
        }
    }
  
}

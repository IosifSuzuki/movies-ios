//
//  AppLogger.swift
//  Movie
//
//  Created by Bogdan Petkanych on 05.11.2023.
//

import Foundation

enum LoggerLevel: String {
  case error          = "[‼️]" // error
  case info           = "[ℹ️]" // info
  case debug          = "[💬]" // debug
  case warning        = "[⚠️]" // warning
}

class AppLogger: Logger, Identify {
  
  func error(message: String) {
    log(level: .error, message: message)
  }
  
  func error(message: Error) {
    error(message: "\(message.localizedDescription)")
  }
  
  func error(message: String, err: Error) {
    error(message: "\(message): \(err.localizedDescription)")
  }
  
  func info(message: String) {
    log(level: .info, message: message)
  }
  
  func debug(message: String) {
    log(level: .debug, message: message)
  }
  
  func warning(message: String) {
    log(level: .warning, message: message)
  }
  
  func log(level: LoggerLevel, message: String) {
    print("\(level.rawValue): \(message)")
  }
  
}

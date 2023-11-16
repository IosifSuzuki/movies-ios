// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Cancel
  public static let cancel = L10n.tr("Localizable", "Cancel", fallback: "Cancel")
  /// Localizable.strings
  ///   Movie
  /// 
  ///   Created by Bogdan Petkanych on 28.10.2023.
  public static let error = L10n.tr("Localizable", "Error", fallback: "Error")
  /// Search
  public static let search = L10n.tr("Localizable", "Search", fallback: "Search")
  public enum MovieSortBy {
    public enum PopularityDesc {
      /// Sort by popularity
      public static let text = L10n.tr("Localizable", "MovieSortBy.popularityDesc.text", fallback: "Sort by popularity")
    }
    public enum RevenueDesc {
      /// Sort by revenue
      public static let text = L10n.tr("Localizable", "MovieSortBy.revenueDesc.text", fallback: "Sort by revenue")
    }
    public enum VoteAverageDesc {
      /// Sort by vote average
      public static let text = L10n.tr("Localizable", "MovieSortBy.voteAverageDesc.text", fallback: "Sort by vote average")
    }
  }
  public enum MoviesViewController {
    /// Popular Movies
    public static let title = L10n.tr("Localizable", "MoviesViewController.title", fallback: "Popular Movies")
    public enum SortBy {
      /// Sort movies by criteria
      public static let text = L10n.tr("Localizable", "MoviesViewController.sortBy.text", fallback: "Sort movies by criteria")
    }
    public enum WatchTheTrailer {
      /// Trailer
      public static let text = L10n.tr("Localizable", "MoviesViewController.watchTheTrailer.text", fallback: "Trailer")
    }
  }
  public enum Offline {
    /// You are offline. Please, enable your Wi-Fi or connect using cellular data.
    public static let message = L10n.tr("Localizable", "Offline.message", fallback: "You are offline. Please, enable your Wi-Fi or connect using cellular data.")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

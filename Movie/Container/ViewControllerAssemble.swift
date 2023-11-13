//
//  ViewControllerAssemble.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject

class ViewControllerAssemble: Assembly {
  
  func assemble(container: Container) {
    container.register(AppNavigationController.self) { (resolver, style: AppNavigationController.Style) in
      let theme = resolver.resolve(Theme.self, name: ModernTheme.identifier)!
      
      return AppNavigationController(theme: theme, style: style)
    }
    container.register(MoviesViewController.self) { resolver in
      let theme = resolver.resolve(Theme.self, name: ModernTheme.identifier)
      let viewModel = resolver.resolve(MoviesViewModel.self)
      
      let viewController = self.unwrapViewController(vcType: MoviesViewController.self)
      viewController.theme = theme
      viewController.viewModel = viewModel
      
      return viewController
    }
    container.register(MovieDetailViewController.self) { (resolver, movieID: Int) in
      let theme = resolver.resolve(Theme.self, name: ModernTheme.identifier)
      let viewModel = resolver.resolve(MovieDetailViewModel.self, argument: movieID)
      
      let viewController = self.unwrapViewController(vcType: MovieDetailViewController.self)
      viewController.theme = theme
      viewController.viewModel = viewModel
      
      return viewController
    }
  }
  
}

private extension ViewControllerAssemble {
  
  func unwrapViewController<VC: UIViewController>(vcType: VC.Type) -> VC {
    let viewController: VC
    do {
      viewController = try self.viewController(vcType: VC.self)
    } catch {
      fatalError(error.localizedDescription)
    }
    return viewController
  }
  
  func viewController<VC: UIViewController>(vcType: VC.Type) throws -> VC {
    let className = String(describing: vcType)
    let suffixVC = "ViewController"
    guard className.hasSuffix(suffixVC) else {
      throw ApplicationError(reason: "each viewcontroller must have suffix \(suffixVC)")
    }
    let storyboardName = className.replacingOccurrences(of: suffixVC, with: "")
    let viewController = UIStoryboard(name: storyboardName, bundle: .main).instantiateInitialViewController() as? VC
    if let viewController {
      return viewController
    }
    throw ApplicationError(reason: "can't cast viewcontroller to expected type")
  }
}

//
//  BaseViewController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject

class BaseViewController<VM: ViewModel>: UIViewController, ThemeDependency {
  
  var viewModel: VM!
  var theme: Theme!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    apply(theme: theme)
    title = viewModel.title
  }
  
  func apply(theme: Theme) {
    view.backgroundColor = theme.backgroundColor
  }
  
  class func initialize() -> Self {
    guard let viewController = Assembler.sharedAssembler.resolver.resolve(Self.self) else {
      fatalError("register your controler in Assembler")
    }
    return viewController
  }
  
}

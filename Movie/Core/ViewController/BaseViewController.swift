//
//  BaseViewController.swift
//  Movie
//
//  Created by Bogdan Petkanych on 28.10.2023.
//

import UIKit
import Swinject
import RxSwift
import RxCocoa

class BaseViewController<VM: BaseViewModel & ViewModel>: UIViewController, ThemeDependency {
  
  var viewModel: VM!
  var theme: Theme!
  
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bindToViewModel()
    setupView()
    apply(theme: theme)
  }
  
  // MARK: - ThemeDependency
  
  func apply(theme: Theme) {
    view.backgroundColor = theme.backgroundColor
  }
  
  // MARK: - Internal
  
  func bindToViewModel() {
    viewModel
      .errorDriver
      .drive(onNext: { [weak self] customerError in
        guard let self else {
          return
        }
        let alertViewController = UIAlertController(
          title: customerError.title,
          message: customerError.description,
          preferredStyle: .alert
        )
        self.present(alertViewController, animated: true)
      })
      .disposed(by: disposeBag)
  }
  
  func setupView() {
    title = viewModel.title
  }
  
  // MARK: - Static
  
  class func initialize() -> Self {
    guard let viewController = Assembler.shared.resolver.resolve(Self.self) else {
      fatalError("register your controler in Assembler")
    }
    return viewController
  }
  
}

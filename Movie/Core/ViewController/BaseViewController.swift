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
  
  private let loaderView = HorizontalGradientLoader()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    bindToViewModel()
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
        let cancelAction = UIAlertAction(title: L10n.cancel, style: .cancel)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true)
      })
      .disposed(by: disposeBag)
    
    viewModel
      .loadingIndicatorDriver
      .drive { [weak self] isLoading in
        if isLoading {
          self?.loaderView.startAnimation()
        } else {
          self?.loaderView.stopAnimation()
        }
      }.disposed(by: disposeBag)
  }
  
  func setupView() {
    title = viewModel.title
    
    setupLoader()
  }
  
  // MARK: - Static methods
  
  class func initialize() -> Self {
    guard let viewController = Assembler.shared.resolver.resolve(Self.self) else {
      fatalError("register your controler in Assembler")
    }
    return viewController
  }
  
  // MARK: - Private methods
  
  private func setupLoader() {
    view.addSubview(loaderView)
    
    loaderView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: loaderView.topAnchor),
      self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: loaderView.leadingAnchor),
      self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: loaderView.trailingAnchor),
      loaderView.heightAnchor.constraint(equalToConstant: 3)
    ])
    
    let gradientColors = UIColor.linearGradientColors(
      from: Asset.Colors.Loader.startColorGradient.color, 
      to: Asset.Colors.Loader.endColorGradient.color,
      length: 50
    ) + UIColor.linearGradientColors(
      from: Asset.Colors.Loader.endColorGradient.color, 
      to: Asset.Colors.Loader.startColorGradient.color, 
      length: 50
    )
    loaderView.duration = 0.01
    loaderView.colors = gradientColors
  }
  
}
